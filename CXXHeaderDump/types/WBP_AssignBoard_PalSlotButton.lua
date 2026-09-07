---@meta

---@class UWBP_AssignBoard_PalSlotButton_C : UWBP_PalCharacterSlotButtonBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_AssignBoard_PalSlot UWBP_AssignBoard_PalSlot_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
local UWBP_AssignBoard_PalSlotButton_C = {}

---@param Suitability EPalWorkSuitability
function UWBP_AssignBoard_PalSlotButton_C:SetSuitability(Suitability) end
---@param Suitabilities TArray<EPalWorkSuitability>
function UWBP_AssignBoard_PalSlotButton_C:SetReferenceWorkSuitability(Suitabilities) end
---@param WorkId FGuid
function UWBP_AssignBoard_PalSlotButton_C:SetReferenceWorkId(WorkId) end
---@param IsCheck boolean
function UWBP_AssignBoard_PalSlotButton_C:SetSelectedCheck(IsCheck) end
---@param isDisplay boolean
function UWBP_AssignBoard_PalSlotButton_C:SetDisplayGender(isDisplay) end
---@param IsAssign boolean
UWBP_AssignBoard_PalSlotButton_C['Set Is Fixed Assign'] = function(self, IsAssign) end
---@param characterSlotWidget UWBP_PalCharacterSlotBase_C
function UWBP_AssignBoard_PalSlotButton_C:RegisterCharacterSlotWidget(characterSlotWidget) end
---@param Button UCommonButtonBase
function UWBP_AssignBoard_PalSlotButton_C:RegisterButton(Button) end
function UWBP_AssignBoard_PalSlotButton_C:OnInitialized() end
---@param Button UCommonButtonBase
function UWBP_AssignBoard_PalSlotButton_C:BndEvt__WBP_AssignBoard_PalSlotButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_AssignBoard_PalSlotButton_C:BndEvt__WBP_AssignBoard_PalSlotButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_AssignBoard_PalSlotButton_C:ExecuteUbergraph_WBP_AssignBoard_PalSlotButton(EntryPoint) end


