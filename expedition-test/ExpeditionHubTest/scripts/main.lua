-- ============================================================================================
-- ExpeditionHubTest v0.4 — ТЕСТОВЫЙ мод (UE4SS Lua) для Palworld 0.4.11
-- Менеджер экспедиций: ПРОСТАЯ панель на F6. Все станции со всех баз, игровой UI станции
-- по кнопке, запуск-повтор и сбор лута без поездок.
--
-- ЧТО ПОДТВЕРЖДЕНО ТЕСТАМИ v0.2–v0.3:
--   • чтение станций работает (FindAllOf PalMapObjectCharacterTeamMissionModel);
--   • ЗАПУСК РАБОТАЕТ: RequestSelectAuto_ServerInternal(playerId) назначает палов,
--     RequestStartMission_ServerInternal(playerId) стартует экспедицию
--     (playerId = PalPlayerState:GetPlayerId(), у юзера 259). Миссию станция должна
--     уже иметь (TargetMissionId) — выбирается один раз в игровом UI;
--   • OnTriggerInteract(pawn, Open) создаёт игровой HUD-dispatch — кнопка ОТКРЫТЬ UI
--     открывает UI станции удалённо (наша панель закрывается, чтобы не перекрывались);
--   • сбор лута = RequestMoveItemToInventoryFromContainer(сундук станции, false).
--
-- ГЛАВНОЕ В v0.4 — БОРЬБА С КРАШАМИ (pcall НЕ ловит нативные краши, поэтому):
--   1. МОД НИЧЕГО НЕ ХРАНИТ: ни одной ссылки на UObject между действиями. Вообще.
--      (v0.3 падала из-за «захвата» UI-моделей: ссылки переживали уничтожение
--      объектов игрой → висячие указатели → EXCEPTION_ACCESS_VIOLATION);
--   2. никакого NotifyOnNewObject (кроме проверенного хука смены мира);
--   3. отложенные проверки ничего не держат — станции переищиваются заново по индексу;
--   4. одна перерисовка на клик (v0.2 крашилась пересборкой виджетов каждые 3 с);
--   5. UI-модели не создаются вовсе — запуск идёт серверными функциями напрямую.
--
-- УДАЛЕНИЕ: снести папку Mods/ExpeditionHubTest.
-- ============================================================================================

local TAG = "[ExpeditionHub]"

-- ============================== НАСТРОЙКИ (правь тут) ==============================
local Config = {
    OpenKey     = "F6",   -- открыть/закрыть панель
    VerifyMs    = 700,    -- задержка проверки состояния после запуска
    AutoStartMs = 400,    -- пауза между авто-назначением палов и стартом
    OpenUIDelay = 350,    -- пауза между закрытием нашей панели и открытием игровой
    LogLines    = 20,     -- сколько строк лога видно в панели
    LogBuffer   = 120,    -- сколько строк храним всего
}

local STATE_NAMES = { [0] = "None", [1] = "Ready", [2] = "InProgress", [3] = "Reward" }

-- ============================== СОСТОЯНИЕ (только примитивы, НИКАКИХ UObject) ============
local S = {
    sel      = 1,     -- выбранная станция (индекс в FindStations)
    logLines = {},    -- кольцевой буфер лога (строки)
}

