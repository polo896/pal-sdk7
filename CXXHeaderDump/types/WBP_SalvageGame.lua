---@meta

---@class UWBP_SalvageGame_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Image_216 UImage
---@field WBP_Fishing_SalvageGame UWBP_Fishing_SalvageGame_C
---@field NeedleRotateAngularSpeed double
---@field NeedleAngle double
---@field bStoppedNeedle boolean
---@field SuccessAngleRange FFloatInterval
---@field bFinishedGame boolean
local UWBP_SalvageGame_C = {}

function UWBP_SalvageGame_C:RequestFinishSalvageGame() end
function UWBP_SalvageGame_C:OnActionInteract() end
---@param DeltaTime double
function UWBP_SalvageGame_C:ProceedNeedle(DeltaTime) end
---@param Angle double
function UWBP_SalvageGame_C:UpdateRouletteNeedle(Angle) end
---@param SuccessStartAngle double
---@param SuccessEndAngle double
function UWBP_SalvageGame_C:SetupRouletteSetting(SuccessStartAngle, SuccessEndAngle) end
function UWBP_SalvageGame_C:SetupUI() end
---@param Model UPalUIMapObjectTreasureBoxSalvageGameModel
function UWBP_SalvageGame_C:GetUIModel(Model) end
function UWBP_SalvageGame_C:OnSetup() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_SalvageGame_C:Tick(MyGeometry, InDeltaTime) end
---@param bSuccess boolean
function UWBP_SalvageGame_C:PlayResultAnimation(bSuccess) end
function UWBP_SalvageGame_C:OnClose() end
---@param EntryPoint int32
function UWBP_SalvageGame_C:ExecuteUbergraph_WBP_SalvageGame(EntryPoint) end


