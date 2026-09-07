---@meta

---@class ABP_Item_Anim_PalEgg_Base_C : AActor
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SK_Kurinuki_EggA USkeletalMeshComponent
---@field DefaultSceneRoot USceneComponent
---@field HatchingTemperature int32
local ABP_Item_Anim_PalEgg_Base_C = {}

---@param Temperature int32
function ABP_Item_Anim_PalEgg_Base_C:GetHatchingTemperature(Temperature) end
---@param IsPlay boolean
function ABP_Item_Anim_PalEgg_Base_C:SetAnimPlayState(IsPlay) end
function ABP_Item_Anim_PalEgg_Base_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_Item_Anim_PalEgg_Base_C:ExecuteUbergraph_BP_Item_Anim_PalEgg_Base(EntryPoint) end


