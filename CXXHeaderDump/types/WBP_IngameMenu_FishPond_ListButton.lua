---@meta

---@class UWBP_IngameMenu_FishPond_ListButton_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Selected UWidgetAnimation
---@field Anm_NormalToFocus UWidgetAnimation
---@field Image_3 UImage
---@field Image_Base UImage
---@field Image_Base_Focus UImage
---@field Image_Base_Selected UImage
---@field Image_Frame UImage
---@field Image_Frame_1 UImage
---@field Image_Time_1 UImage
---@field Image_Time_2 UImage
---@field Image_Time_3 UImage
---@field Image_Time_4 UImage
---@field Image_Time_5 UImage
---@field Text_FishingPlan UBP_PalTextBlock_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnClickSlot FWBP_IngameMenu_FishPond_ListButton_COnClickSlot
---@field OnHoveredSlot FWBP_IngameMenu_FishPond_ListButton_COnHoveredSlot
---@field OnUnhoveredSlot FWBP_IngameMenu_FishPond_ListButton_COnUnhoveredSlot
---@field Selected boolean
---@field TargetLotteryName FName
---@field VisibleWorkAmountValues TArray<double>
local UWBP_IngameMenu_FishPond_ListButton_C = {}

---@param TargetImage UWidget
---@param Value double
---@param Threshold double
function UWBP_IngameMenu_FishPond_ListButton_C:SetVisibilityMoreThanValue(TargetImage, Value, Threshold) end
---@param RequiredWorkAmount double
function UWBP_IngameMenu_FishPond_ListButton_C:UpdateRequiredTimeDisplay(RequiredWorkAmount) end
function UWBP_IngameMenu_FishPond_ListButton_C:SetUnselect() end
---@param InTargetInfo FPalUIMapObjectFishPondTargetInfo
function UWBP_IngameMenu_FishPond_ListButton_C:Setup(InTargetInfo) end
---@param Button UCommonButtonBase
function UWBP_IngameMenu_FishPond_ListButton_C:BndEvt__WBP_IngameMenu_FishPond_ListButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_IngameMenu_FishPond_ListButton_C:BndEvt__WBP_IngameMenu_FishPond_ListButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_IngameMenu_FishPond_ListButton_C:BndEvt__WBP_IngameMenu_FishPond_ListButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_IngameMenu_FishPond_ListButton_C:ExecuteUbergraph_WBP_IngameMenu_FishPond_ListButton(EntryPoint) end
---@param SelfSlot UWBP_IngameMenu_FishPond_ListButton_C
function UWBP_IngameMenu_FishPond_ListButton_C:OnUnhoveredSlot__DelegateSignature(SelfSlot) end
---@param SelfSlot UWBP_IngameMenu_FishPond_ListButton_C
function UWBP_IngameMenu_FishPond_ListButton_C:OnHoveredSlot__DelegateSignature(SelfSlot) end
---@param SelfSlot UWBP_IngameMenu_FishPond_ListButton_C
function UWBP_IngameMenu_FishPond_ListButton_C:OnClickSlot__DelegateSignature(SelfSlot) end


