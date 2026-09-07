---@meta

---@class UWBP_BulletChange_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ScrollBox_Bullet UPalScrollBox
---@field WBP_BulletChangeList UWBP_BulletChangeList_C
---@field WBP_BulletChangeList_126 UWBP_BulletChangeList_C
---@field WBP_PlayerInputKeyGuideIcon UWBP_PlayerInputKeyGuideIcon_C
---@field ListWidgetMap TMap<FName, UWBP_BulletChangeList_C>
---@field LastSelectedWidget UWBP_BulletChangeList_C
---@field FadeoutTimerHandle FTimerHandle
---@field CurrentSelectedBulletId FName
---@field ChangeNextBulletAction FPalDataTableRowName_UIInputAction
---@field ChangePrevBulletAction FPalDataTableRowName_UIInputAction
---@field ChangeBulletNextActionHandle FPalUIActionBindData
---@field ChangeBulletPrevActionHandle FPalUIActionBindData
local UWBP_BulletChange_C = {}

function UWBP_BulletChange_C:OnInputAction_ChangePrevBullet() end
function UWBP_BulletChange_C:OnInputAction_ChangeNextBullet() end
function UWBP_BulletChange_C:UnregisterChangeBulletAction() end
function UWBP_BulletChange_C:RegisterChangeBulletAction() end
---@param TargetBulletId FName
function UWBP_BulletChange_C:ScrollToBullet(TargetBulletId) end
function UWBP_BulletChange_C:ToListDisplay() end
---@param CurrentBulletId FName
---@param bPlayFadeAnimation boolean
function UWBP_BulletChange_C:ToSimpleDisplay(CurrentBulletId, bPlayFadeAnimation) end
function UWBP_BulletChange_C:OnTimerEvent_Fadeout() end
function UWBP_BulletChange_C:ClearFadeoutTImer() end
function UWBP_BulletChange_C:ResetFadeoutTimer() end
---@param BulletItemId FName
function UWBP_BulletChange_C:SelectBullet(BulletItemId) end
---@param BulletItemIdList TArray<FName>
function UWBP_BulletChange_C:SetBulletList(BulletItemIdList) end
function UWBP_BulletChange_C:Destruct() end
---@param EntryPoint int32
function UWBP_BulletChange_C:ExecuteUbergraph_WBP_BulletChange(EntryPoint) end


