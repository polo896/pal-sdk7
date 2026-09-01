-- ============================================================================
-- PalWarp - Ultimate Teleport By Wol4ara896
-- ============================================================================

local MOD_TAG, MOD_DIR = "[PalWarp]", "PalWarpMod"
local DATA_FILE = "palwarp_points.txt"

local function Log(msg) print(MOD_TAG .. " " .. tostring(msg) .. "\n") end

local function SafeCall(fn)
    local ok, err = pcall(fn)
    if not ok then Log("suppressed error (harmless to the game): " .. tostring(err)) end
    return ok, err
end

local function Trim(s)
    if type(s) ~= "string" then return "" end
    return (s:gsub("^%s+", ""):gsub("%s+$", "")):gsub("\r", "")
end

local function Num(v, default)
    local n = tonumber(v)
    return (n == nil) and default or n
end

local function parseBool(v, default)
    if v == nil then return default end
    local s = tostring(v):lower()
    if s == "1" or s == "true" or s == "yes" or s == "on" then return true end
    if s == "0" or s == "false" or s == "no" or s == "off" then return false end
    return default
end

local function nowMs()
    local ok, c = pcall(os.clock)
    return (ok and c) and math.floor(c * 1000) or 0
end

local function hasMethod(obj, name)
    local res = false
    pcall(function() res = (type(obj[name]) == "function") end)
    return res
end

local function ValueToString(v)
    if v == nil then return nil end
    if type(v) == "string" then return v end
    if type(v) ~= "userdata" and type(v) ~= "table" then return nil end
    local out
    pcall(function()
        if hasMethod(v, "get") then
            v = v:get()
            if v == nil then return end
            if type(v) == "string" then out = v return end
        end
        if (type(v) == "userdata" or type(v) == "table") and hasMethod(v, "ToString") then
            out = v:ToString()
        else
            out = tostring(v)
        end
    end)
    return out and tostring(out) or nil
end

local function IsAlive(obj)
    if obj == nil then return false end
    local ok, res = pcall(function() return obj:IsValid() end)
    return ok and res == true
end

local function IsDefaultObj(obj)
    local ok, name = pcall(function() return obj:GetFullName() end)
    return ok and type(name) == "string" and name:find("Default__", 1, true) ~= nil
end

