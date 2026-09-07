---@meta

---@class ABP_PumpActionShotgun_C : ABP_ShotgunBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ['Montage to Play'] UAnimMontage
---@field FireAnim UAnimSequence
---@field ReloadSpeedPlayRate double
local ABP_PumpActionShotgun_C = {}

function ABP_PumpActionShotgun_C:EjectARound() end
---@return boolean
function ABP_PumpActionShotgun_C:IsUseLeftHandAttach() end
---@param IsShoted boolean
function ABP_PumpActionShotgun_C:OnshotInternal(IsShoted) end
function ABP_PumpActionShotgun_C:PlayReloadAnimation() end
---@param NotifyName FName
function ABP_PumpActionShotgun_C:OnNotifyEnd_FCB44FF643DA97B49C538D845683A965(NotifyName) end
---@param NotifyName FName
function ABP_PumpActionShotgun_C:OnNotifyBegin_FCB44FF643DA97B49C538D845683A965(NotifyName) end
---@param NotifyName FName
function ABP_PumpActionShotgun_C:OnInterrupted_FCB44FF643DA97B49C538D845683A965(NotifyName) end
---@param NotifyName FName
function ABP_PumpActionShotgun_C:OnBlendOut_FCB44FF643DA97B49C538D845683A965(NotifyName) end
---@param NotifyName FName
function ABP_PumpActionShotgun_C:OnCompleted_FCB44FF643DA97B49C538D845683A965(NotifyName) end
---@param NotifyName FName
function ABP_PumpActionShotgun_C:OnNotifyEnd_022E6E364FB50AA73CEBFDBEFEDC6736(NotifyName) end
---@param NotifyName FName
function ABP_PumpActionShotgun_C:OnNotifyBegin_022E6E364FB50AA73CEBFDBEFEDC6736(NotifyName) end
---@param NotifyName FName
function ABP_PumpActionShotgun_C:OnInterrupted_022E6E364FB50AA73CEBFDBEFEDC6736(NotifyName) end
---@param NotifyName FName
function ABP_PumpActionShotgun_C:OnBlendOut_022E6E364FB50AA73CEBFDBEFEDC6736(NotifyName) end
---@param NotifyName FName
function ABP_PumpActionShotgun_C:OnCompleted_022E6E364FB50AA73CEBFDBEFEDC6736(NotifyName) end
---@param InReloadSpeedPlayRate float
function ABP_PumpActionShotgun_C:OnReloadStart(InReloadSpeedPlayRate) end
---@param bCanShootOnRelease boolean
function ABP_PumpActionShotgun_C:OnReleaseTrigger(bCanShootOnRelease) end
function ABP_PumpActionShotgun_C:ReceiveBeginPlay() end
---@param Type EWeaponNotifyType
function ABP_PumpActionShotgun_C:OnWeaponNotify(Type) end
function ABP_PumpActionShotgun_C:OnShot() end
function ABP_PumpActionShotgun_C:OnRestartReload() end
---@param EntryPoint int32
function ABP_PumpActionShotgun_C:ExecuteUbergraph_BP_PumpActionShotgun(EntryPoint) end


