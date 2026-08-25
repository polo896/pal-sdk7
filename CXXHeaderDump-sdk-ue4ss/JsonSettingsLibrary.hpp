#ifndef UE4SS_SDK_JsonSettingsLibrary_HPP
#define UE4SS_SDK_JsonSettingsLibrary_HPP

class UJsonSettingsLibrary_C : public UBlueprintFunctionLibrary
{

    void TryGetLocalizedText(FString TableId, FString TextKey, class UObject* __WorldContext, bool& Found, FText& Value);
    FText GetLocalizedText(FString TableId, FString TextKey, FText Fallback, class UObject* __WorldContext);
    FLinearColor GetSettingColor(FJsonObjectWrapper Config, FString Group, FString Key, class UObject* __WorldContext);
    void SetSettingKeybind(FJsonObjectWrapper Config, FString Group, FString Key, FInputChord Value, class UObject* __WorldContext, FJsonObjectWrapper& UpdatedConfig);
    void SetSettingKeymap(FJsonObjectWrapper Config, FString Group, FString Key, FInputActionKeyMapping Value, class UObject* __WorldContext, FJsonObjectWrapper& UpdatedConfig);
    void SetSettingFloat(FJsonObjectWrapper Config, FString Group, FString Key, float Value, class UObject* __WorldContext, FJsonObjectWrapper& UpdatedConfig);
    void SetSettingBool(FJsonObjectWrapper Config, FString Group, FString Key, bool Value, class UObject* __WorldContext, FJsonObjectWrapper& UpdatedConfig);
    FInputActionKeyMapping GetSettingKeymap(FJsonObjectWrapper Config, FString Group, FString Key, class UObject* __WorldContext);
    float GetSettingFloat(FJsonObjectWrapper Config, FString Group, FString Key, class UObject* __WorldContext);
    bool GetSettingBool(FJsonObjectWrapper Config, FString Group, FString Key, class UObject* __WorldContext);
}; // Size: 0x28

#endif