local function pickFile(filename, mode)
    local folders = {}
    if type(debug) == "table" and type(debug.getinfo) == "function" then
        local src
        pcall(function()

            local info = debug.getinfo(2, "S")
            if info ~= nil and type(info.source) == "string" then src = info.source end
        end)
        if src ~= nil then
            if src:sub(1, 1) == "@" then src = src:sub(2) end
            local root = src:match("^(.-)[/\\]Scripts[/\\][^/\\]*%.lua$")
            if root == nil or root == "" then root = src:match("^(.-)[/\\][^/\\]*%.lua$") end
            if root ~= nil and root ~= "" then folders[1] = root end
        end
    end
    folders[#folders + 1] = "ue4ss/Mods/" .. MOD_DIR
    folders[#folders + 1] = "Mods/" .. MOD_DIR
    folders[#folders + 1] = MOD_DIR
    folders[#folders + 1] = "."
    for _, folder in ipairs(folders) do
        local p = folder .. "/" .. filename
        local f = io.open(p, mode)
        if f ~= nil then f:close() return p end
    end
    return nil
end

local cfgDefaults = {
    ChatPrefix       = "!",
    ModSave          = "SHIFT",
    ModWarp          = "ALT",
    BindNumpad       = 1,
    MapTpKey         = "LEFT_MOUSE_BUTTON",
    MapTpModifier    = "ALT",
    MapTpCloseMap    = 1,
    MapConvScaleX    = 459.0,
    MapConvScaleY    = 459.0,
    MapConvOffX      = -123509.0,
    MapConvOffY      = 159622.0,
    MaxSlot          = 50,
    DirectRange      = 9000.0,
    StagingZ         = 100000.0,
    TraceTop         = 200000.0,
    TraceBottom      = -200000.0,
    SurfaceOffset    = 150.0,
    StreamingPollMs  = 100,
    StreamingMinMs   = 250,
    StreamingMaxMs   = 6000,
    CooldownMs       = 500,
    ChatFeedback     = 1,
    AnnounceFeedback = 0,
    Debug            = 0,
    DataFile         = "",
}

local cfg = {}
for k, v in pairs(cfgDefaults) do cfg[k] = v end
local dataPath = nil

local okCfg, userCfg = pcall(require, "config")
if okCfg and type(userCfg) == "table" then
    for k, v in pairs(userCfg) do cfg[k] = v end
    Log("config.lua loaded successfully")
else
    Log("config.lua not found or has syntax errors - using default settings")
end

local function writeDefaultSettings()
    if settingsFilePath ~= nil then return end
    settingsFilePath = pickFile(CFG_FILE, "a")
    local f = settingsFilePath and io.open(settingsFilePath, "w")
    if f == nil then return end
    f:write("; PalWarpMod settings. Format: Key = Value. Lines starting with ; or # are comments.\n")
    f:write("; Read once at mod load - restart the game (or hot-reload) after edits.\n")
    for k, v in pairs(cfgDefaults) do f:write(string.format("%s = %s\n", k, tostring(v))) end
    f:close()
    Log("created settings file: " .. settingsFilePath)
end

local points = {}

local function escPipe(s)   return (type(s) == "string") and s:gsub("|", "¦") or "" end
local function unescPipe(s) return (type(s) == "string") and s:gsub("¦", "|") or "" end

local function savePoints()
    if dataPath == nil then
        Log("points file is not writable - points live only in this session")
        return false
    end
    local lines = { "# PalWarpMod v2 - saved teleport points", "# Format: point|key|x|y|z|yaw|name|map" }
    local ordered = {}
    for i = 1, math.floor(Num(cfg.MaxSlot, 50)) do
        if points[tostring(i)] ~= nil then ordered[#ordered + 1] = tostring(i) end
    end
    if points["home"] ~= nil then ordered[#ordered + 1] = "home" end
    for k in pairs(points) do
        if k ~= "home" and tonumber(k) == nil then ordered[#ordered + 1] = k end
    end
    for _, k in ipairs(ordered) do
        local p = points[k]
        lines[#lines + 1] = string.format("point|%s|%.2f|%.2f|%.2f|%.2f|%s|%s", k,
            p.x or 0, p.y or 0, p.z or 0, p.yaw or 0, escPipe(p.name or ""), escPipe(p.map or ""))
    end
    local ok = pcall(function()
        local f = io.open(dataPath, "w")
        if f == nil then error("cannot open " .. tostring(dataPath)) end
        f:write(table.concat(lines, "\n") .. "\n")
        f:close()
    end)
    if not ok then Log("FAILED to save points to " .. tostring(dataPath)) end
    return ok
end

local function loadPoints()
    if dataPath == nil then return 0 end
    local f = io.open(dataPath, "r")
    if f == nil then return 0 end
    local count = 0
    for line in f:lines() do
        local s = Trim(line)
        local key, xs, ys, zs, yaws, name, map =
            s:match("^point|([^|]*)|([^|]*)|([^|]*)|([^|]*)|([^|]*)|([^|]*)|([^|]*)$")
        if key ~= nil and key ~= "" then
            points[key] = { x = Num(xs, 0), y = Num(ys, 0), z = Num(zs, 0), yaw = Num(yaws, 0),
                             name = unescPipe(name), map = unescPipe(map) }
            count = count + 1
        end
    end
    f:close()
    return count
end

local palUtilityCache, controllerCache = nil, nil

local function palUtility()
    if palUtilityCache ~= nil and IsAlive(palUtilityCache) then return palUtilityCache end
    palUtilityCache = nil
    local ok, obj = pcall(StaticFindObject, "/Script/Pal.Default__PalUtility")
    if ok and IsAlive(obj) then palUtilityCache = obj return obj end
    return nil
end

local function getController()
    if controllerCache ~= nil and IsAlive(controllerCache) then return controllerCache end
    controllerCache = nil
    local ok, ctrl = pcall(FindFirstOf, "PalPlayerController")
    if ok and IsAlive(ctrl) and not IsDefaultObj(ctrl) then controllerCache = ctrl return ctrl end
    return nil
end

local function getLocalCharacter()
    local util, ctrl = palUtility(), getController()
    if util ~= nil and ctrl ~= nil then
        local ok, ch = pcall(function() return util:GetPlayerCharacter(ctrl) end)
        if ok and IsAlive(ch) and not IsDefaultObj(ch) then return ch end
    end
    if ctrl ~= nil then
        local ok, pawn = pcall(function() return ctrl.Pawn end)
        if ok and IsAlive(pawn) and not IsDefaultObj(pawn) then return pawn end
    end
    return nil
end

local function getActorLocation(char)
    local x, y, z
    pcall(function()
        local loc = char:K2_GetActorLocation()
        x, y, z = tonumber(loc.X), tonumber(loc.Y), tonumber(loc.Z)
    end)
    if x ~= nil and y ~= nil and z ~= nil then return x, y, z end
    return nil
end

local function getActorYaw(char)
    local yaw
    pcall(function() yaw = tonumber(char:K2_GetActorRotation().Yaw) end)
    return Num(yaw, 0)
end

local function currentMapName(char)
    local res = ""
    local util = palUtility()
    if util ~= nil then
        pcall(function()
            local md = util:GetLocalWorldMapData(char)
            if md ~= nil then
                local loc = char:K2_GetActorLocation()
                res = ValueToString(md:GetMapNameByWorldLocation({ X = loc.X, Y = loc.Y, Z = loc.Z }))
                      or ""
            end
        end)
    end
    return res
end

local function debugLog(msg)
    if parseBool(cfg.Debug, false) then Log("dbg: " .. tostring(msg)) end
end

local function notify(msg)
    Log(msg)
    local chat = parseBool(cfg.ChatFeedback, true)
    local announce = parseBool(cfg.AnnounceFeedback, false)
    if not (chat or announce) then return end
    local util, ctrl = palUtility(), getController()
    if util == nil or ctrl == nil then return end
    if chat then SafeCall(function() util:SendSystemToPlayerChat(ctrl, tostring(msg), {}) end) end
    if announce then SafeCall(function() util:SendSystemAnnounce(ctrl, tostring(msg)) end) end
end

local busy, lastActionMs = false, 0

local function tryConsumeCooldown()
    local now = nowMs()
    if now - lastActionMs < Num(cfg.CooldownMs, 500) then return false end
    lastActionMs = now
    return true
end

local function quatFromYaw(yawDeg)
    local r = math.rad(Num(yawDeg, 0)) * 0.5
    return { X = 0, Y = 0, Z = math.sin(r), W = math.cos(r) }
end

local function tryGameTeleport(char, x, y, z, yaw, bNoCheck, bAroundCheck)
    local util = palUtility()
    if util == nil or not IsAlive(char) then return false end
    local ok, res = pcall(function()
        return util:Teleport(char, { X = x, Y = y, Z = z }, quatFromYaw(yaw),
            bNoCheck == true, bAroundCheck == true)
    end)
    debugLog(string.format("Teleport(%.0f,%.0f,%.0f noCheck=%s around=%s) ok=%s res=%s",
        x, y, z, tostring(bNoCheck), tostring(bAroundCheck), tostring(ok), tostring(res)))
    return ok and res == true
end

local kismetLibCache = nil
local function traceGroundZ(char, x, y)
    if kismetLibCache == nil or not IsAlive(kismetLibCache) then
        kismetLibCache = nil
        local ok, lib = pcall(StaticFindObject, "/Script/Engine.Default__KismetSystemLibrary")
        if not (ok and IsAlive(lib)) then return nil end
        kismetLibCache = lib
    end
    local zeroColor = { R = 0, G = 0, B = 0, A = 0 }
    for _, channel in ipairs({ 0, 1, 2, 3 }) do
        local hit = {}
        local ok, wasHit = pcall(function()
            return kismetLibCache:LineTraceSingle(char,
                { X = x, Y = y, Z = Num(cfg.TraceTop, 200000) },
                { X = x, Y = y, Z = Num(cfg.TraceBottom, -200000) },
                channel, false, { char }, 0, hit, true, zeroColor, zeroColor, 0.0)
        end)
        if ok and wasHit then
            local z
            pcall(function()
                local h = hit
                if type(h) == "userdata" and hasMethod(h, "get") then h = h:get() end
                if h ~= nil and h.ImpactPoint ~= nil then z = tonumber(h.ImpactPoint.Z) end
                if z == nil and h ~= nil and h.Location ~= nil then z = tonumber(h.Location.Z) end
            end)
            if z ~= nil then return z end
        end
    end
    return nil
end

local function getMovement(char)
    local mv, ok
    pcall(function() mv = char.CharacterMovement end)
    pcall(function() ok = mv ~= nil and mv:IsValid() == true end)
    if ok ~= true then
        mv = nil
        pcall(function() mv = char:GetCharacterMovement() end)
        pcall(function() ok = mv ~= nil and mv:IsValid() == true end)
        if ok ~= true then mv = nil end
    end
    return mv
end

local function stagedTeleport(char, dx, dy, dzHint, yaw, onDone, zTrusted)
    busy = true
    local sx, sy, sz = getActorLocation(char)
    if sx == nil then
        busy = false
        if onDone then pcall(onDone, false) end
        return
    end

    local movement = getMovement(char)
    local prevMode
    if movement ~= nil then pcall(function() prevMode = Num(movement.MovementMode, nil) end) end
    local restored = false
    local function restoreMovement()
        if restored then return end
        restored = true
        if movement ~= nil then
            pcall(function() movement:StopMovementImmediately() end)
            pcall(function() movement:SetMovementMode(Num(prevMode, 1), 0) end)
        end
    end

    local finished = false
    local function finish(success)
        if finished then return end
        finished = true
        restoreMovement()
        busy = false
        if onDone then pcall(onDone, success) end
    end

    local function rollback(reason)
        SafeCall(function()
            char:K2_SetActorLocation({ X = sx, Y = sy, Z = sz }, false, {}, true)
        end)
        if reason ~= nil then notify(reason) end
        finish(false)
    end

    if movement ~= nil then
        pcall(function() movement:StopMovementImmediately() end)
        pcall(function() movement:SetMovementMode(0, 0) end)
    end

    local okSet = SafeCall(function()
        local res = char:K2_SetActorLocation(
            { X = dx, Y = dy, Z = Num(cfg.StagingZ, 100000) }, false, {}, true)
        if res == false then error("K2_SetActorLocation returned false") end
    end)
    if not okSet then return rollback("[Warp] Could not reach the staging height.") end

    local pollMs  = math.max(Num(cfg.StreamingPollMs, 100), 30)
    local minWait, maxWait = Num(cfg.StreamingMinMs, 250), Num(cfg.StreamingMaxMs, 6000)
    local waited, land = 0, nil

    local function gameThread(fn)
        if type(ExecuteInGameThread) == "function" and pcall(ExecuteInGameThread, fn) then
            return true
        end
        local okI, onGame = pcall(IsInGameThread)
        if okI and onGame == true then fn() return true end
        return false
    end

    local function schedule(fn)
        local okS = pcall(ExecuteWithDelay, pollMs, function()
            if IsAlive(char) and not gameThread(fn) then finish(false) end
        end)
        if not okS then
            if not gameThread(fn) then finish(false) end
        end
    end

    local function poll()
        if not IsAlive(char) then finished = true busy = false return end
        waited = waited + pollMs
        local done = true
        SafeCall(function()
            local wp = FindFirstOf("WorldPartitionSubsystem")
            if IsAlive(wp) then done = wp:IsAllStreamingCompleted() end
        end)
        if (done == true and waited >= minWait) or waited >= maxWait then land() else schedule(poll) end
    end

    land = function()
        if not IsAlive(char) then finished = true busy = false return end
        local finalZ = nil
        local tz = traceGroundZ(char, dx, dy)
        if tz ~= nil then
            finalZ = tz + Num(cfg.SurfaceOffset, 150)
        elseif zTrusted == true and dzHint ~= nil and dzHint < Num(cfg.StagingZ, 100000) - 1000 then
            finalZ = dzHint
        end
        if finalZ == nil then return rollback("[Warp] No surface found at the destination - rolled back.") end
        if not tryGameTeleport(char, dx, dy, finalZ, yaw, true, false) then
            local ok = SafeCall(function()
                char:K2_SetActorLocationAndRotation({ X = dx, Y = dy, Z = finalZ },
                    { Pitch = 0, Yaw = Num(yaw, 0), Roll = 0 }, false, {}, true)
            end)
            if not ok then return rollback("[Warp] Landing failed - rolled back.") end
        end
        finish(true)
    end

    schedule(poll)
end

local function warpGuard()
    if busy then notify("[Warp] Previous teleport still running - please wait.") return end
    if not tryConsumeCooldown() then return end
    local char = getLocalCharacter()
    if char == nil then notify("[Warp] Player not found (are you in the world?)") return end
    local cx, cy, cz = getActorLocation(char)
    if cx == nil then notify("[Warp] Could not read your position.") return end
    return char, cx, cy, cz
end

local function warpToRecord(key, rec)
    local char, cx, cy = warpGuard()
    if char == nil then return end
    local yaw = rec.yaw or getActorYaw(char)
    local label = (rec.name ~= nil and rec.name ~= "") and rec.name or key
    if rec.map ~= nil and rec.map ~= "" then
        local cur = currentMapName(char)
        if cur ~= "" and cur ~= rec.map then
            notify(string.format("[Warp] This point is on map '%s', you are on '%s'.", rec.map, cur))
        end
    end
    local dist = math.sqrt((rec.x - cx) ^ 2 + (rec.y - cy) ^ 2)
    if dist <= Num(cfg.DirectRange, 9000) then
        if tryGameTeleport(char, rec.x, rec.y, rec.z, yaw, false, true) then
            notify(string.format("[Warp] %s -> (%.0f, %.0f, %.0f)", label, rec.x, rec.y, rec.z))
            return
        end
    end
    notify("[Warp] Teleporting, waiting for terrain to load...")
    stagedTeleport(char, rec.x, rec.y, rec.z, yaw, function(ok)
        if ok == true then
            notify(string.format("[Warp] %s -> (%.0f, %.0f, %.0f) done", label, rec.x, rec.y, rec.z))
        end
    end, true)
end

local function warpToRawCoords(dx, dy, dzHint, yaw, label, zTrusted)
    local char, cx, cy, cz = warpGuard()
    if char == nil then return end
    if yaw == nil then yaw = getActorYaw(char) end
    local dist = math.sqrt((dx - cx) ^ 2 + (dy - cy) ^ 2)
    if dist <= Num(cfg.DirectRange, 9000) then
        local tz = traceGroundZ(char, dx, dy)
        local z = tz and (tz + Num(cfg.SurfaceOffset, 150)) or nil
        if z == nil and zTrusted == true and dzHint ~= nil then z = dzHint end
        if z == nil then z = cz end
        if tryGameTeleport(char, dx, dy, z, yaw, tz ~= nil, tz == nil) then
            notify(string.format("%s: (%.0f, %.0f, %.0f)", label, dx, dy, z))
            return
        end
    end
    notify(string.format("%s: (%.0f, %.0f) - waiting for terrain to load...", label, dx, dy))
    stagedTeleport(char, dx, dy, dzHint, yaw, function(ok)
        if ok == true then notify(string.format("%s: (%.0f, %.0f) done", label, dx, dy)) end
    end, zTrusted == true)
end

local function findVisibleMapWidget()
    local ok, widgets = pcall(FindAllOf, "WBP_Map_Base_C")
    if not ok or type(widgets) ~= "table" then return nil end
    for i = 1, #widgets do
        local w = widgets[i]
        if IsAlive(w) and not IsDefaultObj(w) then
            local vis = false
            pcall(function() vis = w:IsVisible() end)
            if vis == true then return w end
        end
    end
    return nil
end

local function mapCursorWorldLocation(mapWidget)
    local out = {}
    pcall(function() mapWidget:GetCurrentMapBody(out) end)
    local body = out.MapBody
    if IsAlive(body) then
        local loc = {}
        local ok = pcall(function() body:GetCursorWorldLocation(loc) end)
        if ok then
            local x = tonumber(loc.X)
            local y = tonumber(loc.Y)
            local z = tonumber(loc.Z)
            if x ~= nil and y ~= nil then return x, y, z end
        end
    end

    local txt
    pcall(function()
        local tb = mapWidget.Text_CursorLocation
        if tb ~= nil then txt = ValueToString(tb:GetText()) end
    end)
    if txt ~= nil then
        local a, b = txt:match("([%-+]?[%d%.]+)[%s,;]+([%-+]?[%d%.]+)")
        local n1, n2 = tonumber(a), tonumber(b)
        if n1 ~= nil and n2 ~= nil then
            return Num(cfg.MapConvOffX, -123509) + n2 * Num(cfg.MapConvScaleX, 459),
                   Num(cfg.MapConvOffY,  159622) + n1 * Num(cfg.MapConvScaleY, 459)
        end
    end
    return nil
end

local function handleMapTeleport()
    local mapWidget = findVisibleMapWidget()
    if mapWidget == nil then return debugLog("map is not open - click ignored") end
    local mx, my, mz = mapCursorWorldLocation(mapWidget)
    if mx == nil then return notify("[Warp] Could not read the position under the map cursor.") end
    if parseBool(cfg.MapTpCloseMap, true) then pcall(function() mapWidget:CloseMap() end) end
    warpToRawCoords(mx, my, mz, nil, "[Warp] Map point", false)
end

local function saveCurrentToPoint(key, label)
    local char = getLocalCharacter()
    if char == nil then return notify("[Warp] Player not found - cannot save") end
    local x, y, z = getActorLocation(char)
    if x == nil then return notify("[Warp] Could not read your position") end
    local rec = { x = x, y = y, z = z, yaw = getActorYaw(char), map = currentMapName(char),
                  name = (label ~= nil and label ~= "") and label or key }
    points[key] = rec
    if savePoints() then
        notify(string.format("[Warp] Saved '%s': (%.0f, %.0f, %.0f)", rec.name, x, y, z))
    else
        notify(string.format("[Warp] '%s' saved in memory, BUT the file was not written!", rec.name))
    end
end

local function resolveTargetToken(token)
    if token == nil or token == "" then return nil, nil end
    local n = tonumber(token)
    if n ~= nil and math.floor(n) == n and n >= 1 and n <= math.floor(Num(cfg.MaxSlot, 50)) then
        local key = tostring(math.floor(n))
        return points[key], key
    end
    local low = token:lower()
    if points["n:" .. low] ~= nil then return points["n:" .. low], "n:" .. low end
    for key, rec in pairs(points) do
        if rec.name ~= nil and rec.name ~= "" and rec.name:lower() == low then return rec, key end
    end
    return nil, nil
end

local function listPoints()
    local out = {}
    for i = 1, math.floor(Num(cfg.MaxSlot, 50)) do
        local rec = points[tostring(i)]
        if rec ~= nil then
            out[#out + 1] = string.format("[%d] %s (%.0f, %.0f, %.0f)",
                i, rec.name or "", rec.x, rec.y, rec.z)
        end
    end
    if points["home"] ~= nil then
        out[#out + 1] = string.format("[home] (%.0f, %.0f, %.0f)",
            points["home"].x, points["home"].y, points["home"].z)
    end
    for key, rec in pairs(points) do
        if key:sub(1, 2) == "n:" then
            out[#out + 1] = string.format("[%s] (%.0f, %.0f, %.0f)",
                rec.name or key:sub(3), rec.x, rec.y, rec.z)
        end
    end
    if #out == 0 then return notify("[Warp] No saved points. Save one with: !set 1") end
    local i = 1
    while i <= #out do
        local chunk = {}
        while i <= #out and #chunk < 5 do chunk[#chunk + 1] = out[i] i = i + 1 end
        notify("[Warp] " .. table.concat(chunk, " | "))
    end
end

local function handleChatCommand(text)
    local prefix = tostring(cfg.ChatPrefix or "!")
    text = Trim(text)
    if text == "" or text:sub(1, #prefix) ~= prefix then return false end
    local cmd, rest = text:sub(#prefix + 1):match("^(%S+)%s*(.*)$")
    if cmd == nil then return false end
    cmd = cmd:lower()
    local tokens = {}
    for tok in Trim(rest):gmatch("%S+") do tokens[#tokens + 1] = tok end

    if cmd == "help" then
        notify("[Warp] !set <1-50|Name> [label] - save; !warp <1-50|Name> - teleport;" ..
            " !warp X Y Z [Yaw] - raw coords; !sethome / !home; !del <1-50|Name>;" ..
            " !list; !where. Hotkeys: Shift+1..3 save, Alt+1..3 teleport," ..
            " ALT+click with the map open - warp to the map cursor.")
    elseif cmd == "where" then
        local char = getLocalCharacter()
        if char == nil then notify("[Warp] Player not found") return true end
        local x, y, z = getActorLocation(char)
        if x == nil then notify("[Warp] Could not read your position") return true end
        notify(string.format("[Warp] Position: X=%.1f Y=%.1f Z=%.1f Yaw=%.1f",
            x, y, z, getActorYaw(char)))
    elseif cmd == "list" then
        listPoints()
    elseif cmd == "set" then
        if tokens[1] == nil then return notify("[Warp] Usage: !set <1-50|Name> [label]") end
        local n = tonumber(tokens[1])
        local maxSlot = math.floor(Num(cfg.MaxSlot, 50))
        if n ~= nil and math.floor(n) == n and n >= 1 and n <= maxSlot then
            local label = table.concat(tokens, " ", 2)
            saveCurrentToPoint(tostring(math.floor(n)),
                (label ~= "") and label or ("Point " .. tokens[1]))
        elseif n ~= nil then
            notify("[Warp] Slot must be within 1-" .. maxSlot)
        else
            saveCurrentToPoint("n:" .. tokens[1]:lower(),
                (#tokens > 1) and table.concat(tokens, " ", 2) or tokens[1])
        end
    elseif cmd == "del" or cmd == "delete" or cmd == "remove" then
        if tokens[1] == nil then return notify("[Warp] Usage: !del <1-50|Name>") end
        local rec, key = resolveTargetToken(tokens[1])
        if rec == nil then
            notify("[Warp] Point '" .. tokens[1] .. "' not found")
        else
            points[key] = nil
            savePoints()
            notify("[Warp] Deleted: " .. tokens[1])
        end
    elseif cmd == "sethome" then
        saveCurrentToPoint("home", "Home")
    elseif cmd == "home" then
        if points["home"] == nil then return notify("[Warp] Home is not set - use !sethome") end
        warpToRecord("home", points["home"])
    elseif cmd == "warp" or cmd == "tp" then
        if tokens[1] == nil then
            return notify("[Warp] Usage: !warp <1-50|Name> or !warp X Y Z [Yaw]")
        end
        local x1, y1, z1 = tonumber(tokens[1]), tonumber(tokens[2]), tonumber(tokens[3])
        if x1 ~= nil and y1 ~= nil and z1 ~= nil then
            warpToRawCoords(x1, y1, z1, tonumber(tokens[4]), "[Warp] Coords", true)
            return true
        end
        local rec, key = resolveTargetToken(tokens[1])
        if rec == nil then
            notify("[Warp] Point '" .. tokens[1] .. "' not found. List: !list")
            return true
        end
        warpToRecord(key, rec)
    else
        return false
    end
    return true
end

local function isLocalPlayerState(selfParam)
    local util, ctrl = palUtility(), getController()
    if util == nil or ctrl == nil then return true end
    local same = true
    SafeCall(function()
        local selfObj = selfParam
        if (type(selfObj) == "userdata" or type(selfObj) == "table") and hasMethod(selfObj, "get") then
            selfObj = selfObj:get()
        end
        local lps = util:GetLocalPlayerState(ctrl)
        if IsAlive(lps) and IsAlive(selfObj)
           and hasMethod(lps, "GetFullName") and hasMethod(selfObj, "GetFullName") then
            same = (lps:GetFullName() == selfObj:GetFullName())
        end
    end)
    return same
end

local queuedCommand, chatHookRegistered = nil, false

local function queueChatCommand(rawText)
    queuedCommand = rawText
    local run = function()
        local t = queuedCommand
        queuedCommand = nil
        if t ~= nil then SafeCall(function() handleChatCommand(t) end) end
    end

    local deferred = false
    if EngineTickAvailable == true and type(ExecuteInGameThreadAfterFrames) == "function" then
        deferred = pcall(ExecuteInGameThreadAfterFrames, 2, run)
    end
    if not deferred and type(ExecuteWithDelay) == "function" then
        deferred = pcall(ExecuteWithDelay, 60, function()
            if not pcall(ExecuteInGameThread, run) then run() end
        end)
    end
    if not deferred then run() end
end

local function onEnterChat(selfParam, msgParam, _catParam)
    local ok, err = pcall(function()
        local txt = ValueToString(msgParam)
        if txt == nil then return end
        txt = Trim(txt)
        local prefix = tostring(cfg.ChatPrefix or "!")
        if txt == "" or txt:sub(1, #prefix) ~= prefix then return end
        if not isLocalPlayerState(selfParam) then return end
        queueChatCommand(txt)
    end)
    if not ok then debugLog("EnterChat hook: " .. tostring(err)) end
end

local function tryRegisterChatHooks(attempt)
    if chatHookRegistered then return true end
    if type(RegisterHook) == "function"
       and pcall(RegisterHook, "/Script/Pal.PalPlayerState:EnterChat", onEnterChat) then
        chatHookRegistered = true
        Log("chat hook attached (PalPlayerState:EnterChat)")
        return true
    end
    if attempt < 10 then
        pcall(ExecuteWithDelay, 5000, function() tryRegisterChatHooks(attempt + 1) end)
    else
        Log("chat hook unavailable - hotkeys only")
    end
    return false
end

local function isChatInputOpen()
    local visible = false
    SafeCall(function()
        local w = FindFirstOf("WBP_PalChatUIControlOverlay_C")
        if IsAlive(w) then visible = (w:IsVisible() == true) end
    end)
    return visible
end

local function bindAction(fn)
    local guarded = function() SafeCall(fn) end
    return function()
        if type(ExecuteInGameThread) == "function" and pcall(ExecuteInGameThread, guarded) then
            return
        end
        SafeCall(guarded)
    end
end

local function bindKey(keyName, modName, fn)
    if type(RegisterKeyBind) ~= "function" or type(Key) ~= "table" then return false end
    local keyEnum = Key[tostring(keyName):upper()]
    if keyEnum == nil then
        Log("unknown key in settings: " .. tostring(keyName))
        return false
    end
    local mod
    if modName ~= nil and type(ModifierKey) == "table" then
        local s = tostring(modName):upper()
        if s ~= "" and s ~= "NONE" and s ~= "OFF" then mod = ModifierKey[s] end
    end
    if mod ~= nil then return pcall(RegisterKeyBind, keyEnum, { mod }, bindAction(fn)) end
    return pcall(RegisterKeyBind, keyEnum, bindAction(fn))
end

local SLOT_KEYS = { "ONE", "TWO", "THREE" }
local SLOT_NUMPAD = { "NUM_ONE", "NUM_TWO", "NUM_THREE" }

local function registerHotkeys()
    local bound = 0
    for i = 1, 3 do
        local slot = tostring(i)
        local saveFn = function()
            if not isChatInputOpen() then saveCurrentToPoint(slot, "Point " .. slot) end
        end
        local warpFn = function()
            if isChatInputOpen() then return end
            local rec = points[slot]
            if rec == nil then
                notify("[Warp] Slot " .. slot .. " is empty. Save it with Shift+" .. slot)
            else
                warpToRecord(slot, rec)
            end
        end
        if bindKey(SLOT_KEYS[i], cfg.ModSave or "SHIFT", saveFn) then bound = bound + 1 end
        if bindKey(SLOT_KEYS[i], cfg.ModWarp or "ALT", warpFn) then bound = bound + 1 end
        if parseBool(Num(cfg.BindNumpad, 1), true) then
            bindKey(SLOT_NUMPAD[i], cfg.ModSave or "SHIFT", saveFn)
            bindKey(SLOT_NUMPAD[i], cfg.ModWarp or "ALT", warpFn)
        end
    end
    local mapBound = bindKey(cfg.MapTpKey or "LEFT_MOUSE_BUTTON",
        cfg.MapTpModifier or "ALT", handleMapTeleport)
    if bound > 0 then
        Log("hotkeys: Shift+1/2/3 save, Alt+1/2/3 teleport" ..
            (mapBound and (", " .. tostring(cfg.MapTpModifier) .. "+" ..
                tostring(cfg.MapTpKey) .. " - map cursor warp") or ""))
    else
        Log("WARNING: RegisterKeyBind/Key unavailable - chat commands only")
    end
end

local function init()
    dataPath = Trim(tostring(cfg.DataFile or "")) ~= "" and Trim(tostring(cfg.DataFile))
               or pickFile(DATA_FILE, "r") or pickFile(DATA_FILE, "a")
    if dataPath ~= nil then
        Log(string.format("points file: %s (loaded %d entries)", tostring(dataPath), loadPoints()))
    else
        Log("WARNING: no writable folder for " .. DATA_FILE .. " - points die with the session")
    end
    savePoints()
    tryRegisterChatHooks(0)
    registerHotkeys()
    local major, minor, hotfix
    pcall(function() major, minor, hotfix = UE4SS.GetVersion() end)
    if major ~= nil then
        Log(string.format("UE4SS v%d.%d.%d - mod ready, !help for commands",
            major, Num(minor, 0), Num(hotfix, 0)))
    else
        Log("mod ready - !help for commands")
    end
end

SafeCall(init)

local okUnloadReg = pcall(function()
    ModRef.OnUnload = function() pcall(savePoints) end
end)
if not okUnloadReg and parseBool(cfg.Debug, false) then
    Log("dbg: ModRef.OnUnload unavailable in this UE4SS version (harmless)")
end