---@meta

---@class UWBP_PalHUD_InGame_InputListener_C : UPalUIInGameInputListener
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Default_In UWidgetAnimation
---@field WBP_BulletChange UWBP_BulletChange_C
---@field WBP_Ingame_Chat_Wrapper UWBP_Ingame_Chat_Wrapper_C
---@field WBP_InGame_Quest_StartClearSet UWBP_InGame_Quest_StartClearSet_C
---@field WBP_Ingame_WeaponChange UWBP_Ingame_WeaponChange_C
---@field WBP_PalInteractiveObjectIndicatorCanvas UWBP_PalInteractiveObjectIndicatorCanvas_C
---@field WBP_PlayerRadialMenu UWBP_PlayerRadialMenu_C
---@field EscapeActionName FPalDataTableRowName_UIInputAction
---@field OpenCharacterMenuActionName FPalDataTableRowName_UIInputAction
---@field OpenBuildMenuActionName FPalDataTableRowName_UIInputAction
---@field OpenTechnologyMenuActionName FPalDataTableRowName_UIInputAction
---@field OpenWorldMapActionName FPalDataTableRowName_UIInputAction
---@field OpenPalStatusActionName FPalDataTableRowName_UIInputAction
---@field CharacterMenuActionHandle FPalUIActionBindData
---@field OpenChatActionName FPalDataTableRowName_UIInputAction
---@field CharacterMenuAnotherActionHandle FPalUIActionBindData
---@field WorldMapActionHandle FPalUIActionBindData
---@field TechnologyMenuActionHandle FPalUIActionBindData
---@field PalStatusActionHandle FPalUIActionBindData
---@field BeginAdminSpectateActionName FPalDataTableRowName_UIInputAction
---@field SpectatorHudGuid FGuid
---@field TimerHandleOnBeginSpectateNextTick FTimerHandle
---@field QuestCheckActionHandle FPalUIActionBindData
---@field QuestCheckActionName FPalDataTableRowName_UIInputAction
---@field TImerHandle_ClearQuestCheckAction FTimerHandle
---@field CurrentDisplayStartQuestId FName
---@field TimerHandle_DisableWeaponChange FTimerHandle
---@field bIsDIsplayingWeaponList boolean
---@field bLastEquipedLoadoutWeapon boolean
---@field SoftLastEquipedWeapon TSoftObjectPtr<APalWeaponBase>
---@field ThrowPalActionName FPalDataTableRowName_UIInputAction
---@field ThworPalActionHandle FPalUIActionBindData
---@field ThrowPalActionDUmmyPressConsumeHandle FPalUIActionBindData
---@field OpenCharacterMenuActionName_Another FPalDataTableRowName_UIInputAction
local UWBP_PalHUD_InGame_InputListener_C = {}

