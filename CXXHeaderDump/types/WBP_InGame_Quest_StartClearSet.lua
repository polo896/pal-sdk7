---@meta

---@class UWBP_InGame_Quest_StartClearSet_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_InGame_Quest_StartClear_Main UWBP_InGame_Quest_StartClear_Main_C
---@field WBP_InGame_Quest_StartClear_Sub UWBP_InGame_Quest_StartClear_Sub_C
---@field WidgetMap TMap<EPalQuestType, UWBP_InGame_Quest_StartClearBase_C>
---@field NotifyQue TArray<FF_PalQuestStartClearNotifyQueData>
---@field CurrentQuestId FName
---@field OnStartQuestNotify FWBP_InGame_Quest_StartClearSet_COnStartQuestNotify
---@field CurrentWidget UWBP_InGame_Quest_StartClearBase_C
local UWBP_InGame_Quest_StartClearSet_C = {}

---@param BindData FPalUIActionBindData
function UWBP_InGame_Quest_StartClearSet_C:SetActionBindData(BindData) end
---@param NotifyTime double
function UWBP_InGame_Quest_StartClearSet_C:GetCurrentQuestNotifyTime(NotifyTime) end
function UWBP_InGame_Quest_StartClearSet_C:TryNextNotify() end
---@param QuestId FName
function UWBP_InGame_Quest_StartClearSet_C:StartQuest(QuestId) end
---@param QuestId FName
function UWBP_InGame_Quest_StartClearSet_C:CompleteQuest(QuestId) end
function UWBP_InGame_Quest_StartClearSet_C:OnEndWidgetSequence() end
function UWBP_InGame_Quest_StartClearSet_C:OnInitialized() end
---@param EntryPoint int32
function UWBP_InGame_Quest_StartClearSet_C:ExecuteUbergraph_WBP_InGame_Quest_StartClearSet(EntryPoint) end
---@param QuestId FName
function UWBP_InGame_Quest_StartClearSet_C:OnStartQuestNotify__DelegateSignature(QuestId) end


