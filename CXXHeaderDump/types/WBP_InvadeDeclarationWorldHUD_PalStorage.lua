---@meta

---@class UWBP_InvadeDeclarationWorldHUD_PalStorage_C : UPalUserWidgetWorldHUD
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_WarningEvent_NoticeTimer UWBP_WarningEvent_NoticeTimer_C
---@field SimpleDisplayDistance double
---@field CachedPalStorageLocation FVector
---@field bCurrentInvadeTarget boolean
---@field CachedBaseCampId FGuid
---@field SimpleDistanceSquared double
local UWBP_InvadeDeclarationWorldHUD_PalStorage_C = {}

---@param StartRealTime FDateTime
function UWBP_InvadeDeclarationWorldHUD_PalStorage_C:OnInvadeDeclaration(StartRealTime) end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_InvadeDeclarationWorldHUD_PalStorage_C:Tick(MyGeometry, InDeltaTime) end
function UWBP_InvadeDeclarationWorldHUD_PalStorage_C:OnSetup() end
UWBP_InvadeDeclarationWorldHUD_PalStorage_C['カスタムイベント'] = function(self, ) end
---@param EntryPoint int32
function UWBP_InvadeDeclarationWorldHUD_PalStorage_C:ExecuteUbergraph_WBP_InvadeDeclarationWorldHUD_PalStorage(EntryPoint) end


