---@meta

---@class UWBP_BuildObject_MedicalPalBed_WorldHUD_C : UPalUserWidgetWorldHUD
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_PalRevivalTimer UWBP_PalRevivalTimer_C
---@field UIModelCached UPalUIMapObjectMedicalPalBedModel
local UWBP_BuildObject_MedicalPalBed_WorldHUD_C = {}

function UWBP_BuildObject_MedicalPalBed_WorldHUD_C:TickForDisplay() end
---@param Return_Value boolean
function UWBP_BuildObject_MedicalPalBed_WorldHUD_C:ShouldDisplay(Return_Value) end
function UWBP_BuildObject_MedicalPalBed_WorldHUD_C:ReflectProgressRate() end
function UWBP_BuildObject_MedicalPalBed_WorldHUD_C:ReflectResurrectAbility() end
function UWBP_BuildObject_MedicalPalBed_WorldHUD_C:ReflectRemainingTime() end
---@param UIModel UPalUIMapObjectMedicalPalBedModel
function UWBP_BuildObject_MedicalPalBed_WorldHUD_C:GetUIModel(UIModel) end
function UWBP_BuildObject_MedicalPalBed_WorldHUD_C:Setup() end
function UWBP_BuildObject_MedicalPalBed_WorldHUD_C:OnSetup() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_BuildObject_MedicalPalBed_WorldHUD_C:Tick(MyGeometry, InDeltaTime) end
---@param EntryPoint int32
function UWBP_BuildObject_MedicalPalBed_WorldHUD_C:ExecuteUbergraph_WBP_BuildObject_MedicalPalBed_WorldHUD(EntryPoint) end


