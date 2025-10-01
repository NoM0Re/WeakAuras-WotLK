local Quest =
{
	Name = "Quest",
	Type = "System",
	Namespace = "Quest",

	Functions =
	{
		{
			Name = "AbandonQuest",
			Type = "Function",

		},
		{
			Name = "AcceptQuest",
			Type = "Function",

		},
		{
			Name = "AddQuestWatch",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CloseQuest",
			Type = "Function",

		},
		{
			Name = "CollapseQuestHeader",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CompleteQuest",
			Type = "Function",

		},
		{
			Name = "ConfirmAcceptQuest",
			Type = "Function",

		},
		{
			Name = "DeclineQuest",
			Type = "Function",

		},
		{
			Name = "ExpandQuestHeader",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "GetAbandonQuestItems",
			Type = "Function",

			Returns =
			{
				{ Name = "items", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetAbandonQuestName",
			Type = "Function",

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetActiveLevel",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "level", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetActiveTitle",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "title", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetAvailableLevel",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "level", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetAvailableTitle",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "title", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetDailyQuestsCompleted",
			Type = "Function",

			Returns =
			{
				{ Name = "dailyQuestsComplete", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetGossipActiveQuests",
			Type = "Function",

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "level", Type = "number", Nilable = false },
				{ Name = "isTrivial", Type = "bool", Nilable = false },
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetGossipAvailableQuests",
			Type = "Function",

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "level", Type = "number", Nilable = false },
				{ Name = "isTrivial", Type = "bool", Nilable = false },
				{ Name = "isDaily", Type = "bool", Nilable = false },
				{ Name = "isRepeatable", Type = "bool", Nilable = false },
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetGreetingText",
			Type = "Function",

			Returns =
			{
				{ Name = "greetingText", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetMaxDailyQuests",
			Type = "Function",

			Returns =
			{
				{ Name = "max", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumActiveQuests",
			Type = "Function",

			Returns =
			{
				{ Name = "numActiveQuests", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumAvailableQuests",
			Type = "Function",

			Returns =
			{
				{ Name = "numAvailableQuests", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumGossipActiveQuests",
			Type = "Function",

			Returns =
			{
				{ Name = "num", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumGossipAvailableQuests",
			Type = "Function",

			Returns =
			{
				{ Name = "num", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumQuestChoices",
			Type = "Function",

			Returns =
			{
				{ Name = "numQuestChoices", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumQuestItems",
			Type = "Function",

			Returns =
			{
				{ Name = "numRequiredItems", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumQuestLeaderBoards",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = true },
			},

			Returns =
			{
				{ Name = "numObjectives", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumQuestLogChoices",
			Type = "Function",

			Returns =
			{
				{ Name = "numChoices", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumQuestLogEntries",
			Type = "Function",

			Returns =
			{
				{ Name = "numEntries", Type = "number", Nilable = false },
				{ Name = "numQuests", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumQuestLogRewards",
			Type = "Function",

			Returns =
			{
				{ Name = "numRewards", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumQuestRewards",
			Type = "Function",

			Returns =
			{
				{ Name = "numQuestRewards", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumQuestWatches",
			Type = "Function",

			Returns =
			{
				{ Name = "numWatches", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumWorldStateUI",
			Type = "Function",

			Returns =
			{
				{ Name = "numUI", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetObjectiveText",
			Type = "Function",

			Returns =
			{
				{ Name = "questObjective", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetProgressText",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetQuestBackgroundMaterial",
			Type = "Function",

			Returns =
			{
				{ Name = "material", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetQuestDifficultyColor",
			Type = "Function",

			Arguments =
			{
				{ Name = "level", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "color", Type = "table", Nilable = false },
			},
		},
		{
			Name = "GetQuestGreenRange",
			Type = "Function",

			Returns =
			{
				{ Name = "range", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestIndexForTimer",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetQuestIndexForWatch",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetQuestItemInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "numItems", Type = "number", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
				{ Name = "isUsable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetQuestItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemType", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetQuestLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogChoiceInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "numItems", Type = "number", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
				{ Name = "isUsable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogCompletionText",
			Type = "Function",

			Returns =
			{
				{ Name = "completionText", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogGroupNum",
			Type = "Function",

			Returns =
			{
				{ Name = "suggestedGroup", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemType", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "GetQuestLogLeaderBoard",
			Type = "Function",

			Arguments =
			{
				{ Name = "objective", Type = "number", Nilable = false },
				{ Name = "questIndex", Type = "luaIndex", Nilable = true },
			},

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "finished", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogPushable",
			Type = "Function",

			Returns =
			{
				{ Name = "shareable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogQuestText",
			Type = "Function",

			Returns =
			{
				{ Name = "questDescription", Type = "string", Nilable = false },
				{ Name = "questObjectives", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogRequiredMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "money", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogRewardInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "numItems", Type = "number", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
				{ Name = "isUsable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogRewardMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "money", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogRewardSpell",
			Type = "Function",

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "isTradeskillSpell", Type = "bool", Nilable = false },
				{ Name = "isSpellLearned", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogRewardTalents",
			Type = "Function",

			Returns =
			{
				{ Name = "talents", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogRewardTitle",
			Type = "Function",

			Returns =
			{
				{ Name = "title", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogSelection",
			Type = "Function",

			Returns =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogSpecialItemCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "start", Type = "number", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "enable", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogSpecialItemInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "charges", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogSpellLink",
			Type = "Function",

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogTimeLeft",
			Type = "Function",

			Returns =
			{
				{ Name = "questTimer", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogTitle",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "questLogTitleText", Type = "string", Nilable = false },
				{ Name = "level", Type = "number", Nilable = false },
				{ Name = "questTag", Type = "string", Nilable = false },
				{ Name = "suggestedGroup", Type = "number", Nilable = false },
				{ Name = "isHeader", Type = "bool", Nilable = false },
				{ Name = "isCollapsed", Type = "bool", Nilable = false },
				{ Name = "isComplete", Type = "number", Nilable = false },
				{ Name = "isDaily", Type = "bool", Nilable = false },
				{ Name = "questID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestMoneyToGet",
			Type = "Function",

			Returns =
			{
				{ Name = "money", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestResetTime",
			Type = "Function",

			Returns =
			{
				{ Name = "time", Type = "time_t", Nilable = false },
			},
		},
		{
			Name = "GetQuestReward",
			Type = "Function",

			Arguments =
			{
				{ Name = "choice", Type = "number", Nilable = false },
			},

		},
		{
			Name = "GetQuestSpellLink",
			Type = "Function",

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetQuestText",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetQuestTimers",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetQuestsCompleted",
			Type = "Function",

			Arguments =
			{
				{ Name = "questTbl", Type = "table", Nilable = false },
			},

			Returns =
			{
				{ Name = "completedQuests", Type = "table", Nilable = false },
			},
		},
		{
			Name = "GetRewardHonor",
			Type = "Function",

			Returns =
			{
				{ Name = "honor", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetRewardMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "money", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetRewardSpell",
			Type = "Function",

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "isTradeskillSpell", Type = "bool", Nilable = false },
				{ Name = "isSpellLearned", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetRewardTalents",
			Type = "Function",

			Returns =
			{
				{ Name = "talents", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetRewardText",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetRewardTitle",
			Type = "Function",

			Returns =
			{
				{ Name = "title", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetRewardXP",
			Type = "Function",

		},
		{
			Name = "GetSuggestedGroupNum",
			Type = "Function",

			Returns =
			{
				{ Name = "suggestedGroup", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTitleText",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetWorldStateUIInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "uiType", Type = "number", Nilable = false },
				{ Name = "state", Type = "number", Nilable = false },
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "dynamicIcon", Type = "string", Nilable = false },
				{ Name = "tooltip", Type = "string", Nilable = false },
				{ Name = "dynamicTooltip", Type = "string", Nilable = false },
				{ Name = "extendedUI", Type = "string", Nilable = false },
				{ Name = "extendedUIState1", Type = "number", Nilable = false },
				{ Name = "extendedUIState2", Type = "number", Nilable = false },
				{ Name = "extendedUIState3", Type = "number", Nilable = false },
			},
		},
		{
			Name = "IsActiveQuestTrivial",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "trivial", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsAvailableQuestTrivial",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "trivial", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsCurrentQuestFailed",
			Type = "Function",

			Returns =
			{
				{ Name = "isFailed", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsQuestCompletable",
			Type = "Function",

			Returns =
			{
				{ Name = "isCompletable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsQuestLogSpecialItemInRange",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "inRange", Type = "number", Nilable = false },
			},
		},
		{
			Name = "IsQuestWatched",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "isWatched", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsUnitOnQuest",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "state", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "QueryQuestsCompleted",
			Type = "Function",

		},
		{
			Name = "QuestChooseRewardError",
			Type = "Function",

		},
		{
			Name = "QuestFlagsPVP",
			Type = "Function",

			Returns =
			{
				{ Name = "questFlag", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "QuestGetAutoAccept",
			Type = "Function",

		},
		{
			Name = "QuestLogPushQuest",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = true },
			},

		},
		{
			Name = "RemoveQuestWatch",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SelectActiveQuest",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SelectAvailableQuest",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SelectGossipActiveQuest",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SelectGossipAvailableQuest",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SelectQuestLogEntry",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetAbandonQuest",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "UseQuestLogSpecialItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "BnRequestFofFailed",
			Type = "Event",
			LiteralName = "BN_REQUEST_FOF_FAILED",
		},
		{
			Name = "BnRequestFofSucceeded",
			Type = "Event",
			LiteralName = "BN_REQUEST_FOF_SUCCEEDED",
		},
		{
			Name = "DuelRequested",
			Type = "Event",
			LiteralName = "DUEL_REQUESTED",
			Payload =
			{
				{ Name = "challenger", Type = "string", Nilable = false },
			},
		},
		{
			Name = "QuestAccepted",
			Type = "Event",
			LiteralName = "QUEST_ACCEPTED",
			Payload =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "QuestAcceptConfirm",
			Type = "Event",
			LiteralName = "QUEST_ACCEPT_CONFIRM",
			Payload =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "quest", Type = "string", Nilable = false },
			},
		},
		{
			Name = "QuestComplete",
			Type = "Event",
			LiteralName = "QUEST_COMPLETE",
		},
		{
			Name = "QuestDetail",
			Type = "Event",
			LiteralName = "QUEST_DETAIL",
		},
		{
			Name = "QuestFinished",
			Type = "Event",
			LiteralName = "QUEST_FINISHED",
		},
		{
			Name = "QuestGreeting",
			Type = "Event",
			LiteralName = "QUEST_GREETING",
		},
		{
			Name = "QuestItemUpdate",
			Type = "Event",
			LiteralName = "QUEST_ITEM_UPDATE",
		},
		{
			Name = "QuestLogUpdate",
			Type = "Event",
			LiteralName = "QUEST_LOG_UPDATE",
		},
		{
			Name = "QuestPoiUpdate",
			Type = "Event",
			LiteralName = "QUEST_POI_UPDATE",
		},
		{
			Name = "QuestProgress",
			Type = "Event",
			LiteralName = "QUEST_PROGRESS",
		},
		{
			Name = "QuestQueryComplete",
			Type = "Event",
			LiteralName = "QUEST_QUERY_COMPLETE",
		},
		{
			Name = "QuestWatchUpdate",
			Type = "Event",
			LiteralName = "QUEST_WATCH_UPDATE",
			Payload =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "ResurrectRequest",
			Type = "Event",
			LiteralName = "RESURRECT_REQUEST",
			Payload =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "TradeRequest",
			Type = "Event",
			LiteralName = "TRADE_REQUEST",
		},
		{
			Name = "TradeRequestCancel",
			Type = "Event",
			LiteralName = "TRADE_REQUEST_CANCEL",
		},
		{
			Name = "UnitQuestLogChanged",
			Type = "Event",
			LiteralName = "UNIT_QUEST_LOG_CHANGED",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Quest);
