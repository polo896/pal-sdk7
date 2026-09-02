-- By Wol4ara896

local function log(msg)
    print("[QC] " .. msg .. "\n")
end

-- States
local state = "WAIT_TITLE"
local timeoutTicks = 0
local LOOP_INTERVAL = 100 -- ms
local isFinished = false  -- Flag to completely stop and unload the loop
local isAborted = false   -- Flag for manual abort of the mod

-- KEYBIND REGISTRATION (F9 Key)
RegisterKeyBind(Key.F9, function()
    if isFinished or isAborted then return end
    isAborted = true
    isFinished = true
    log("AUTO-CONTINUE ABORTED BY USER (Key pressed)!")
end)


local function findLiveWidget(className, filterFn)
    local ok, list = pcall(FindAllOf, className)
    if not ok or not list then return nil end
    for _, w in ipairs(list) do
        if w and w:IsValid() then
            local okFull, fullName = pcall(function() return w:GetFullName() end)
            if okFull and fullName:find("Transient") then
                if not filterFn or filterFn(w, fullName) then
                    return w
                end
            end
        end
    end
    return nil
end

local function isVisible(widget)
    local ok, vis = pcall(function() return widget:GetVisibility() end)
    return ok and (vis == 0 or vis == 3 or vis == 4)
end

LoopAsync(LOOP_INTERVAL, function()

    if isFinished then
        collectgarbage("collect")
        log("Loop stopped. Mod is now completely inactive.")
        return true 
    end

    ExecuteInGameThread(function()
        local okStep, err = pcall(function()

            if state == "WAIT_TITLE" then
                local menu = findLiveWidget("WBP_TitleMenu_C")
                if menu and isVisible(menu) then
                    log("Title screen is ready. Simulating transition...")
                    
                    local okTransition, transErr = pcall(function()
                        menu:BndEvt__WBP_TitleMenu_WBP_Title_MenuButton_StartLocalGame_K2Node_ComponentBoundEvent_0_OnClicked__DelegateSignature()
                    end)
                    
                    if okTransition then
                        state = "CLICKED_TITLE"
                        timeoutTicks = 0
                    else
                        log("Transition error: " .. tostring(transErr))
                        state = "STOPPED_ERROR"
                    end
                end

            elseif state == "CLICKED_TITLE" then
                
                timeoutTicks = timeoutTicks + 1
                if timeoutTicks >= 10 then 
                    state = "WAIT_WORLDLIST"
                    timeoutTicks = 0
                end

            elseif state == "WAIT_WORLDLIST" then
                timeoutTicks = timeoutTicks + 1
                
                
                if timeoutTicks > 100 then
                    log("Timeout: world select menu did not load within 10 seconds. Stopping.")
                    state = "STOPPED_ERROR"
                    return
                end

                local scrollList = findLiveWidget("WBP_PalCommonScrollList_C", function(w, fullName)
                    return fullName:find("Title_WorldSelect") ~= nil
                end)
                
                if scrollList and isVisible(scrollList) then
                    local box = scrollList.ScrollBox_0
                    if box and box:IsValid() then
                        local childCount = box:GetChildrenCount()
                        
                        if childCount > 0 then
                            local child = box:GetChildAt(0)
                            if child and child:IsValid() then
                                local okDir, saveDir = pcall(function() return child.BindedSaveDirectoryName:ToString() end)
                                local okName, worldName = pcall(function() 
                                    local txt = child.Text_WorldName
                                    if txt and txt:IsValid() then
                                        return txt:GetText():ToString()
                                    end
                                    return ""
                                end)
                                
                                if okDir and saveDir and saveDir ~= "" then
                                    log(string.format("Found save: %s [%s]", tostring(worldName), tostring(saveDir)))
                                    
                                    local gi = FindFirstOf("BP_PalGameInstance_C")
                                    if gi and gi:IsValid() then
                                        pcall(function() gi:SelectWorldSaveDirectoryName(saveDir) end)
                                        pcall(function() gi:SelectWorld(worldName) end)
                                        
                                        state = "TRIGGER_START"
                                        timeoutTicks = 0
                                    else
                                        log("Error: BP_PalGameInstance_C not found!")
                                        state = "STOPPED_ERROR"
                                    end
                                end
                            end
                        else
                            
                            if timeoutTicks > 30 then
                                log("Save list is empty. Seems to be a new game. Stopping mod.")
                                state = "DONE"
                            end
                        end
                    end
                end

            elseif state == "TRIGGER_START" then
                
                timeoutTicks = timeoutTicks + 1
                if timeoutTicks >= 15 then
                    local gi = FindFirstOf("BP_PalGameInstance_C")
                    if gi and gi:IsValid() then
                        log("Closing menus and starting the world...")
                        
                        local titleMenu = findLiveWidget("WBP_TitleMenu_C")
                        local worldSelect = findLiveWidget("WBP_Title_WorldSelect_C")
                        
                        if worldSelect and worldSelect:IsValid() then
                            pcall(function() worldSelect:RemoveFromParent() end)
                        end
                        if titleMenu and titleMenu:IsValid() then
                            pcall(function() titleMenu:RemoveFromParent() end)
                        end
                        
                        pcall(function() gi:StartGame(false, false, false) end)
                        
                        log("Start command sent! Completed successfully.")
                        state = "DONE"
                    else
                        state = "STOPPED_ERROR"
                    end
                end

            elseif state == "DONE" or state == "STOPPED_ERROR" then
                isFinished = true
            end
        end)

        if not okStep then
            log("CRITICAL LOOP ERROR: " .. tostring(err))
            state = "STOPPED_ERROR"
            isFinished = true
        end
    end)

    return false
end)

log("QuickContinue mod initialized.")