-- ============================== ЛОГ ==============================
local function pushLog(line)
    S.logLines[#S.logLines + 1] = tostring(line)
    if #S.logLines > Config.LogBuffer then
        table.remove(S.logLines, 1)
    end
end

local function Log(msg)
    pushLog(msg)
    print(TAG .. " " .. tostring(msg) .. "\n")
end

local function Err(msg)
    pushLog("ОШИБКА: " .. tostring(msg))
    print(TAG .. " ERR: " .. tostring(msg) .. "\n")
end

local function Logf(fmt, ...)
    Log(string.format(fmt, ...))
end

-- ============================== БАЗОВЫЕ ХЕЛПЕРЫ ==============================
local function SafeDo(label, fn)
    if type(label) == "function" then
        local ok, res = pcall(label)
        if not ok then Err(tostring(res)) end
        return ok, res
    end
    local ok, res = pcall(fn)
    if not ok then Err(label .. " → " .. tostring(res)) end
    return ok, res
end

local function hasMethod(obj, name)
    local res = false
    pcall(function() res = (type(obj[name]) == "function") end)
    return res
end

local function Unwrap(v)
    if type(v) == "userdata" or type(v) == "table" then
        if hasMethod(v, "get") then
            local ok, r = pcall(function() return v:get() end)
            if ok and r ~= nil then return r end
        end
    end
    return v
end

local function IsValidObj(o)
    o = Unwrap(o)
    if o == nil then return false end
    local ok, v = pcall(function() return o:IsValid() end)
    return ok and v == true
end

local function ObjName(o)
    o = Unwrap(o)
    if o == nil then return "nil" end
    local ok, n = pcall(function() return o:GetFullName() end)
    if ok and type(n) == "string" then return n end
    ok, n = pcall(function() return o:GetName() end)
    if ok and type(n) == "string" then return n end
    return tostring(o)
end

local function Str(v)
    v = Unwrap(v)
    if v == nil then return nil end
    if type(v) == "string" then return v end
    if type(v) == "number" then return tostring(v) end
    local ok, s = pcall(function() return v:ToString() end)
    if ok and type(s) == "string" then return s end
    ok, s = pcall(function() return tostring(v) end)
    if ok and type(s) == "string" and not s:find("^userdata") then return s end
    return nil
end

local function Num(v)
    v = Unwrap(v)
    if type(v) == "number" then return v end
    if v == nil then return nil end
    local ok, n = pcall(function() return tonumber(v) end)
    if ok and type(n) == "number" then return n end
    ok, n = pcall(function() return tonumber(tostring(v)) end)
    if ok and type(n) == "number" then return n end
    return nil
end

-- чтение свойства объекта/структуры — всегда безопасно (без IsValid-гейта:
-- он врёт на обёртках структур)
local function ReadField(obj, name)
    if obj == nil then return nil end
    local ok, v = pcall(function() return obj[name] end)
    if not ok then return nil end
    return Unwrap(v)
end

local function TryLen(v)
    if v == nil then return nil end
    local ok, n = pcall(function() return #v end)
    if ok and type(n) == "number" then return n end
    ok, n = pcall(function() return v:Length() end)
    if ok and type(n) == "number" then return n end
    ok, n = pcall(function() return v:Num() end)
    if ok and type(n) == "number" then return n end
    return nil
end

local function ArrAt(arr, i)
    local ok, v = pcall(function() return arr[i] end)
    if not ok then return nil end
    return Unwrap(v)
end

-- массив → обычная Lua-таблица (или nil); LocalUnrealParam разворачивается
local function ArrayToTable(v)
    if v == nil then return nil end
    v = Unwrap(v)
    local n = TryLen(v)
    if n == nil then
        local t = {}
        local i = 1
        while i <= 200 do
            local ok, item = pcall(function() return v[i] end)
            if not ok or item == nil then break end
            t[i] = Unwrap(item)
            i = i + 1
        end
        if #t > 0 then return t end
        return nil
    end
    local t = {}
    for i = 1, n do
        t[i] = ArrAt(v, i)
    end
    return t
end

local function DelayCall(ms, fn)
    local ok, err = pcall(ExecuteWithDelay, ms, fn)
    if not ok then Err("ExecuteWithDelay → " .. tostring(err)) end
end

-- ============================== ПОИСК ОБЪЕКТОВ (каждый раз заново) ==============================
local function FindStations()
    local found = {}
    SafeDo("FindAllOf(PalMapObjectCharacterTeamMissionModel)", function()
        local all = FindAllOf("PalMapObjectCharacterTeamMissionModel")
        if not all then return end
        for _, m in ipairs(all) do
            local mo = Unwrap(m)
            if IsValidObj(mo) then
                local fn = ObjName(mo)
                if not fn:find("Default__", 1, true) then
                    found[#found + 1] = mo
                end
            end
        end
    end)
    table.sort(found, function(a, b) return ObjName(a) < ObjName(b) end)
    return found
end

local function GetNetComp()
    local result = nil
    SafeDo("FindAllOf(PalNetworkPlayerComponent)", function()
        local all = FindAllOf("PalNetworkPlayerComponent")
        if not all then return end
        for _, m in ipairs(all) do
            local mo = Unwrap(m)
            if IsValidObj(mo) and not ObjName(mo):find("Default__", 1, true) then
                result = mo
                break
            end
        end
    end)
    return result
end

local function GetLocalPlayerController()
    local result = nil
    SafeDo("FindAllOf(PalPlayerController)", function()
        local all = FindAllOf("PalPlayerController")
        if not all then return end
        for _, m in ipairs(all) do
            local mo = Unwrap(m)
            if IsValidObj(mo) and not ObjName(mo):find("Default__", 1, true) then
                result = mo
                break
            end
        end
    end)
    return result
end

-- playerId для ServerInternal-функций (подтверждено тестом: 259)
local function GetLocalPlayerId()
    local pc = GetLocalPlayerController()
    if not pc then return nil, "нет PlayerController" end
    local ok, ps = pcall(function() return pc:GetPalPlayerState() end)
    if ok and ps ~= nil then
        ps = Unwrap(ps)
        if IsValidObj(ps) then
            local okI, id = pcall(function() return ps:GetPlayerId() end)
            if okI then return Num(id), "PalPlayerState:GetPlayerId()" end
        end
    end
    local ps2 = ReadField(pc, "PlayerState")
    if IsValidObj(ps2) then
        local okI, id = pcall(function() return ps2:GetPlayerId() end)
        if okI then return Num(id), "PlayerState:GetPlayerId()" end
    end
    return nil, "PlayerState не найден"
end

local function GetLocalPawn()
    local pc = GetLocalPlayerController()
    if not pc then return nil end
    local ok, pawn = pcall(function() return pc:K2_GetPawn() end)
    if ok and pawn ~= nil then
        pawn = Unwrap(pawn)
        if IsValidObj(pawn) then return pawn end
    end
    return nil
end

-- ============================== ЧТЕНИЕ СОСТОЯНИЙ ==============================
local function GetState(st)
    local v = ReadField(st, "State")
    local n = Num(v)
    if n ~= nil then
        local i = math.floor(n)
        return i, (STATE_NAMES[i] or ("?" .. tostring(n)))
    end
    return nil, Str(v)
end

local function GetBaseName(st)
    local ok, bcm = pcall(function() return st:GetBaseCampModelBelongTo() end)
    if ok and bcm ~= nil then
        bcm = Unwrap(bcm)
        if IsValidObj(bcm) then
            local okN, name = pcall(function() return bcm:GetBaseCampName() end)
            if okN then
                local s = Str(name)
                if s and s ~= "" then return s end
            end
            return Str(ReadField(bcm, "BaseCampName")) or "?"
        end
    end
    return nil
end

local function GetLoc(st)
    local out = {}
    local ok = pcall(function() st:GetMapObjectLocation(out) end)
    if not ok then return nil end
    local v = Unwrap(out.outVector or out.OutVector or out[1])
    if v == nil then return nil end
    local x = Num(ReadField(v, "X"))
    local y = Num(ReadField(v, "Y"))
    if x == nil then return nil end
    return { x = x, y = y, z = Num(ReadField(v, "Z")) }
end

-- сундук станции: прямое чтение поля TargetContainer, затем функции
local function GetStationContainer(st)
    local ok, mod = pcall(function() return st:GetItemContainerModule() end)
    if not ok then return nil, "GetItemContainerModule → " .. tostring(mod) end
    mod = Unwrap(mod)
    if not IsValidObj(mod) then return nil, "item container module = nil/invalid" end

    local tc = ReadField(mod, "TargetContainer")
    if IsValidObj(tc) then return tc, "module.TargetContainer" end

    local okC, cont = pcall(function() return mod:GetContainer() end)
    if okC and cont ~= nil then
        cont = Unwrap(cont)
        if IsValidObj(cont) then return cont, "GetContainer" end
    end

    local out = {}
    local okT = pcall(function() return mod:TryGetContainer(out) end)
    if okT then
        local c = Unwrap(out.OutContainer or out.outContainer or out[1])
        if IsValidObj(c) then return c, "TryGetContainer" end
    end
    return nil, "контейнера нет (у станции без награды это норма)"
end

local function CountChest(cont)
    if not IsValidObj(cont) then return 0, 0 end
    local slots = ArrayToTable(ReadField(cont, "ItemSlotArray"))
    local total = slots and #slots or 0
    local used = 0
    if slots then
        for i = 1, total do
            local slot = slots[i]
            if IsValidObj(slot) then
                local empty = true
                pcall(function() empty = (slot:IsEmpty() == true) end)
                if not empty then used = used + 1 end
            end
        end
    end
    return used, total
end

local function DumpContainer(label, cont)
    if not IsValidObj(cont) then
        Log(label .. ": контейнер невалиден")
        return
    end
    local slots = ArrayToTable(ReadField(cont, "ItemSlotArray"))
    if not slots then
        Log(label .. ": ItemSlotArray не читается")
        return
    end
    local used = 0
    for i = 1, #slots do
        local slot = slots[i]
        if IsValidObj(slot) then
            local empty = true
            pcall(function() empty = (slot:IsEmpty() == true) end)
            if not empty then
                used = used + 1
                local itemId = ReadField(slot, "ItemId")
                local sid = itemId and Str(ReadField(itemId, "StaticId")) or "?"
                local cnt = Num(ReadField(slot, "StackCount"))
                Logf("%s: слот %d — %s x%s", label, i, tostring(sid), tostring(cnt))
            end
        end
    end
    if used == 0 then Log(label .. ": сундук ПУСТ (" .. tostring(#slots) .. " слотов)") end
end

-- ============================== ДЕЙСТВИЯ ==============================
local refreshIfOpen  -- назначается после сборки UI
local Presenter_Close -- forward declaration (DoOpenGameUI закрывает панель; определена в секции GUI)

local function SelectedStation()
    local stations = FindStations()
    if #stations == 0 then return nil, 0 end
    if S.sel < 1 or S.sel > #stations then S.sel = 1 end
    return stations[S.sel], #stations
end

local function StationDetailLines()
    local st, total = SelectedStation()
    if not st then return { "СТАНЦИЙ НЕ НАЙДЕНО — построй станцию или перезайди" }, 0 end
    local lines = {}
    local _, sname = GetState(st)
    local tmid = Str(ReadField(st, "TargetMissionId"))
    lines[#lines + 1] = string.format("СОСТОЯНИЕ: %s     МИССИЯ: %s", tostring(sname), tostring(tmid))
    local loc = GetLoc(st)
    local locStr = loc and string.format("     коорд: (%.0f, %.0f)", loc.x, loc.y) or ""
    lines[#lines + 1] = string.format("БАЗА: %s%s", tostring(GetBaseName(st) or "?"), locStr)
    local ai = ReadField(st, "AssignedInfo")
    local rep = ai and ReadField(ai, "RepInfoArray") or nil
    local items = rep and ArrayToTable(ReadField(rep, "Items")) or nil
    local cont = GetStationContainer(st)
    local used, totalSlots = 0, 0
    if cont then used, totalSlots = CountChest(cont) end
    lines[#lines + 1] = string.format("ПАЛЫ: %s     СУНДУК: %s", tostring(items and #items or nil),
        (cont and string.format("занято %d из %d", used, totalSlots)) or "нет (норма без награды)")
    return lines, total
end

-- ЗАПУСК: повторить миссию станции (ServerInternal-путь, подтверждён тестом v0.3)
local function DoLaunchRepeat()
    local st = SelectedStation()
    if not st then return end
    local tmid = Str(ReadField(st, "TargetMissionId"))
    if tmid == nil or tmid == "None" or tmid == "" then
        Log("ЗАПУСК: у станции НЕ выбрана миссия — открой игровой UI (первая кнопка) и выбери её один раз")
        return
    end
    local pid, psrc = GetLocalPlayerId()
    if pid == nil then
        Err("playerId не получен: " .. tostring(psrc))
        return
    end
    Logf("ЗАПУСК станции %d: миссия '%s', авто-палы → старт (playerId=%s)", S.sel, tmid, tostring(pid))

    -- шаг 1: авто-назначение палов (объект переищивается, ничего не храним)
    SafeDo("RequestSelectAuto_ServerInternal", function()
        local st1 = SelectedStation()
        if st1 then st1:RequestSelectAuto_ServerInternal(pid) end
    end)
    -- шаг 2: старт (пауза, как в подтверждённом фолбэке)
    DelayCall(Config.AutoStartMs, function()
        SafeDo("RequestStartMission_ServerInternal", function()
            local st2 = SelectedStation()
            if st2 then st2:RequestStartMission_ServerInternal(pid) end
        end)
        -- шаг 3: проверка (станция переищивается заново)
        DelayCall(Config.VerifyMs, function()
            SafeDo("проверка после запуска", function()
                local st3 = SelectedStation()
                if st3 then
                    local _, sname = GetState(st3)
                    local ai = ReadField(st3, "AssignedInfo")
                    local rep = ai and ReadField(ai, "RepInfoArray") or nil
                    local items = rep and ArrayToTable(ReadField(rep, "Items")) or nil
                    Logf("итог: state=%s, палов=%s", tostring(sname), tostring(items and #items or nil))
                    if refreshIfOpen then refreshIfOpen() end
                end
            end)
        end)
    end)
end

-- ОТКРЫТЬ игровой UI станции: сначала закрыть нашу панель (чтобы не перекрывались),
-- затем дёрнуть OnTriggerInteract станции с пешкой игрока
local function DoOpenGameUI()
    local sel = S.sel
    local _, total = SelectedStation()
    if total == 0 then return end
    Log("ОТКРЫТЬ UI: закрываю панель, открываю игровой UI станции " .. sel)
    Presenter_Close()
    DelayCall(Config.OpenUIDelay, function()
        SafeDo("OnTriggerInteract", function()
            local stations = FindStations()
            local st = stations[sel]
            if not IsValidObj(st) then
                Err("станция " .. sel .. " пропала — обнови список")
                return
            end
            local pawn = GetLocalPawn()
            if not pawn then
                Err("не найдена пешка игрока (Pawn)")
                return
            end
            local ok, res = pcall(function() return st:OnTriggerInteract(pawn, 4) end)
            Log("OnTriggerInteract: " .. ((ok and "вызван — игровой UI станции должен открыться")
                or ("FAIL → " .. tostring(res))))
        end)
    end)
end

-- сбор лута одной станции (переищивается по индексу)
local function DoCollectOne(idx)
    local stations = FindStations()
    local st = stations[idx]
    if not IsValidObj(st) then
        Err("станция " .. idx .. " не найдена")
        return
    end
    local _, sname = GetState(st)
    if sname ~= "Reward" then
        Log("станция " .. idx .. ": state=" .. tostring(sname) .. " — лут ещё не готов (нужен Reward)")
        return
    end
    local cont, why = GetStationContainer(st)
    if not cont then
        Err("станция " .. idx .. ": " .. tostring(why))
        return
    end
    local net = GetNetComp()
    if not net then
        Err("PalNetworkPlayerComponent не найден")
        return
    end
    DumpContainer("ДО сбора (ст." .. idx .. ")", cont)
    Log("RequestMoveItemToInventoryFromContainer …")
    local ok, res = pcall(function() return net:RequestMoveItemToInventoryFromContainer(cont, false) end)
    if not ok then
        Err("RequestMoveItemToInventoryFromContainer → " .. tostring(res))
        return
    end
    DelayCall(600, function()
        SafeDo("проверка после сбора", function()
            local st2 = FindStations()[idx]
            if IsValidObj(st2) then
                local cont2 = GetStationContainer(st2)
                if cont2 then DumpContainer("ПОСЛЕ сбора (ст." .. idx .. ")", cont2) end
                if refreshIfOpen then refreshIfOpen() end
            end
        end)
    end)
end

local function DoCollect()
    local _, total = SelectedStation()
    if total == 0 then return end
    Log("=== СОБРАТЬ ЛУТ: станция " .. S.sel .. " ===")
    DoCollectOne(S.sel)
end

local function DoCollectAll()
    local stations = FindStations()
    local targets = {}
    for i, st in ipairs(stations) do
        local _, sname = GetState(st)
        if sname == "Reward" then targets[#targets + 1] = i end
    end
    if #targets == 0 then
        Log("СОБРАТЬ ВСЁ: нет станций в состоянии Reward")
        return
    end
    Logf("=== СОБРАТЬ ВСЁ: станций с наградой: %d (%s) ===", #targets, table.concat(targets, ", "))
    for k, i in ipairs(targets) do
        DelayCall(250 * k, function()
            SafeDo("collect ст." .. i, function() DoCollectOne(i) end)
        end)
    end
end

-- ============================================================================================
--  GUI (каркас проверен в TowerHunter / Relic Collector)
-- ============================================================================================

local function hexToLinearColor(hexStr, alpha)
    local cleanHex = hexStr:gsub("#", "")
    local r = tonumber(cleanHex:sub(1, 2), 16) / 255.0
    local g = tonumber(cleanHex:sub(3, 4), 16) / 255.0
    local b = tonumber(cleanHex:sub(5, 6), 16) / 255.0
    local function srgbToLinear(val)
        if val <= 0.04045 then return val / 12.92 end
        return ((val + 0.055) / 1.055) ^ 2.4
    end
    return { srgbToLinear(r), srgbToLinear(g), srgbToLinear(b), alpha or 1.0 }
end

local Theme = {
    PanelBase     = hexToLinearColor("#131A1D", 0.95),
    PanelHeader   = hexToLinearColor("#26333A", 1.00),
    PanelSection  = hexToLinearColor("#192226", 0.90),
    CardActive    = hexToLinearColor("#1D2D2A", 0.96),
    Divider       = hexToLinearColor("#314046", 1.00),
    BorderDefault = hexToLinearColor("#42555C", 1.00),
    TextPrimary   = hexToLinearColor("#EAF2F6", 1.00),
    TextSecond    = hexToLinearColor("#9DB0B9", 1.00),
    TextDim       = hexToLinearColor("#6C808A", 1.00),
    Gold          = hexToLinearColor("#FFC53D", 1.00),
    Green         = hexToLinearColor("#4ADE80", 1.00),
    Red           = hexToLinearColor("#F87171", 1.00),
}

local Assets = {
    WindowBlueprint = "/Game/Pal/Blueprint/UI/UserInterface/Common/WBP_PalCommonWindow.WBP_PalCommonWindow_C",
    ButtonBlueprint = "/Game/Pal/Blueprint/UI/UserInterface/Common/WBP_CommonButton_Activation.WBP_CommonButton_Activation_C",
    DefaultFont     = "/Game/Pal/Font/Ft_PalDefaultFont.Ft_PalDefaultFont",
    OverallLayout   = "WBP_PalOverallUILayout_C",
    HostPanelName   = "CanvasPanel_Root",
}

local ObjectCache = {}

local function resolveStaticObject(path)
    if ObjectCache[path] and IsValidObj(ObjectCache[path]) then
        return ObjectCache[path]
    end
    local obj = StaticFindObject(path)
    if not IsValidObj(obj) then
        pcall(LoadAsset, path)
        obj = StaticFindObject(path)
    end
    if IsValidObj(obj) then
        ObjectCache[path] = obj
        return obj
    end
    return nil
end

local ClickDispatcher = {
    subscribers = {},
    hookActive  = false,
}

function ClickDispatcher.Subscribe(buttonWidget, callback)
    if not IsValidObj(buttonWidget) or not callback then return end
    if not ClickDispatcher.hookActive then
        ClickDispatcher.hookActive = true
        pcall(function()
            RegisterHook("/Script/CommonUI.CommonButtonBase:HandleButtonClicked", function(self)
                local okGet, widget = pcall(function() return self:get() end)
                if not okGet or not widget then return end
                local okName, fullName = pcall(function() return widget:GetFullName() end)
                if not okName or not fullName then return end
                local handler = ClickDispatcher.subscribers[fullName]
                if handler then pcall(handler) end
            end)
        end)
    end
    local okName, name = pcall(function() return buttonWidget:GetFullName() end)
    if okName and name then
        ClickDispatcher.subscribers[name] = callback
    end
end

function ClickDispatcher.Reset()
    ClickDispatcher.subscribers = {}
end

-- ------------------------------- Factory ---------------------------------
local Factory = {}

function Factory.CreateText(tree, message, fontSize, colorTuple, boldFont, justify)
    local cls = resolveStaticObject("/Script/UMG.TextBlock")
    if not cls then return nil end
    local widget = StaticConstructObject(cls, tree)
    if not IsValidObj(widget) then return nil end
    widget:SetText(FText(message or ""))
    widget:SetRenderOpacity(1.0)
    pcall(function()
        local fontInfo = widget.Font
        fontInfo.Size = fontSize or 11
        local fontAsset = resolveStaticObject(Assets.DefaultFont)
        if fontAsset then
            fontInfo.FontObject = fontAsset
            fontInfo.TypefaceFontName = FName(boldFont and "Bold" or "Medium")
        end
        widget.Font = fontInfo
    end)
    if colorTuple then
        pcall(function()
            local c = widget.ColorAndOpacity
            c.SpecifiedColor.R = colorTuple[1]
            c.SpecifiedColor.G = colorTuple[2]
            c.SpecifiedColor.B = colorTuple[3]
            c.SpecifiedColor.A = colorTuple[4] or 1.0
            widget.ColorAndOpacity = c
        end)
    end
    if justify then pcall(function() widget:SetJustification(justify) end) end
    pcall(function() widget:SetClipping(0) end)
    return widget
end

function Factory.CreateSolidBorder(tree, colorTuple)
    local cls = resolveStaticObject("/Script/UMG.Border")
    if not cls then return nil end
    local border = StaticConstructObject(cls, tree)
    if not IsValidObj(border) then return nil end
    border:SetRenderOpacity(1.0)
    pcall(function()
        local brush = border.BrushColor
        brush.R = colorTuple[1]
        brush.G = colorTuple[2]
        brush.B = colorTuple[3]
        brush.A = colorTuple[4] or 1.0
        border:SetBrushColor(brush)
    end)
    return border
end

function Factory.AnchorWidget(parentCanvas, childWidget, x, y, w, h, zOrder)
    if not childWidget or not parentCanvas then return end
    local slot = parentCanvas:AddChildToCanvas(childWidget)
    if not IsValidObj(slot) then return end
    slot:SetAutoSize(false)
    local pos = slot:GetPosition()
    pos.X, pos.Y = math.floor(x), math.floor(y)
    slot:SetPosition(pos)
    local size = slot:GetSize()
    size.X, size.Y = math.floor(w), math.floor(h)
    slot:SetSize(size)
    slot:SetZOrder(zOrder or 0)
end

function Factory.AnchorCenter(parentCanvas, childWidget, w, h)
    if not childWidget or not parentCanvas then return end
    local slot = parentCanvas:AddChildToCanvas(childWidget)
    if not IsValidObj(slot) then return end
    slot:SetAutoSize(false)
    local anchors = slot:GetAnchors()
    anchors.Minimum.X, anchors.Minimum.Y = 0.5, 0.5
    anchors.Maximum.X, anchors.Maximum.Y = 0.5, 0.5
    slot:SetAnchors(anchors)
    local align = slot:GetAlignment()
    align.X, align.Y = 0.5, 0.5
    slot:SetAlignment(align)
    local pos = slot:GetPosition()
    pos.X, pos.Y = 0, 0
    slot:SetPosition(pos)
    local size = slot:GetSize()
    size.X, size.Y = w, h
    slot:SetSize(size)
end

function Factory.DrawFrame(canvas, tree, x, y, w, h, color)
    local function line(lx, ly, lw, lh)
        local b = Factory.CreateSolidBorder(tree, color)
        if b then Factory.AnchorWidget(canvas, b, lx, ly, lw, lh, 1) end
    end
    line(x, y, w, 1)
    line(x, y + h - 1, w, 1)
    line(x, y, 1, h)
    line(x + w - 1, y, 1, h)
end

-- ------------------------------- Engine ----------------------------------
local Engine = {}

function Engine.LocateMainLayout()
    local ok, instances = pcall(FindAllOf, Assets.OverallLayout)
    if ok and instances and #instances > 0 then return instances[1] end
    return nil
end

function Engine.FindHostCanvas(outerFullName, panelName)
    local ok, canvasList = pcall(FindAllOf, "CanvasPanel")
    if not ok or not canvasList then return nil end
    local needle = "." .. panelName
    for _, canvas in ipairs(canvasList) do
        if IsValidObj(canvas) then
            local okName, name = pcall(function() return canvas:GetFullName() end)
            if okName and name and name:sub(-#needle) == needle then
                local okOuter, outerObj = pcall(function() return canvas:GetOuter() end)
                if okOuter and IsValidObj(outerObj) then
                    local okOuterName, outerName = pcall(function() return outerObj:GetFullName() end)
                    if okOuterName and outerName == outerFullName then
                        return canvas
                    end
                end
            end
        end
    end
    return nil
end

function Engine.DiscoverNamedSlot(windowObj)
    local okTree, tree = pcall(function() return windowObj.WidgetTree end)
    if not okTree or not IsValidObj(tree) then return nil end
    local okRoot, root = pcall(function() return tree.RootWidget end)
    if not okRoot or not IsValidObj(root) then return nil end
    local okCount, count = pcall(function() return root:GetChildrenCount() end)
    if not okCount or not count then return nil end
    for idx = 0, count - 1 do
        local okChild, child = pcall(function() return root:GetChildAt(idx) end)
        if okChild and IsValidObj(child) then
            local okName, name = pcall(function() return child:GetFullName() end)
            if okName and name and name:match("^NamedSlot%s") then
                return child
            end
        end
    end
    return nil
end

function Engine.MuteUnusedChrome(windowObj)
    local slot = Engine.DiscoverNamedSlot(windowObj)
    if not slot then return end
    local okName, slotFullName = pcall(function() return slot:GetFullName() end)
    if not okName then return end
    local okTree, tree = pcall(function() return windowObj.WidgetTree end)
    if not okTree or not IsValidObj(tree) then return end
    local okRoot, root = pcall(function() return tree.RootWidget end)
    if not okRoot or not IsValidObj(root) then return end
    local okCount, count = pcall(function() return root:GetChildrenCount() end)
    if not okCount or not count then return end
    for idx = 0, count - 1 do
        local okChild, child = pcall(function() return root:GetChildAt(idx) end)
        if okChild and IsValidObj(child) then
            local okChildName, childName = pcall(function() return child:GetFullName() end)
            if okChildName and childName ~= slotFullName then
                pcall(function() child:SetVisibility(1) end)
            end
        end
    end
end

function Engine.AcquireModalSurface()
    local layout = Engine.LocateMainLayout()
    if not IsValidObj(layout) then return nil end
    local ok, modalLayer = pcall(function() return layout.Modal end)
    if ok and IsValidObj(modalLayer) then return modalLayer end
    return nil
end

-- ------------------------------- окно ----------------------------------
local UI_W = 1000
local UI_H = 800
local PAD  = 16

local State = {
    activeShell   = nil,
    activeSurface = nil,
    widgetTree    = nil,
    hostCanvas    = nil,
    isDisplayed   = false,
}

local function assembleModalFrame(panel, tree, frameWidth, frameHeight)
    local winCls     = resolveStaticObject(Assets.WindowBlueprint)
    local canvasCls  = resolveStaticObject("/Script/UMG.CanvasPanel")
    local sizeBoxCls = resolveStaticObject("/Script/UMG.SizeBox")
    local widgetLib  = resolveStaticObject("/Script/UMG.Default__WidgetBlueprintLibrary")
    local modalHost  = Engine.AcquireModalSurface()

    if not winCls or not canvasCls or not sizeBoxCls or not widgetLib or not modalHost then
        Err("core UMG classes missing for modal")
        return nil
    end

    local frameShell, contentSurface
    local ok, err = pcall(function()
        local player = panel:GetOwningPlayer()
        frameShell = modalHost:BP_AddWidget(winCls)
        if not IsValidObj(frameShell) then error("Modal host rejected widget") end

        Engine.MuteUnusedChrome(frameShell)
        local shellSlot = Engine.DiscoverNamedSlot(frameShell)
        if not shellSlot then error("Shell slot missing") end

        local innerWindow = widgetLib:Create(panel, winCls, player)
        if not IsValidObj(innerWindow) then error("Inner window failed") end

        local innerSlot = Engine.DiscoverNamedSlot(innerWindow)
        if not innerSlot then error("Inner slot missing") end

        contentSurface = StaticConstructObject(canvasCls, tree)
        local frameBox = StaticConstructObject(sizeBoxCls, tree)
        frameBox:SetWidthOverride(frameWidth)
        frameBox:SetHeightOverride(frameHeight)
        frameBox:SetContent(contentSurface)
        innerSlot:SetContent(frameBox)

        local hostCanvas = StaticConstructObject(canvasCls, tree)
        shellSlot:SetContent(hostCanvas)
        Factory.AnchorCenter(hostCanvas, innerWindow, frameWidth, frameHeight)
    end)

    if not ok or not IsValidObj(frameShell) then
        Err("assembleModalFrame err: " .. tostring(err))
        return nil
    end

    pcall(function()
        local blurCls = resolveStaticObject("/Script/UMG.BackgroundBlur")
        if blurCls then
            local blur = StaticConstructObject(blurCls, tree)
            if IsValidObj(blur) then
                blur:SetRenderOpacity(1.0)
                pcall(function() blur:SetBlurStrength(6.0) end)
                Factory.AnchorWidget(contentSurface, blur, 0, 0, frameWidth, frameHeight, 0)
            end
        end
        local base = Factory.CreateSolidBorder(tree, Theme.PanelBase)
        if base then Factory.AnchorWidget(contentSurface, base, 0, 0, frameWidth, frameHeight, 1) end
    end)

    return { shell = frameShell, surface = contentSurface }
end

local function createGameButton(hostCanvas, surface, tree, label, x, y, w, h, onClick, z)
    local btnCls    = resolveStaticObject(Assets.ButtonBlueprint)
    local widgetLib = resolveStaticObject("/Script/UMG.Default__WidgetBlueprintLibrary")
    if not btnCls or not widgetLib then return nil end

    local ok, btn = pcall(function()
        local owner = hostCanvas:GetOwningPlayer()
        local b = widgetLib:Create(hostCanvas, btnCls, owner)
        if not IsValidObj(b) then error("button create failed") end
        pcall(function() b:Setup(false) end)
        pcall(function() b:SetText(FText(label)) end)
        return b
    end)
    if not ok or not IsValidObj(btn) then return nil end

    Factory.AnchorWidget(surface, btn, x, y, w, h, z or 60)

    local target = btn
    local okIn, inner = pcall(function() return btn.WBP_PalInvisibleButton end)
    if okIn and IsValidObj(inner) then target = inner end
    ClickDispatcher.Subscribe(target, onClick)

    return btn
end

-- ------------------------------- отрисовка ----------------------------------
local function renderAllContent()
    if not IsValidObj(State.activeSurface) or not IsValidObj(State.widgetTree) then return end

    local surface    = State.activeSurface
    local tree       = State.widgetTree
    local hostCanvas = State.hostCanvas
    local contentW   = UI_W - PAD * 2

    pcall(function() surface:ClearChildren() end)
    ClickDispatcher.Reset()

    local blurCls = resolveStaticObject("/Script/UMG.BackgroundBlur")
    if blurCls then
        local blur = StaticConstructObject(blurCls, tree)
        if IsValidObj(blur) then
            pcall(function() blur:SetBlurStrength(6.0) end)
            Factory.AnchorWidget(surface, blur, 0, 0, UI_W, UI_H, 0)
        end
    end
    local base = Factory.CreateSolidBorder(tree, Theme.PanelBase)
    if base then Factory.AnchorWidget(surface, base, 0, 0, UI_W, UI_H, 1) end

    -- ===== header (16..62) =====
    local headerH = 46
    local headerBg = Factory.CreateSolidBorder(tree, Theme.PanelHeader)
    if headerBg then Factory.AnchorWidget(surface, headerBg, PAD, PAD, contentW, headerH, 5) end
    Factory.DrawFrame(surface, tree, PAD, PAD, contentW, headerH, Theme.BorderDefault)
    local goldLine = Factory.CreateSolidBorder(tree, Theme.Gold)
    if goldLine then Factory.AnchorWidget(surface, goldLine, PAD, PAD + headerH - 2, contentW, 2, 6) end
    local title = Factory.CreateText(tree, "EXPEDITION HUB", 16, Theme.TextPrimary, true, 0)
    if title then Factory.AnchorWidget(surface, title, PAD + 16, PAD + 12, 380, 24, 7) end
    local _, stationTotal = SelectedStation()
    local sub = Factory.CreateText(tree, string.format("станций: %d", stationTotal), 12, Theme.TextSecond, false, 2)
    if sub then Factory.AnchorWidget(surface, sub, PAD + contentW - 320, PAD + 15, 200, 16, 7) end
    createGameButton(hostCanvas, surface, tree, "ОБНОВИТЬ", PAD + contentW - 110, PAD + 7, 94, 32, function()
        renderAllContent()
    end, 60)

    -- ===== селектор станции (70..124) =====
    local selY, selH = 70, 54
    local selBg = Factory.CreateSolidBorder(tree, Theme.PanelSection)
    if selBg then Factory.AnchorWidget(surface, selBg, PAD, selY, contentW, selH, 5) end
    Factory.DrawFrame(surface, tree, PAD, selY, contentW, selH, Theme.Divider)

    createGameButton(hostCanvas, surface, tree, "<< PREV", PAD + 16, selY + 10, 110, 34, function()
        local _, total = SelectedStation()
        if total > 0 then
            S.sel = (S.sel - 2) % total + 1
        end
        renderAllContent()
    end, 60)
    local selText = Factory.CreateText(tree,
        string.format("СТАНЦИЯ  %d / %d", (stationTotal > 0 and S.sel) or 0, stationTotal), 13, Theme.Gold, true, 1)
    if selText then Factory.AnchorWidget(surface, selText, PAD + 140, selY + 15, 240, 20, 7) end
    createGameButton(hostCanvas, surface, tree, "NEXT >>", PAD + contentW - 126, selY + 10, 110, 34, function()
        local _, total = SelectedStation()
        if total > 0 then
            S.sel = S.sel % total + 1
        end
        renderAllContent()
    end, 60)

    -- ===== детали станции (132..220) =====
    local detY, detH = 132, 88
    local detBg = Factory.CreateSolidBorder(tree, Theme.PanelSection)
    if detBg then Factory.AnchorWidget(surface, detBg, PAD, detY, contentW, detH, 5) end
    Factory.DrawFrame(surface, tree, PAD, detY, contentW, detH, Theme.Divider)
    local detLines = StationDetailLines()
    for i, lineTxt in ipairs(detLines) do
        local t = Factory.CreateText(tree, lineTxt, 11, Theme.TextPrimary, false, 0)
        if t then Factory.AnchorWidget(surface, t, PAD + 16, detY + 8 + (i - 1) * 18, contentW - 32, 17, 7) end
    end

    -- ===== 4 большие кнопки (232..364) =====
    local btnY = 232
    local bigW = (contentW - 32 - 12) / 2
    local bigH = 58
    local bigBtns = {
        { "ОТКРЫТЬ UI ЭКСПЕДИЦИИ (как в игре)", DoOpenGameUI },
        { "ЗАПУСК — ПОВТОРИТЬ МИССИЮ", DoLaunchRepeat },
        { "СОБРАТЬ ЛУТ (эта станция)", DoCollect },
        { "СОБРАТЬ ВЕСЬ ЛЮТ (все станции)", DoCollectAll },
    }
    for i, def in ipairs(bigBtns) do
        local row = math.floor((i - 1) / 2)
        local col = (i - 1) % 2
        local label, fn = def[1], def[2]
        createGameButton(hostCanvas, surface, tree, label,
            PAD + 16 + col * (bigW + 12), btnY + row * (bigH + 12), bigW, bigH, function()
                SafeDo("btn:" .. tostring(label), fn)
                -- одна перерисовка на клик; ОТКРЫТЬ UI панель сам закрывает
                if State.isDisplayed then renderAllContent() end
            end, 60)
    end

    -- ===== подсказка (372..392) =====
    local hint = Factory.CreateText(tree,
        "Выбор миссии и палов — в игровом UI (первая кнопка, панель сама закроется). ЗАПУСК повторяет выбранную миссию с авто-палами. Сбор работает при состоянии Reward.",
        10, Theme.TextDim, false, 0)
    if hint then Factory.AnchorWidget(surface, hint, PAD + 16, 374, contentW - 32, 30, 7) end

    -- ===== лог (402..744) =====
    local logY, logH = 402, 342
    local logBg = Factory.CreateSolidBorder(tree, Theme.PanelSection)
    if logBg then Factory.AnchorWidget(surface, logBg, PAD, logY, contentW, logH, 5) end
    Factory.DrawFrame(surface, tree, PAD, logY, contentW, logH, Theme.Divider)
    local logTitle = Factory.CreateText(tree, "ЛОГ:", 10, Theme.TextDim, true, 0)
    if logTitle then Factory.AnchorWidget(surface, logTitle, PAD + 16, logY + 5, 300, 13, 7) end
    local startIdx = math.max(1, #S.logLines - Config.LogLines + 1)
    local shown = 0
    for i = startIdx, #S.logLines do
        shown = shown + 1
        local lineTxt = S.logLines[i]
        local color = Theme.TextSecond
        if lineTxt:find("ОШИБКА", 1, true) then color = Theme.Red
        elseif lineTxt:find("InProgress", 1, true) or lineTxt:find("ok", 1, true) then color = Theme.Green end
        local t = Factory.CreateText(tree, lineTxt, 10, color, false, 0)
        if t then Factory.AnchorWidget(surface, t, PAD + 16, logY + 22 + (shown - 1) * 15, contentW - 32, 14, 7) end
    end

    -- ===== футер (752..784) =====
    local footerY = UI_H - PAD - 32
    local footLine = Factory.CreateSolidBorder(tree, Theme.Divider)
    if footLine then Factory.AnchorWidget(surface, footLine, PAD, footerY - 4, contentW, 1, 6) end
    local escHint = Factory.CreateText(tree, "F6 или ESC — закрыть панель", 10, Theme.TextDim, false, 0)
    if escHint then Factory.AnchorWidget(surface, escHint, PAD + 10, footerY + 8, 400, 16, 7) end
    createGameButton(hostCanvas, surface, tree, "CLOSE [ESC]", PAD + contentW - 166, footerY - 2, 150, 30, function()
        Presenter_Close()
    end, 60)
end

-- ------------------------------- Presenter ----------------------------------
function Presenter_Close()
    if IsValidObj(State.activeShell) then
        local modalHost = Engine.AcquireModalSurface()
        if modalHost then
            pcall(function() modalHost:RemoveWidget(State.activeShell) end)
        end
    end
    State.activeShell   = nil
    State.activeSurface = nil
    State.widgetTree    = nil
    State.hostCanvas    = nil
    State.isDisplayed   = false
    ClickDispatcher.Reset()
end

local function Presenter_Show()
    Presenter_Close()

    local layout = Engine.LocateMainLayout()
    if not IsValidObj(layout) then
        Log("layout не найден — войди в мир и открой панель снова")
        return
    end
    local tree = layout.WidgetTree
    if not IsValidObj(tree) then
        Log("WidgetTree не найден")
        return
    end
    local layoutName
    local okN, n = pcall(function() return tree:GetFullName() end)
    if okN and type(n) == "string" then layoutName = n end
    if not layoutName then Log("не удалось получить имя layout"); return end

    local hostCanvas = Engine.FindHostCanvas(layoutName, Assets.HostPanelName)
    if not IsValidObj(hostCanvas) then
        Log("host canvas не найден")
        return
    end

    local frame = assembleModalFrame(hostCanvas, tree, UI_W, UI_H)
    if not frame then return end

    State.activeShell   = frame.shell
    State.activeSurface = frame.surface
    State.widgetTree    = tree
    State.hostCanvas    = hostCanvas
    State.isDisplayed   = true

    renderAllContent()
    Log("панель открыта")
end

local function Presenter_IsVisible()
    return State.isDisplayed
end

local function Presenter_Refresh()
    if State.isDisplayed then
        renderAllContent()
    end
end

refreshIfOpen = Presenter_Refresh

-- ============================== ХОТКЕИ / МИР ==============================
local function bindAction(fn)
    local guarded = function() SafeDo(fn) end
    return function()
        if type(ExecuteInGameThread) == "function" and pcall(ExecuteInGameThread, guarded) then
            return
        end
        SafeDo(guarded)
    end
end

local function bindKey(keyName, fn)
    if type(RegisterKeyBind) ~= "function" or type(Key) ~= "table" then
        Err("RegisterKeyBind недоступен")
        return false
    end
    local keyEnum = Key[tostring(keyName):upper()]
    if keyEnum == nil then
        Err("неизвестная клавиша: " .. tostring(keyName))
        return false
    end
    return pcall(RegisterKeyBind, keyEnum, bindAction(fn))
end

local function toggleUI()
    if Presenter_IsVisible() then
        Presenter_Close()
    else
        Presenter_Show()
    end
end

local function onWorldEnter()
    SafeDo(function()
        if Presenter_IsVisible() then Presenter_Close() end
    end)
    Log("мир загружен — панель закрыта")
end

local function registerWorldEnterHook()
    local ok = pcall(RegisterHook,
        "/Script/Pal.PalPlayerController:OnInitializeLocalPlayer_BP",
        function() end,
        function() SafeDo(onWorldEnter) end)
    if ok then Log("world-enter hook attached (OnInitializeLocalPlayer_BP)") end
    if type(NotifyOnNewObject) == "function" then
        local okN = pcall(NotifyOnNewObject, "/Script/Pal.PalPlayerCharacter", function()
            SafeDo(function()
                ExecuteWithDelay(500, function() SafeDo(onWorldEnter) end)
            end)
        end)
        if okN then Log("world-enter hook attached (PalPlayerCharacter spawn)") end
    end
end

-- ============================== INIT ==============================
local function init()
    bindKey(Config.OpenKey, toggleUI)
    bindKey("ESCAPE", function()
        if Presenter_IsVisible() then Presenter_Close() end
    end)
    registerWorldEnterHook()
    Log("ExpeditionHub v0.4 готов: 4 кнопки, F6. Ссылок на объекты мод не хранит.")
end

SafeDo(init)
