---@meta

---@class UWBP_Ingame_Incubator_AllOpen_List_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToFocus UWidgetAnimation
---@field BP_PalTextBlock_Name UBP_PalTextBlock_C
---@field Image_Mutant UImage
---@field Image_PalIcon UImage
---@field Image_passive_0 UImage
---@field Image_passive_1 UImage
---@field Image_passive_2 UImage
---@field Image_passive_3 UImage
---@field Image_Strong UImage
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field Passives TArray<UImage>
---@field Index int32
---@field OnHatchedInfoHovered FWBP_Ingame_Incubator_AllOpen_List_COnHatchedInfoHovered
---@field OnHatchedInfoUnhovered FWBP_Ingame_Incubator_AllOpen_List_COnHatchedInfoUnhovered
local UWBP_Ingame_Incubator_AllOpen_List_C = {}

---@param Button UCommonButtonBase
function UWBP_Ingame_Incubator_AllOpen_List_C:BndEvt__WBP_Ingame_Incubator_AllOpen_List_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Ingame_Incubator_AllOpen_List_C:BndEvt__WBP_Ingame_Incubator_AllOpen_List_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param individualParam UPalIndividualCharacterParameter
function UWBP_Ingame_Incubator_AllOpen_List_C:Setup(individualParam) end
function UWBP_Ingame_Incubator_AllOpen_List_C:OnInitialized() end
---@param EntryPoint int32
function UWBP_Ingame_Incubator_AllOpen_List_C:ExecuteUbergraph_WBP_Ingame_Incubator_AllOpen_List(EntryPoint) end
function UWBP_Ingame_Incubator_AllOpen_List_C:OnHatchedInfoUnhovered__DelegateSignature() end
---@param Index int32
function UWBP_Ingame_Incubator_AllOpen_List_C:OnHatchedInfoHovered__DelegateSignature(Index) end


