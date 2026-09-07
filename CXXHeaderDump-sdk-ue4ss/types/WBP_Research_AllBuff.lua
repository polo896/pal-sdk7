---@meta

---@class UWBP_Research_AllBuff_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalScrollBox_0 UPalScrollBox
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WrapBox_BuffList UWrapBox
---@field OnAllBuffPanelClose FWBP_Research_AllBuff_COnAllBuffPanelClose
local UWBP_Research_AllBuff_C = {}

---@param MyGeometry FGeometry
---@param InAnalogInputEvent FAnalogInputEvent
---@return FEventReply
function UWBP_Research_AllBuff_C:OnAnalogValueChanged(MyGeometry, InAnalogInputEvent) end
---@param Effects TArray<FPalUIGuildLabPassiveEffectInfo>
function UWBP_Research_AllBuff_C:Setup(Effects) end
function UWBP_Research_AllBuff_C:BndEvt__WBP_Research_AllBuff_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
---@param EntryPoint int32
function UWBP_Research_AllBuff_C:ExecuteUbergraph_WBP_Research_AllBuff(EntryPoint) end
function UWBP_Research_AllBuff_C:OnAllBuffPanelClose__DelegateSignature() end


