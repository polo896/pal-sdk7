---@meta

---@class AModActor_C : AActor
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DefaultSceneRoot USceneComponent
---@field ActorMap TMap<AActor, UPaperSpriteComponent>
---@field ReadyForHUDTimer FTimerHandle
---@field ['Position Mode'] boolean
---@field Hidden boolean
---@field ModAuthor FString
---@field ModName FString
---@field ModDescription FString
---@field ModVersion FString
---@field ModLocation FString
---@field UpKeyDown boolean
---@field DownKeyDown boolean
---@field LeftKeyDown boolean
---@field RightKeyDown boolean
---@field ShiftKeyDown boolean
---@field CtrlKeyDown boolean
---@field AltKeyDown boolean
---@field NumPlusDown boolean
---@field NumMinusDown boolean
---@field SzeneCaptureComponent USceneCaptureComponent2D
---@field AssetLoading TMap<FName, FString>
---@field PlayerPosition FText
---@field InBase boolean
---@field ManuallyHidden boolean
---@field TitleScreenButtonShown boolean
---@field landScapeRealPositionMin FVector
---@field landScapeRealPositionMax FVector
---@field DisplayScale float
---@field DisplayOffsetX float
---@field DisplayOffsetY float
---@field LiveConfig FJsonObjectWrapper
---@field DefaultConfigJson FString
---@field MergeWorkingConfig FJsonObjectWrapper
---@field ZoomInDown boolean
---@field ZoomOutDown boolean
---@field OtomoActorMap TMap<AActor, UPaperSpriteComponent>
---@field PlayerActorMap TMap<AActor, UPaperSpriteComponent>
---@field NPCActorMap TMap<AActor, UPaperSpriteComponent>
---@field LocalPlayerCharacter APalPlayerCharacter
---@field ZoomInKeymapCached FInputActionKeyMapping
---@field ZoomOutKeymapCached FInputActionKeyMapping
---@field MapUpKeymapCached FInputActionKeyMapping
---@field MapDownKeymapCached FInputActionKeyMapping
---@field MapLeftKeymapCached FInputActionKeyMapping
---@field MapRightKeymapCached FInputActionKeyMapping
---@field MapBiggerKeymapCached FInputActionKeyMapping
---@field MapSmallerKeymapCached FInputActionKeyMapping
---@field ActiveStringTableId FString
---@field ActiveStringTable UObject
local AModActor_C = {}

---@param TargetActor AActor
---@param IconTexture UTexture2D
---@param ScaleSettingKey FString
---@param HeightOffset float
---@param Sprite UPaperSpriteComponent
---@param IconComponent UBP_MinimapIconActor_C
function AModActor_C:CreateMinimapIconWithTexture(TargetActor, IconTexture, ScaleSettingKey, HeightOffset, Sprite, IconComponent) end
---@param TargetActor AActor
---@param IconPath FSoftObjectPath
---@param ScaleSettingKey FString
---@param HeightOffset float
---@param Sprite UPaperSpriteComponent
---@param IconComponent UBP_MinimapIconActor_C
function AModActor_C:CreateMinimapIcon(TargetActor, IconPath, ScaleSettingKey, HeightOffset, Sprite, IconComponent) end
function AModActor_C:ContinuousZoomTick() end
function AModActor_C:MergeConfigWithDefaults() end
function AModActor_C:PersistConfig() end
---@param Coordinates FVector2D
function AModActor_C:GetPlayerMapCoordinates(Coordinates) end
function AModActor_C:RenderMap() end
function AModActor_C:BaseEnteredDetection() end
function AModActor_C:ToggleSuperZoom() end
function AModActor_C:UpdateMapPosition() end
function AModActor_C:MoveMapKeyDetection() end
function AModActor_C:ToggleMapPressDetection() end
AModActor_C['Map Move Mode Press Detection'] = function(self, ) end
function AModActor_C:CheckCtrlDown() end
function AModActor_C:CheckAltDown() end
function AModActor_C:CheckShiftDown() end
---@param InputActionKeyMapping FInputActionKeyMapping
---@return boolean
function AModActor_C:IsHotkeyMappingReleased(InputActionKeyMapping) end
---@param InputActionKeyMapping FInputActionKeyMapping
---@return boolean
function AModActor_C:IsHotkeyMappingPressed(InputActionKeyMapping) end
function AModActor_C:InitConfig() end
---@param File_Path FFilePath
function AModActor_C:GetFilepath(File_Path) end
---@param ConfigAsJson FJsonObjectWrapper
function AModActor_C:LoadConfigFromFile(ConfigAsJson) end
---@param Message FString
function AModActor_C:DebugPrint(Message) end
---@param self2 APlayerController
function AModActor_C:CreateHUD(self2) end
---@param IsPlayerInGame boolean
function AModActor_C:IsPlayerInGame(IsPlayerInGame) end
function AModActor_C:CheckReadyForHUD() end
---@param actorClass TSubclassOf<AActor>
---@param Texture UTexture2D
function AModActor_C:ScanAndMarkType(actorClass, Texture) end
---@param Texture UTexture2D
function AModActor_C:ScanAndMarkDungeon(Texture) end
function AModActor_C:ScanAndMarkNPC() end
function AModActor_C:ScanAndMarkPlayer() end
function AModActor_C:ScanAndMarkOtomoPal() end
function AModActor_C:ScanAndMarkWIldPal() end
function AModActor_C:ScanAndMarkRelic() end
function AModActor_C:ScanAndMarkNote() end
function AModActor_C:ScanTypes() end
---@param PC APlayerController
AModActor_C['Create Capture Screen Component 2D'] = function(self, PC) end
---@param Message FString
function AModActor_C:PrintToModLoader(Message) end
function AModActor_C:PostBeginPlay() end
function AModActor_C:ReadyForHUD() end
function AModActor_C:SetupBindingsForModConfig() end
---@param Unique_Mod_Config_Name FString
---@param On_Saved_Callback_Name FString
---@param On_Updated_Callback_Name FString
function AModActor_C:SetupModConfigBindings(Unique_Mod_Config_Name, On_Saved_Callback_Name, On_Updated_Callback_Name) end
function AModActor_C:OnSavedModConfig() end
function AModActor_C:OnUpdatedModConfig() end
---@param DeltaSeconds float
function AModActor_C:ReceiveTick(DeltaSeconds) end
function AModActor_C:CheckTitleScreen() end
---@param EntryPoint int32
function AModActor_C:ExecuteUbergraph_ModActor(EntryPoint) end


