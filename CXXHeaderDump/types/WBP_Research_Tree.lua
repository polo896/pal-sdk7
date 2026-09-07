---@meta

---@class UWBP_Research_Tree_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field CanvasPanel_NodeLines UCanvasPanel
---@field CanvasPanel_Nodes UCanvasPanel
---@field ScrollBox UScrollBox
---@field WBP_Research_TreeLv_1 UWBP_Research_TreeLv_C
---@field WBP_Research_TreeLv_2 UWBP_Research_TreeLv_C
---@field WBP_Research_TreeLv_3 UWBP_Research_TreeLv_C
---@field WBP_Research_TreeLv_4 UWBP_Research_TreeLv_C
---@field WBP_Research_TreeLv_5 UWBP_Research_TreeLv_C
---@field WBP_Research_TreeLv_6 UWBP_Research_TreeLv_C
---@field WBP_Research_TreeLv_7 UWBP_Research_TreeLv_C
---@field MinBlockSize int32
---@field TreeIconMap TMap<FName, UWBP_Research_TreeIcon_C>
---@field ResearchType EPalWorkSuitability
---@field OnResearchSelectDelegate FWBP_Research_Tree_COnResearchSelectDelegate
---@field OnResearchHoveredDelegate FWBP_Research_Tree_COnResearchHoveredDelegate
---@field OnResearchUnhoveredDelegate FWBP_Research_Tree_COnResearchUnhoveredDelegate
---@field OnTreeNodeCreate FWBP_Research_Tree_COnTreeNodeCreate
---@field OnTreeLineDrawed FWBP_Research_Tree_COnTreeLineDrawed
---@field CurrentPinedResearch FName
---@field LvBlocks TArray<UWBP_Research_TreeLv_C>
local UWBP_Research_Tree_C = {}

---@param TreeData TMap<FName, FTreeNodeData>
---@param NodeID FName
---@param Rank int32
function UWBP_Research_Tree_C:CalcParentNodeMaxRank(TreeData, NodeID, Rank) end
---@param MyGeometry FGeometry
---@param InAnalogInputEvent FAnalogInputEvent
---@return FEventReply
function UWBP_Research_Tree_C:OnAnalogValueChanged(MyGeometry, InAnalogInputEvent) end
function UWBP_Research_Tree_C:ReleaseCurrentPin() end
---@param FocusTarget UWidget
function UWBP_Research_Tree_C:GetFocusTarget(FocusTarget) end
function UWBP_Research_Tree_C:OnResearchUnhovered() end
---@param ResearchId FName
function UWBP_Research_Tree_C:OnResearchHovered(ResearchId) end
---@param ResearchId FName
function UWBP_Research_Tree_C:OnResearchSelect(ResearchId) end
---@param NodeID FName
---@param NodeData FTreeNodeData
UWBP_Research_Tree_C['Draw Node Line'] = function(self, NodeID, NodeData) end
---@param TreeNodeMap TMap<FName, FTreeNodeData>
---@param CurrentNode FName
---@param RequireSpace int32
function UWBP_Research_Tree_C:CalcNodeSpace(TreeNodeMap, CurrentNode, RequireSpace) end
---@param Researchs TArray<FPalUIGuildLabResearchInfo>
---@param Type EPalWorkSuitability
function UWBP_Research_Tree_C:TreeConstruct(Researchs, Type) end
---@param ResearchInfo FPalUIGuildLabResearchInfo
---@return UWBP_Research_TreeIcon_C
function UWBP_Research_Tree_C:CreateNewIcon(ResearchInfo) end
function UWBP_Research_Tree_C:OnInitialized() end
---@param EntryPoint int32
function UWBP_Research_Tree_C:ExecuteUbergraph_WBP_Research_Tree(EntryPoint) end
---@param Image UImage
---@param RelyParent boolean
---@param ResearchId FName
function UWBP_Research_Tree_C:OnTreeLineDrawed__DelegateSignature(Image, RelyParent, ResearchId) end
---@param NewNode UWBP_Research_TreeIcon_C
function UWBP_Research_Tree_C:OnTreeNodeCreate__DelegateSignature(NewNode) end
function UWBP_Research_Tree_C:OnResearchUnhoveredDelegate__DelegateSignature() end
---@param ResearchId FName
function UWBP_Research_Tree_C:OnResearchHoveredDelegate__DelegateSignature(ResearchId) end
---@param ResearchId FName
function UWBP_Research_Tree_C:OnResearchSelectDelegate__DelegateSignature(ResearchId) end


