---@meta

---@class UBP_Action_Unique_MoonQueen_IceMoonBlade_C : UBP_Action_Unique_MoonQueen_MoonBlade_C
---@field UberGraphFrame FPointerToUberGraphFrame
local UBP_Action_Unique_MoonQueen_IceMoonBlade_C = {}

---@param Motages TArray<FReserveMontage>
function UBP_Action_Unique_MoonQueen_IceMoonBlade_C:GetMontageArray(Motages) end
---@param Instance ABP_SkillEffect_Unique_MoonQueen_MoonBlade_C
function UBP_Action_Unique_MoonQueen_IceMoonBlade_C:SpawnMoonBlade(Instance) end
function UBP_Action_Unique_MoonQueen_IceMoonBlade_C:OnBeginAction() end
function UBP_Action_Unique_MoonQueen_IceMoonBlade_C:OnEndAction() end
---@param Montage UAnimMontage
function UBP_Action_Unique_MoonQueen_IceMoonBlade_C:SpecialBlade(Montage) end
---@param EntryPoint int32
function UBP_Action_Unique_MoonQueen_IceMoonBlade_C:ExecuteUbergraph_BP_Action_Unique_MoonQueen_IceMoonBlade(EntryPoint) end


