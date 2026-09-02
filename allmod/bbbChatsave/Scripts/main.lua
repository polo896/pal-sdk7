local CHAT_WIDGET_CLASS    = "/Game/Pal/Blueprint/UI/UserInterface/InGame/Chat/WBP_Ingame_Chat.WBP_Ingame_Chat_C"
local CHAT_WRAPPER_CLASS   = "/Game/Pal/Blueprint/UI/UserInterface/InGame/Chat/WBP_Ingame_Chat_Wrapper.WBP_Ingame_Chat_Wrapper_C"
local CHAT_OVERLAY_CLASS   = "/Game/Pal/Blueprint/UI/WBP_PalChatUIControlOverlay.WBP_PalChatUIControlOverlay_C"
local ON_COMPLETE_INPUT_FN = "BndEvt__WBP_Ingame_Chat_Wrapper_WBP_Ingame_Chat_K2Node_ComponentBoundEvent_0_OnCompleteInput__DelegateSignature"

local TEXTBOX_MEMBER = "PalMultiLineEditableTextBox_220" -- член UWBP_Ingame_Chat_C (смещение 0x04A0 в дампе)

local CHAT_WIDGET_SHORT  = "WBP_Ingame_Chat_C"           -- короткое имя класса для FindAllOf
local CHAT_OVERLAY_SHORT = "WBP_PalChatUIControlOverlay_C"

local MAX_HISTORY  = 50   -- сколько сообщений хранить в памяти
local CYCLE_DEPTH  = 5    -- сколько последних сообщений листается стрелками
local POLL_MS      = 100  -- период поллинга (страховочный захват + самолечение кэша)
local RESCAN_TICKS = 3    -- полный FindAllOf-рескан не чаще, чем раз в 3 тика (300 мс)
local LOST_LOG_TICKS = 100 -- как редко логировать "виджет потерян" (раз в ~10 c)
local DEBUG        = false -- true = подробный лог

------------------------------------------------------------------
-- Состояние
------------------------------------------------------------------
local history = {}
local historyIndex = 0
local lastSeen = nil            -- последний непустой текст, виденный поллингом
local suppressNextClear = false -- true, если поле очистили МЫ (стрелка вниз)

local cachedWidget = nil        -- кэш живого WBP_Ingame_Chat_C (глубоко проверяется)
local clock = 0                 -- тик поллинга (такт для троттлинга ресканов)
local lastRescanTick = -1000
local lastLostLogTick = -1000
local lastBoundName = nil       -- FullName последнего привязанного виджета (для лога)

local function Log(msg)
    pcall(function() print("[PalChatHistory] " .. tostring(msg) .. "\n") end)
end

-- Lua 5.1/5.4 совместимость (в 5.4 unpack -> table.unpack)
local unpack = unpack or table.unpack

local function DLog(msg)
    if DEBUG then Log(msg) end
end

------------------------------------------------------------------
-- Безопасная работа с UObject
------------------------------------------------------------------
local function IsValidObj(o)
    if o == nil then return false end
    local ok, valid = pcall(function() return o:IsValid() end)
    return ok and valid == true
end

local function GetFullNameSafe(o)
    local ok, name = pcall(function() return o:GetFullName() end)
    if ok and type(name) == "string" then return name end
    return nil
end

-- CDO/архетип нам не подходит; заодно считаем "подозрительным" объект,
-- у которого не читается FullName.
local function IsCDO(o)
    local name = GetFullNameSafe(o)
    if name == nil then return true end
    return name:find("Default__", 1, true) ~= nil
end

-- В некоторых версиях рантайма хук отдаёт self как RemoteUnrealParam —
-- разворачиваем через :get(); на обычном UObject-враппере это no-op.
local function UnwrapParam(p)
    if p == nil then return nil end
    local t = type(p)
    if t == "string" or t == "number" or t == "boolean" then return p end
    local ok, res = pcall(function()
        if type(p.get) == "function" then return p:get() end
        return p
    end)
    if ok and res ~= nil then return res end
    return nil
