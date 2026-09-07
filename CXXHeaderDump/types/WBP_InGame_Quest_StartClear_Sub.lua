---@meta

---@class UWBP_InGame_Quest_StartClear_Sub_C : UWBP_InGame_Quest_StartClearBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Out UWidgetAnimation
---@field Anm_Complete UWidgetAnimation
---@field Anm_Start UWidgetAnimation
---@field BaseLineC UImage
---@field BaseLineC_Bloom UImage
---@field BaseLineL UImage
---@field BaseLineL_Bloom UImage
---@field BaseLineR UImage
---@field BaseLineR_Bloom UImage
---@field Image_190 UImage
---@field Image_Flash_Add UImage
---@field Image_Prism UImage
---@field Image_Prism_1 UImage
---@field Image_Prism_2 UImage
---@field Image_Prism_Add_Complete UImage
---@field Image_Prism_Add_Start UImage
---@field Overlay_KeyGuide UOverlay
---@field RichText_Title UBP_PalRichTextBlock_C
---@field Text_Quest_Complete UBP_PalTextBlock_C
---@field Text_Quest_New UBP_PalTextBlock_C
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
---@field NotifyQue TArray<FF_PalQuestStartClearNotifyQueData>
---@field WaitTime_StartToOut double
---@field WaitTime_ClearToOut double
---@field WaitTIme_NextNotify double
---@field TimerHandle_StartToOut FTimerHandle
---@field TimerHandle_WaitNextNotify FTimerHandle
---@field OnStartQuestNotify FWBP_InGame_Quest_StartClear_Sub_COnStartQuestNotify
---@field CompleteSound boolean
local UWBP_InGame_Quest_StartClear_Sub_C = {}

---@param InQuestName FText
function UWBP_InGame_Quest_StartClear_Sub_C:SetQuestName(InQuestName) end
---@param BindData FPalUIActionBindData
function UWBP_InGame_Quest_StartClear_Sub_C:SetBindData(BindData) end
---@param NotifyTime double
function UWBP_InGame_Quest_StartClear_Sub_C:GetQuestNotifyTime(NotifyTime) end
function UWBP_InGame_Quest_StartClear_Sub_C:PlayOrder() end
function UWBP_InGame_Quest_StartClear_Sub_C:PlayClear() end
---@param NewParam double
function UWBP_InGame_Quest_StartClear_Sub_C:GetStartQuestNotifyTime(NewParam) end
function UWBP_InGame_Quest_StartClear_Sub_C:OnTImerEvent_EndOutAnimation() end
function UWBP_InGame_Quest_StartClear_Sub_C:OnTimerEvent_EndStartAnimation() end
function UWBP_InGame_Quest_StartClear_Sub_C:AnmEvent_StartQuest() end
function UWBP_InGame_Quest_StartClear_Sub_C:AnmEvent_Out_Order() end
function UWBP_InGame_Quest_StartClear_Sub_C:AnmEvent_CompleteQuest() end
function UWBP_InGame_Quest_StartClear_Sub_C:Destruct() end
function UWBP_InGame_Quest_StartClear_Sub_C:Construct() end
---@param EntryPoint int32
function UWBP_InGame_Quest_StartClear_Sub_C:ExecuteUbergraph_WBP_InGame_Quest_StartClear_Sub(EntryPoint) end
---@param QuestId FName
function UWBP_InGame_Quest_StartClear_Sub_C:OnStartQuestNotify__DelegateSignature(QuestId) end