---@param WeaponActor APalWeaponBase
---@param ReservedBulletItemId FName
function UWBP_PalHUD_InGame_InputListener_C:CREATEDELEGATE_PROXYFUNCTION_1(WeaponActor, ReservedBulletItemId) end
---@param PrevSettings FPalKeyConfigSettings
---@param NewSettings FPalKeyConfigSettings
function UWBP_PalHUD_InGame_InputListener_C:CREATEDELEGATE_PROXYFUNCTION_0(PrevSettings, NewSettings) end
---@param bCanFastTravel boolean
function UWBP_PalHUD_InGame_InputListener_C:CanFastTravel(bCanFastTravel) end
---@param inventoryType EPalPlayerInventoryType
---@param Index int32
function UWBP_PalHUD_InGame_InputListener_C:OnPalSphereLoadoutChanged(inventoryType, Index) end
function UWBP_PalHUD_InGame_InputListener_C:SetupPalSphereChangeEvent() end
function UWBP_PalHUD_InGame_InputListener_C:OnEndLiftupCampPal() end
---@param LiftingPal APalCharacter
function UWBP_PalHUD_InGame_InputListener_C:OnLiftupCampPal(LiftingPal) end
function UWBP_PalHUD_InGame_InputListener_C:SetupLiftupCampPalEvent() end
---@param WeaponActor APalWeaponBase
---@param bLoadoutWeaponOrEmpty boolean
function UWBP_PalHUD_InGame_InputListener_C:IsLoadoutWeapon(WeaponActor, bLoadoutWeaponOrEmpty) end
function UWBP_PalHUD_InGame_InputListener_C:OnUseWeapon() end
function UWBP_PalHUD_InGame_InputListener_C:DisableWeaponChangeList() end
---@param Weapon APalWeaponBase
function UWBP_PalHUD_InGame_InputListener_C:OnChangedWeapon(Weapon) end
function UWBP_PalHUD_InGame_InputListener_C:SetupWeaponChangeEvent() end
function UWBP_PalHUD_InGame_InputListener_C:ResetDisableWeaponChangeTimer() end
function UWBP_PalHUD_InGame_InputListener_C:OnTimerEvent_DisableWeaponChangeEvent() end
function UWBP_PalHUD_InGame_InputListener_C:EnableWeaponChangeList() end
---@param WeaponActor APalWeaponBase
---@param BulletItemId FName
function UWBP_PalHUD_InGame_InputListener_C:OnChangeReserveBullet(WeaponActor, BulletItemId) end
function UWBP_PalHUD_InGame_InputListener_C:OnEndSelectingBullet() end
function UWBP_PalHUD_InGame_InputListener_C:OnStartSelectingBullet() end
function UWBP_PalHUD_InGame_InputListener_C:SetupBulletChangeEvent() end
function UWBP_PalHUD_InGame_InputListener_C:OpenChatInternal() end
function UWBP_PalHUD_InGame_InputListener_C:SetupOpenChatEvent() end
function UWBP_PalHUD_InGame_InputListener_C:OnTriggerThrowPal() end
---@param QuestId FName
function UWBP_PalHUD_InGame_InputListener_C:OnTriggerWorldMapWithQuestId(QuestId) end
---@param QuestId FName
function UWBP_PalHUD_InGame_InputListener_C:OnRequestOpenMap_ByQuest(QuestId) end
---@param QuestId FName
function UWBP_PalHUD_InGame_InputListener_C:OnRequestOpenQuest_ByMap(QuestId) end
function UWBP_PalHUD_InGame_InputListener_C:OnTimerEvent_ClearQuestCheckAction() end
---@param QuestId FName
function UWBP_PalHUD_InGame_InputListener_C:OnStartQuestNotify(QuestId) end
function UWBP_PalHUD_InGame_InputListener_C:OnInputAction_QuestCheck() end
---@param QuestId FName
function UWBP_PalHUD_InGame_InputListener_C:OnCompleteQuest(QuestId) end
---@param QuestId FName
function UWBP_PalHUD_InGame_InputListener_C:OnOrderedQuest(QuestId) end
function UWBP_PalHUD_InGame_InputListener_C:SetupQuestEvent() end
UWBP_PalHUD_InGame_InputListener_C['On End Arena Spectate'] = function(self, ) end
UWBP_PalHUD_InGame_InputListener_C['On Begin Arena Spectate'] = function(self, ) end
function UWBP_PalHUD_InGame_InputListener_C:BeginAdminSpectate() end
function UWBP_PalHUD_InGame_InputListener_C:OnEndSpectate() end
function UWBP_PalHUD_InGame_InputListener_C:OnBeginSpectateNextTick() end
function UWBP_PalHUD_InGame_InputListener_C:OnBeginSpectate() end
function UWBP_PalHUD_InGame_InputListener_C:SetupSpectateEvent() end
---@param PreSetting FPalKeyConfigSettings
---@param NewSetting FPalKeyConfigSettings
function UWBP_PalHUD_InGame_InputListener_C:OnKeyConfigChanged(PreSetting, NewSetting) end
function UWBP_PalHUD_InGame_InputListener_C:RequestOpenChat() end
---@param CanOpenUI boolean
UWBP_PalHUD_InGame_InputListener_C['Can Open Any UI'] = function(self, CanOpenUI) end
---@param SelectedIndex int32
function UWBP_PalHUD_InGame_InputListener_C:OpenBuildRadialMenuWithSelectedIndex(SelectedIndex) end
---@param BuildObjectId FName
function UWBP_PalHUD_InGame_InputListener_C:OpenBuildRadialMenu(BuildObjectId) end
function UWBP_PalHUD_InGame_InputListener_C:OnTriggerWorldMap() end
UWBP_PalHUD_InGame_InputListener_C['Setup Input Action'] = function(self, ) end
---@param BuildObjectTypeA int32
function UWBP_PalHUD_InGame_InputListener_C:OpenBuildMenu(BuildObjectTypeA) end
---@param TabType EPalUIInGameMainMenuTabType::Type
---@param BuildObjectTypeA EPalBuildObjectTypeA
---@param bDisableFirstCancelAction boolean
---@param QuestId FName
function UWBP_PalHUD_InGame_InputListener_C:OpenMenu_Internal(TabType, BuildObjectTypeA, bDisableFirstCancelAction, QuestId) end
function UWBP_PalHUD_InGame_InputListener_C:OnTriggerEscape() end
function UWBP_PalHUD_InGame_InputListener_C:OnTriggerOpenPalStatus() end
function UWBP_PalHUD_InGame_InputListener_C:OnTriggerOpenTechnologyMenu() end
function UWBP_PalHUD_InGame_InputListener_C:OnTriggerOpenBuildMenu() end
function UWBP_PalHUD_InGame_InputListener_C:OnTriggerOpenCraftMenu() end
UWBP_PalHUD_InGame_InputListener_C['On Trigger Open Inventory Menu'] = function(self, ) end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_PalHUD_InGame_InputListener_C:Tick(MyGeometry, InDeltaTime) end
function UWBP_PalHUD_InGame_InputListener_C:OnSetup_AfterCreatedPlayer() end
function UWBP_PalHUD_InGame_InputListener_C:BndEvt__WBP_PalHUD_InGame_InputListener_WBP_PlayerRadialMenu_K2Node_ComponentBoundEvent_1_OnRequestOpenChat__DelegateSignature() end
---@param QuestId FName
function UWBP_PalHUD_InGame_InputListener_C:BndEvt__WBP_PalHUD_InGame_InputListener_WBP_InGame_Quest_StartClearSet_K2Node_ComponentBoundEvent_2_OnStartQuestNotify__DelegateSignature(QuestId) end
---@param EntryPoint int32
function UWBP_PalHUD_InGame_InputListener_C:ExecuteUbergraph_WBP_PalHUD_InGame_InputListener(EntryPoint) end