end

-- Достаём текст из параметра хука (FText / RemoteUnrealParam / строка).
-- Возвращает nil, если параметр не читается или выглядит как мусор.
local function ParamToText(p)
    if p == nil then return nil end
    local ok, v = pcall(function()
        local q = p
        if type(q) ~= "string" and type(q.get) == "function" then q = q:get() end
        if q == nil then return nil end
        if type(q) == "string" then return q end
        if type(q) == "number" then return tostring(q) end
        if type(q.ToString) == "function" then
            local s = q:ToString()
            if type(s) == "string" then return s end
        end
        return nil
    end)
    if ok and type(v) == "string" and v ~= "" then
        if v:find("^table: ") or v:find("^userdata") or v:find("^function: ") then
            return nil
        end
        return v
    end
    return nil
end

-- Достаём числовой параметр хука (enum), либо nil.
local function ParamToNumber(p)
    if p == nil then return nil end
    local ok, v = pcall(function()
        local q = p
        if type(q) ~= "number" and type(q.get) == "function" then q = q:get() end
        if type(q) == "number" then return q end
        return nil
    end)
    if ok and type(v) == "number" then return v end
    return nil
end

------------------------------------------------------------------
-- Виджет чата и его поле ввода
------------------------------------------------------------------
local function GetTextBoxFrom(widget)
    if not IsValidObj(widget) then return nil end
    local ok, tb = pcall(function() return widget[TEXTBOX_MEMBER] end)
    if ok and IsValidObj(tb) then return tb end
    return nil
end

-- "Глубокая" проверка: объект жив, не CDO, и поле ввода внутри живо.
-- Именно это отсекает мёртвые копии виджета после пересоздания UI,
-- на которых IsValid() всё ещё возвращает true.
local function IsWidgetUsable(widget)
    if widget == nil then return false end
    if not IsValidObj(widget) then return false end
    if IsCDO(widget) then return false end
    return GetTextBoxFrom(widget) ~= nil
end

local function IsInputOpenOn(widget)
    if not IsValidObj(widget) then return false end
    local ok, flag = pcall(function() return widget.IsShowChatInputUI end)
    return ok and flag == true
end

local function ReadTextBoxText(tb)
    if not IsValidObj(tb) then return nil end
    local ok, s = pcall(function() return tb:GetText():ToString() end)
    if ok and type(s) == "string" then return s end
    return nil
end

local function SetTextBoxText(tb, text)
    if not IsValidObj(tb) then return false end
    local ok = pcall(function() tb:SetText(FText(text)) end)
    if not ok then
        -- некоторые рантаймы сами конвертируют строку в FText
        ok = pcall(function() tb:SetText(text) end)
    end
    if not ok then DLog("SetText failed") end
    return ok
end

local function ClearTextBox(tb)
    return SetTextBoxText(tb, "")
end

