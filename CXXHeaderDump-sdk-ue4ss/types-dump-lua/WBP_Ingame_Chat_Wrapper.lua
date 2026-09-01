---@meta

---@class UWBP_Ingame_Chat_Wrapper_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Image_91 UImage
---@field Image_ForceClose UImage
---@field WBP_Ingame_Chat UWBP_Ingame_Chat_C
local UWBP_Ingame_Chat_Wrapper_C = {}

---@param MyGeometry FGeometry
---@param MouseEvent FPointerEvent
---@return FEventReply
function UWBP_Ingame_Chat_Wrapper_C:On_Image_ForceClose_MouseButtonDown(MyGeometry, MouseEvent) end
---@param bCanOpenAnyUI boolean
function UWBP_Ingame_Chat_Wrapper_C:CanOpenAnyUI(bCanOpenAnyUI) end
function UWBP_Ingame_Chat_Wrapper_C:ShowChat() end
function UWBP_Ingame_Chat_Wrapper_C:BndEvt__WBP_Ingame_Chat_Wrapper_WBP_Ingame_Chat_K2Node_ComponentBoundEvent_0_OnCompleteInput__DelegateSignature() end
---@param EntryPoint int32
function UWBP_Ingame_Chat_Wrapper_C:ExecuteUbergraph_WBP_Ingame_Chat_Wrapper(EntryPoint) end


