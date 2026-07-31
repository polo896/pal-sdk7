-- Функция для моментального скрытия и удаления виджета
local function HideLoadingScreen(widget)
    if widget and widget:IsValid() then
        -- 1 = ESlateVisibility::Collapsed (полное скрытие виджета)
        widget:SetVisibility(1)
        
        -- Безопасное удаление виджета из интерфейса
        pcall(function()
            widget:RemoveFromParent()
        end)
    end
end

-- Перехват создания экранов загрузки и затемнения
NotifyOnNewObject("/Game/Pal/UI/HUD/WBP_LoadingScreen.WBP_LoadingScreen_C", HideLoadingScreen)
NotifyOnNewObject("/Game/Pal/UI/HUD/WBP_LoadingScreen_Transition.WBP_LoadingScreen_Transition_C", HideLoadingScreen)
NotifyOnNewObject("/Game/Pal/UI/HUD/WBP_InLevelLoadingFade.WBP_InLevelLoadingFade_C", HideLoadingScreen)

-- Перехват во время инициализации виджета (Construct)
RegisterHook("/Game/Pal/UI/HUD/WBP_LoadingScreen.WBP_LoadingScreen_C:Construct", function(self)
    local obj = self:get()
    if obj and obj:IsValid() then
        obj:SetVisibility(1)
        pcall(function() obj:RemoveFromParent() end)
    end
end)