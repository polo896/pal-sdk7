---@meta

---@class UWBP_Ingame_Chat_C : UPalUIChat
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_OpenToClose UWidgetAnimation
---@field Anm_SendToLog UWidgetAnimation
---@field InputVisualBox UVerticalBox
---@field Overlay_InputText UOverlay
---@field Overlay_SendChatGuide UOverlay
---@field PalMultiLineEditableTextBox_220 UPalMultiLineEditableTextBox
---@field SelectCategoryButton UOverlay
---@field SelectedCategory USizeBox
---@field SizeBox_ControlGuide USizeBox
---@field SizeBox_RecievedText USizeBox
---@field Text_ChatSendCategory UBP_PalTextBlock_C
---@field WBP_PalCommonScrollList UWBP_PalCommonScrollList_C
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
---@field WBP_PalKeyGuideIcon_1 UWBP_PalKeyGuideIcon_C
---@field OnCompleteInput FWBP_Ingame_Chat_COnCompleteInput
---@field OpenInventoryActionHandle FPalUIActionBindData
---@field SelectCategory EPalChatCategory
---@field ChatCloseTimer FTimerHandle
---@field ChatHintTextMsgID FDataTableRowHandle
---@field IsShowChatInputUI boolean
---@field DiscordFriend UDiscordRelationshipHandle
---@field DefaultSelectCategory EPalChatCategory
---@field ShouldCloseOnEscapeRelease boolean
---@field RightStickAnalogValue float
---@field FlushTimerHandle FTimerHandle
---@field PendingFlushMessages TArray<FPalChatMessage>
---@field BoundCutsceneComponent UPalCutsceneComponent
---@field MessageMax int32
---@field FlushMessageMaxByTick int32
---@field IsInsideFlushCallback boolean
local UWBP_Ingame_Chat_C = {}

---@param MyGeometry FGeometry
---@param InAnalogInputEvent FAnalogInputEvent
---@return FEventReply
function UWBP_Ingame_Chat_C:OnAnalogValueChanged(MyGeometry, InAnalogInputEvent) end
---@param ChatMessage FPalChatMessage
---@param OutColor FLinearColor
function UWBP_Ingame_Chat_C:GetGlobalChatColor(ChatMessage, OutColor) end
function UWBP_Ingame_Chat_C:ResetFocus() end
---@param ChatMessage FPalChatMessage
---@param bShouldLoad boolean
function UWBP_Ingame_Chat_C:ShouldLoadChatMessage(ChatMessage, bShouldLoad) end
function UWBP_Ingame_Chat_C:LoadChatMessages() end
---@param Message FPalChatMessage
function UWBP_Ingame_Chat_C:AddChatMessage(Message) end
---@param bNewInputType ECommonInputType
function UWBP_Ingame_Chat_C:OnChangedInputType(bNewInputType) end
---@param InText FText
---@param InTextCommit ETextCommit::Type
function UWBP_Ingame_Chat_C:OnTextCommittedInternal(InText, InTextCommit) end
---@param MyGeometry FGeometry
---@param InKeyEvent FKeyEvent
---@return FEventReply
function UWBP_Ingame_Chat_C:OnPreviewKeyDown(MyGeometry, InKeyEvent) end
---@param Result boolean
UWBP_Ingame_Chat_C['Can Chat'] = function(self, Result) end
function UWBP_Ingame_Chat_C:ChangeCategory() end
UWBP_Ingame_Chat_C['Hide Chat Log UI'] = function(self, ) end
---@param Message FPalChatMessage
UWBP_Ingame_Chat_C['On Recived Chat'] = function(self, Message) end
function UWBP_Ingame_Chat_C:Construct() end
function UWBP_Ingame_Chat_C:ShowChatInputUI() end
function UWBP_Ingame_Chat_C:HideChatInputUI() end
function UWBP_Ingame_Chat_C:OpenChatUI() end
function UWBP_Ingame_Chat_C:Destruct() end
---@param Text FText
---@param CommitMethod ETextCommit::Type
function UWBP_Ingame_Chat_C:BndEvt__WBP_Ingame_Chat_PalMultiLineEditableTextBox_220_K2Node_ComponentBoundEvent_5_OnMultiLineEditableTextBoxCommittedEvent__DelegateSignature(Text, CommitMethod) end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_Ingame_Chat_C:Tick(MyGeometry, InDeltaTime) end
function UWBP_Ingame_Chat_C:ScrollEndNextTick() end
function UWBP_Ingame_Chat_C:OnFlushTick() end
function UWBP_Ingame_Chat_C:OnPlayCutsceneStart() end
---@param IsSkipped_ boolean
function UWBP_Ingame_Chat_C:OnFinishCutscene(IsSkipped_) end
---@param EntryPoint int32
function UWBP_Ingame_Chat_C:ExecuteUbergraph_WBP_Ingame_Chat(EntryPoint) end
function UWBP_Ingame_Chat_C:OnCompleteInput__DelegateSignature() end


