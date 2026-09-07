---@meta

---@class UWBP_EquipSkin_SkinIcon_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field CircularThrobber UCircularThrobber
---@field Image UImage
---@field OnLoadedTexture FWBP_EquipSkin_SkinIcon_COnLoadedTexture
---@field OnStartLoadTexture FWBP_EquipSkin_SkinIcon_COnStartLoadTexture
---@field OnSetEmpty FWBP_EquipSkin_SkinIcon_COnSetEmpty
local UWBP_EquipSkin_SkinIcon_C = {}

function UWBP_EquipSkin_SkinIcon_C:SetEmpty() end
---@param SkinName FName
---@param IsEquip boolean
function UWBP_EquipSkin_SkinIcon_C:Setup(SkinName, IsEquip) end
---@param Loaded UObject
function UWBP_EquipSkin_SkinIcon_C:OnLoaded_F4FCEC97410E591228B5AA8532DA5248(Loaded) end
---@param SoftTexture TSoftObjectPtr<UTexture2D>
function UWBP_EquipSkin_SkinIcon_C:LoadIconEvent_Internal(SoftTexture) end
---@param EntryPoint int32
function UWBP_EquipSkin_SkinIcon_C:ExecuteUbergraph_WBP_EquipSkin_SkinIcon(EntryPoint) end
function UWBP_EquipSkin_SkinIcon_C:OnSetEmpty__DelegateSignature() end
function UWBP_EquipSkin_SkinIcon_C:OnStartLoadTexture__DelegateSignature() end
---@param Texture UTexture2D
function UWBP_EquipSkin_SkinIcon_C:OnLoadedTexture__DelegateSignature(Texture) end


