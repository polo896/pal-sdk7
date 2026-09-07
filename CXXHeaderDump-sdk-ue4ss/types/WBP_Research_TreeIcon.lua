---@meta

---@class UWBP_Research_TreeIcon_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToSelected UWidgetAnimation
---@field Anm_Progressing UWidgetAnimation
---@field Anm_NormalToDisable UWidgetAnimation
---@field Anm_Lock UWidgetAnimation
---@field Anm_Unlock UWidgetAnimation
---@field Anm_NormalToFocus UWidgetAnimation
---@field Canvas_Icon_L UCanvasPanel
---@field Canvas_Icon_S UCanvasPanel
---@field Image_Progress_Rotate_L UImage
---@field Image_Progress_Rotate_S UImage
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field WBP_ResearchEffectIcon UWBP_ResearchEffectIcon_C
---@field ['Research Id'] FName
---@field OnResearchSelect FWBP_Research_TreeIcon_COnResearchSelect
---@field OnResearchHovered FWBP_Research_TreeIcon_COnResearchHovered
---@field OnResearchUnhovered FWBP_Research_TreeIcon_COnResearchUnhovered
---@field ['Display Type'] TreeNodeDisplayType::Type
---@field ['Is Pined'] boolean
local UWBP_Research_TreeIcon_C = {}

function UWBP_Research_TreeIcon_C:AnmEvent_Focus() end
function UWBP_Research_TreeIcon_C:AnmEvent_NoFocus() end
function UWBP_Research_TreeIcon_C:AnmEvent_Lock() end
function UWBP_Research_TreeIcon_C:AnmEvent_Unlock() end
function UWBP_Research_TreeIcon_C:AnmEvent_DIsable() end
function UWBP_Research_TreeIcon_C:AnmEvent_Progressing() end
---@param ResearchInfo FPalUIGuildLabResearchInfo
function UWBP_Research_TreeIcon_C:Setup(ResearchInfo) end
---@param Button UCommonButtonBase
function UWBP_Research_TreeIcon_C:BndEvt__WBP_Research_TreeIcon_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Research_TreeIcon_C:BndEvt__WBP_Research_TreeIcon_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Research_TreeIcon_C:BndEvt__WBP_Research_TreeIcon_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_Research_TreeIcon_C:Construct() end
---@param DisplayType TreeNodeDisplayType::Type
function UWBP_Research_TreeIcon_C:SetDisplayType(DisplayType) end
---@param IsPined boolean
function UWBP_Research_TreeIcon_C:SwitchPin(IsPined) end
---@param EntryPoint int32
function UWBP_Research_TreeIcon_C:ExecuteUbergraph_WBP_Research_TreeIcon(EntryPoint) end
function UWBP_Research_TreeIcon_C:OnResearchUnhovered__DelegateSignature() end
---@param ResearchId FName
function UWBP_Research_TreeIcon_C:OnResearchHovered__DelegateSignature(ResearchId) end
---@param ResearchId FName
function UWBP_Research_TreeIcon_C:OnResearchSelect__DelegateSignature(ResearchId) end