------------------------------------------------------------------
-- История
------------------------------------------------------------------
local function PushHistory(msg)
    if type(msg) ~= "string" then return false end
    local s = msg:gsub("^%s+", ""):gsub("%s+$", "")
    if s == "" then return false end
    if history[#history] == s then return false end -- не копим одинаковые подряд
    table.insert(history, s)
    if #history > MAX_HISTORY then
        table.remove(history, 1)
    end
    return true
end

local function ResetIndex()
    historyIndex = 0
end

-- index 1 = самое свежее сообщение
local function HistoryAt(index)
    local n = #history
    if n == 0 or index < 1 or index > CYCLE_DEPTH then return nil end
    local pos = n - index + 1
    if pos < 1 then return nil end
    return history[pos]
end

------------------------------------------------------------------
-- Поиск ЖИВОГО экземпляра виджета чата (сердце фикса)
------------------------------------------------------------------
-- Кандидат оценивается: +8 если ввод сейчас открыт (это виджет, с которым
-- реально работает игрок). При равенстве счёта побеждает более поздний в
-- списке — после пересоздания UI новый экземпляр обычно позже в GObjects.
local function TryCandidate(w, state)
    if not IsWidgetUsable(w) then return end
    local score = 0
    if IsInputOpenOn(w) then score = score + 8 end
    if score >= state.bestScore then
        state.bestScore = score
        state.best = w
    end
end

local function ScanForChatWidget()
    local state = { best = nil, bestScore = -1 }

    -- Путь 1: живой оверлей указывает на подконтрольный ему чат
    -- (UWBP_PalChatUIControlOverlay_C::ControllChatUI, 0x0480 в дампе).
    local okO, overlays = pcall(FindAllOf, CHAT_OVERLAY_SHORT)
    if okO and overlays then
        for i = 1, #overlays do
            local o = overlays[i]
            if IsValidObj(o) and not IsCDO(o) then
                local okW, cc = pcall(function() return o.ControllChatUI end)
                if okW and cc ~= nil then TryCandidate(cc, state) end
            end
        end
    end

    -- Путь 2: прямой перебор всех экземпляров чата.
    local okC, chats = pcall(FindAllOf, CHAT_WIDGET_SHORT)
    if okC and chats then
        for i = 1, #chats do
            TryCandidate(chats[i], state)
        end
    end

    return state.best
end

-- Возвращает живой виджет или nil. Кэш проверяется КАЖДЫЙ вызов —
-- если он протух, мгновенно сбрасывается и (с троттлингом) ищется заново.
local function ResolveChatWidget(forceRescan)
    if IsWidgetUsable(cachedWidget) then
        return cachedWidget
    end
    cachedWidget = nil

    local minTicks = forceRescan and 1 or RESCAN_TICKS
    if (clock - lastRescanTick) < minTicks then
        return nil -- недавно сканировали и не нашли — подождём (анти-спам FindAllOf)
    end
    lastRescanTick = clock

    local w = ScanForChatWidget()
    if w ~= nil then
        cachedWidget = w
        local name = GetFullNameSafe(w)
        if name ~= lastBoundName then
            lastBoundName = name
            Log("chat widget bound: " .. tostring(name))
        end
    elseif lastBoundName ~= nil and (clock - lastLostLogTick) >= LOST_LOG_TICKS then
        lastLostLogTick = clock
        Log("chat widget lost (UI rebuilt?) - re-scanning until it comes back")
    end
    return w
end

-- Привязка кэша из хука: self там гарантированно живой экземпляр.
local function BindWidgetFromHook(obj)
    if IsWidgetUsable(obj) then
        if cachedWidget ~= obj then
            cachedWidget = obj
            local name = GetFullNameSafe(obj)
            if name ~= lastBoundName then
                lastBoundName = name
                Log("chat widget bound: " .. tostring(name))
            end
        end
        return obj
    end
    return nil
end

------------------------------------------------------------------
-- Захват отправленного сообщения
------------------------------------------------------------------
local function CaptureOnSend(useLastSeen, hookText)
    local text = hookText
    if text == nil or text == "" then
        text = ReadTextBoxText(GetTextBoxFrom(ResolveChatWidget(false)))
    end
    if (text == nil or text == "") and useLastSeen then
        text = lastSeen
    end
    if text ~= nil and text ~= "" then
        PushHistory(text)
        lastSeen = nil
    end
    suppressNextClear = false
    ResetIndex()
end

------------------------------------------------------------------
-- Хуки-сигналы
------------------------------------------------------------------
local hooksRegistered = 0
local function RegisterHookSafe(clsPath, fnName, handler)
    local ok = pcall(function()
        RegisterHook(clsPath .. ":" .. fnName, function(...)
            local args = { ... }
            pcall(function() handler(unpack(args)) end)
        end)
    end)
    if ok then
        hooksRegistered = hooksRegistered + 1
    else
        Log("RegisterHook failed: " .. fnName)
    end
    return ok
end

RegisterHookSafe(CHAT_WIDGET_CLASS, "Construct", function(self)
    -- виджет (пере)создан: сбрасываем кэш, poll/хуки перевяжут; дети уже созданы
    if cachedWidget ~= nil and cachedWidget ~= UnwrapParam(self) then
        cachedWidget = nil
    end
    BindWidgetFromHook(UnwrapParam(self))
end)

RegisterHookSafe(CHAT_WIDGET_CLASS, "Destruct", function()
    -- виджет ушёл из дерева UI — кэш больше нельзя доверять
    cachedWidget = nil
    ResetIndex()
end)

RegisterHookSafe(CHAT_WIDGET_CLASS, "ShowChatInputUI", function(self)
    BindWidgetFromHook(UnwrapParam(self))
    lastSeen = nil
    suppressNextClear = false
    ResetIndex()
end)

RegisterHookSafe(CHAT_WIDGET_CLASS, "OpenChatUI", function(self)
    BindWidgetFromHook(UnwrapParam(self))
    ResetIndex()
end)

-- Закрытие чата: если поле пустое — шла отправка, текст ещё нужен
-- следующим сигналам; если в поле остался текст — чат закрыт без отправки.
RegisterHookSafe(CHAT_WIDGET_CLASS, "HideChatInputUI", function()
    local fieldText = ReadTextBoxText(GetTextBoxFrom(cachedWidget))
    if fieldText ~= nil and fieldText ~= "" then
        lastSeen = nil
        suppressNextClear = false
    end
    ResetIndex()
end)

-- Коммит текста: срабатывает до очистки поля. Читаем сам параметр FText,
-- с фолбэком на поле. Commit-тип != UserCommited (ESC/потеря фокуса)
-- в историю не пишем.
RegisterHookSafe(CHAT_WIDGET_CLASS, "OnTextCommittedInternal", function(self, inText, inCommit)
    BindWidgetFromHook(UnwrapParam(self))
    local commit = ParamToNumber(inCommit)
    if commit ~= nil and commit ~= 1 then
        DLog("commit ignored, type=" .. tostring(commit))
        suppressNextClear = false
        ResetIndex()
        return
    end
    CaptureOnSend(false, ParamToText(inText))
end)

RegisterHookSafe(CHAT_OVERLAY_CLASS, "SendChat", function(self)
    local obj = UnwrapParam(self)
    if obj ~= nil and IsValidObj(obj) and not IsCDO(obj) then
        local okW, cc = pcall(function() return obj.ControllChatUI end)
        if okW then BindWidgetFromHook(cc) end
    end
    CaptureOnSend(true, nil)
end)

RegisterHookSafe(CHAT_OVERLAY_CLASS, "OnCompletedChatInput", function()
    CaptureOnSend(true, nil)
end)

RegisterHookSafe(CHAT_WRAPPER_CLASS, ON_COMPLETE_INPUT_FN, function(self)
    local obj = UnwrapParam(self)
    if obj ~= nil and IsValidObj(obj) and not IsCDO(obj) then
        local okW, cc = pcall(function() return obj.WBP_Ingame_Chat end)
        if okW then BindWidgetFromHook(cc) end
    end
    CaptureOnSend(true, nil)
end)

------------------------------------------------------------------
-- Поллинг: страховочный захват отправки + самолечение привязки
------------------------------------------------------------------
local function PollTickBody()
    clock = clock + 1

    local w = ResolveChatWidget(false)
    if not w then return end

    if not IsInputOpenOn(w) then
        suppressNextClear = false
        return
    end

    local tb = GetTextBoxFrom(w)
    if not tb then return end

    local text = ReadTextBoxText(tb)
    if text == nil then return end
    if text ~= "" then
        lastSeen = text
        suppressNextClear = false
    else
        if suppressNextClear then
            suppressNextClear = false -- это очистили МЫ, не отправка
        elseif lastSeen ~= nil and lastSeen ~= "" then
            PushHistory(lastSeen)
            ResetIndex()
        end
        lastSeen = nil
    end
end

local pollStoppedLogged = false
local function PollTick()
    -- Тело полностью защищено: ни одна ошибка не может убить цепочку.
    local ok, err = pcall(function()
        if ExecuteInGameThread ~= nil then
            ExecuteInGameThread(function()
                local okB, errB = pcall(PollTickBody)
                if not okB then DLog("poll body error: " .. tostring(errB)) end
            end)
        else
            local okB, errB = pcall(PollTickBody)
            if not okB then DLog("poll body error: " .. tostring(errB)) end
        end
    end)
    if not ok then
        Log("poll dispatch error: " .. tostring(err))
    end

    local okSched = pcall(function() ExecuteWithDelay(POLL_MS, PollTick) end)
    if not okSched and not pollStoppedLogged then
        pollStoppedLogged = true
        Log("ExecuteWithDelay unavailable - polling stopped, hooks still active")
    end
end

if ExecuteWithDelay ~= nil then
    pcall(function() ExecuteWithDelay(POLL_MS, PollTick) end)
else
    Log("ExecuteWithDelay not available at load - polling disabled, hooks still active")
end

------------------------------------------------------------------
-- Стрелки ↑ / ↓
------------------------------------------------------------------
local function HistoryUp()
    local w = ResolveChatWidget(true)
    if not w then return end
    if not IsInputOpenOn(w) then return end
    if #history == 0 then return end
    local tb = GetTextBoxFrom(w)
    if not tb then return end

    local nextIndex = math.min(historyIndex + 1, CYCLE_DEPTH)
    local msg = HistoryAt(nextIndex)
    if not msg then return end
    historyIndex = nextIndex
    SetTextBoxText(tb, msg)
    suppressNextClear = false
end

local function HistoryDown()
    local w = ResolveChatWidget(true)
    if not w then return end
    if not IsInputOpenOn(w) then return end
    local tb = GetTextBoxFrom(w)
    if not tb then return end

    local nextIndex = math.max(historyIndex - 1, 0)
    if nextIndex == 0 then
        historyIndex = 0
        suppressNextClear = true -- мы сами очистили поле — это не отправка
        ClearTextBox(tb)
        lastSeen = nil
        return
    end
    local msg = HistoryAt(nextIndex)
    if not msg then return end
    historyIndex = nextIndex
    SetTextBoxText(tb, msg)
    suppressNextClear = false
end

-- Весь игровой код — строго в игровом потоке. ExecuteInGameThread —
-- асинхронная очередь (без ожидания), поэтому дедлок невозможен и из
-- потока кейбинда, и из самого игрового потока.
local function RunOnGameThread(fn)
    if ExecuteInGameThread ~= nil then
        pcall(ExecuteInGameThread, function() pcall(fn) end)
    else
        pcall(fn)
    end
end

local function RegisterArrowBind(key, label, handler)
    if key == nil then return false end
    local ok, err = pcall(RegisterKeyBind, key, function()
        RunOnGameThread(handler)
    end)
    if not ok then
        Log(label .. " keybind failed: " .. tostring(err))
    else
        DLog(label .. " keybind registered")
    end
    return ok
end

local upBound, downBound = false, false
do
    local okKeys, upKey, downKey = pcall(function()
        local u = Key.UP_ARROW or Key.UP          -- разные рантаймы зовут по-разному
        local d = Key.DOWN_ARROW or Key.DOWN
        return u, d
    end)
    if okKeys then
        if upKey ~= nil then upBound = RegisterArrowBind(upKey, "Up", HistoryUp) end
        if downKey ~= nil then downBound = RegisterArrowBind(downKey, "Down", HistoryDown) end
    end
    if not upBound then
        upBound = RegisterArrowBind(38, "Up(fallback)", HistoryUp) -- совместимость с v1
    end
    if not downBound then
        downBound = RegisterArrowBind(40, "Down(fallback)", HistoryDown)
    end
end

Log("v2.0 loaded: Up/Down recalls last " .. tostring(CYCLE_DEPTH) ..
    " messages, hooks=" .. tostring(hooksRegistered) ..
    ", upBound=" .. tostring(upBound) .. ", downBound=" .. tostring(downBound))
