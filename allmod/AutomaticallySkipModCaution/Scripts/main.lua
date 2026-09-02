-- Automatically click "OK" on Mod Caution and Disclaimer screens
NotifyOnNewObject("/Script/Pal.PalUserWidgetOverlayUI", function(Widget)
    if not Widget or not Widget:IsValid() then return end
    
    local name = Widget:GetFName():ToString()
    if string.find(name, "WBP_ModCautionDialog") or string.find(name, "WBP_ModDisclaimerDialog") then
        -- Wait a brief moment for it to be fully constructed on screen, then simulate clicking "OK"
        ExecuteInGameThreadWithDelay(80, function()
            if Widget and Widget:IsValid() then
                Widget:BndEvt__WBP_ModDisclaimerDialog_WBP_CommonButton_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature()
            end
        end)
    end
end)