---@meta

---@class UJsonSettingsLibrary_C : UBlueprintFunctionLibrary
local UJsonSettingsLibrary_C = {}

---@param TableId FString
---@param TextKey FString
---@param __WorldContext UObject
---@param Found boolean
---@param Value FText
function UJsonSettingsLibrary_C:TryGetLocalizedText(TableId, TextKey, __WorldContext, Found, Value) end
---@param TableId FString
---@param TextKey FString
---@param Fallback FText
---@param __WorldContext UObject
---@return FText
function UJsonSettingsLibrary_C:GetLocalizedText(TableId, TextKey, Fallback, __WorldContext) end
---@param Config FJsonObjectWrapper
---@param Group FString
---@param Key FString
---@param __WorldContext UObject
---@return FLinearColor
function UJsonSettingsLibrary_C:GetSettingColor(Config, Group, Key, __WorldContext) end
---@param Config FJsonObjectWrapper
---@param Group FString
---@param Key FString
---@param Value FInputChord
---@param __WorldContext UObject
---@param UpdatedConfig FJsonObjectWrapper
function UJsonSettingsLibrary_C:SetSettingKeybind(Config, Group, Key, Value, __WorldContext, UpdatedConfig) end
---@param Config FJsonObjectWrapper
---@param Group FString
---@param Key FString
---@param Value FInputActionKeyMapping
---@param __WorldContext UObject
---@param UpdatedConfig FJsonObjectWrapper
function UJsonSettingsLibrary_C:SetSettingKeymap(Config, Group, Key, Value, __WorldContext, UpdatedConfig) end
---@param Config FJsonObjectWrapper
---@param Group FString
---@param Key FString
---@param Value float
---@param __WorldContext UObject
---@param UpdatedConfig FJsonObjectWrapper
function UJsonSettingsLibrary_C:SetSettingFloat(Config, Group, Key, Value, __WorldContext, UpdatedConfig) end
---@param Config FJsonObjectWrapper
---@param Group FString
---@param Key FString
---@param Value boolean
---@param __WorldContext UObject
---@param UpdatedConfig FJsonObjectWrapper
function UJsonSettingsLibrary_C:SetSettingBool(Config, Group, Key, Value, __WorldContext, UpdatedConfig) end
---@param Config FJsonObjectWrapper
---@param Group FString
---@param Key FString
---@param __WorldContext UObject
---@return FInputActionKeyMapping
function UJsonSettingsLibrary_C:GetSettingKeymap(Config, Group, Key, __WorldContext) end
---@param Config FJsonObjectWrapper
---@param Group FString
---@param Key FString
---@param __WorldContext UObject
---@return float
function UJsonSettingsLibrary_C:GetSettingFloat(Config, Group, Key, __WorldContext) end
---@param Config FJsonObjectWrapper
---@param Group FString
---@param Key FString
---@param __WorldContext UObject
---@return boolean
function UJsonSettingsLibrary_C:GetSettingBool(Config, Group, Key, __WorldContext) end


