local Uncategorized =
{
	Name = "Uncategorized",
	Type = "System",
	Namespace = "Uncategorized",

	Functions =
	{
		{
			Name = "AcceptProposal",
			Type = "Function",

		},
		{
			Name = "BNAcceptFriendInvite",
			Type = "Function",

		},
		{
			Name = "BNConnected",
			Type = "Function",

			Returns =
			{
				{ Name = "isOnline", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "BNCreateConversation",
			Type = "Function",

			Arguments =
			{
				{ Name = "presenceID_1", Type = "number", Nilable = false },
				{ Name = "presenceID_2", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "result", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "BNDeclineFriendInvite",
			Type = "Function",

		},
		{
			Name = "BNFeaturesEnabled",
			Type = "Function",

			Returns =
			{
				{ Name = "isEnabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "BNFeaturesEnabledAndConnected",
			Type = "Function",

		},
		{
			Name = "BNGetBlockedInfo",
			Type = "Function",

		},
		{
			Name = "BNGetBlockedToonInfo",
			Type = "Function",

		},
		{
			Name = "BNGetConversationInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "type", Type = "string", Nilable = false },
			},
		},
		{
			Name = "BNGetConversationMemberInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "number", Nilable = false },
				{ Name = "memberIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "presenceID", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "displayName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "BNGetCustomMessageTable",
			Type = "Function",

		},
		{
			Name = "BNGetFOFInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "presenceID", Type = "number", Nilable = false },
				{ Name = "mutual", Type = "bool", Nilable = false },
				{ Name = "non-mutual", Type = "bool", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "presenceID", Type = "number", Nilable = false },
				{ Name = "givenName", Type = "string", Nilable = false },
				{ Name = "surname", Type = "string", Nilable = false },
				{ Name = "isFriend", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "BNGetFriendInviteInfo",
			Type = "Function",

		},
		{
			Name = "BNGetMaxPlayersInConversation",
			Type = "Function",

			Returns =
			{
				{ Name = "count", Type = "number", Nilable = false },
			},
		},
		{
			Name = "BNGetNumBlocked",
			Type = "Function",

		},
		{
			Name = "BNGetNumBlockedToons",
			Type = "Function",

		},
		{
			Name = "BNGetNumConversationMembers",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "memberCount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "BNGetNumFOF",
			Type = "Function",

		},
		{
			Name = "BNGetNumFriendInvites",
			Type = "Function",

		},
		{
			Name = "BNGetSelectedBlock",
			Type = "Function",

		},
		{
			Name = "BNGetSelectedToonBlock",
			Type = "Function",

		},
		{
			Name = "BNInviteToConversation",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "number", Nilable = false },
				{ Name = "presenceID", Type = "number", Nilable = false },
			},

		},
		{
			Name = "BNIsBlocked",
			Type = "Function",

		},
		{
			Name = "BNIsFriend",
			Type = "Function",

		},
		{
			Name = "BNIsSelf",
			Type = "Function",

			Arguments =
			{
				{ Name = "presenceID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isSelf", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "BNIsToonBlocked",
			Type = "Function",

		},
		{
			Name = "BNLeaveConversation",
			Type = "Function",

		},
		{
			Name = "BNListConversation",
			Type = "Function",

		},
		{
			Name = "BNRemoveFriend",
			Type = "Function",

		},
		{
			Name = "BNReportFriendInvite",
			Type = "Function",

		},
		{
			Name = "BNReportPlayer",
			Type = "Function",

		},
		{
			Name = "BNRequestFOFInfo",
			Type = "Function",

		},
		{
			Name = "BNSendConversationMessage",
			Type = "Function",

		},
		{
			Name = "BNSendFriendInvite",
			Type = "Function",

		},
		{
			Name = "BNSendFriendInviteByID",
			Type = "Function",

		},
		{
			Name = "BNSendWhisper",
			Type = "Function",

		},
		{
			Name = "BNSetAFK",
			Type = "Function",

		},
		{
			Name = "BNSetBlocked",
			Type = "Function",

		},
		{
			Name = "BNSetDND",
			Type = "Function",

		},
		{
			Name = "BNSetFocus",
			Type = "Function",

		},
		{
			Name = "BNSetSelectedBlock",
			Type = "Function",

		},
		{
			Name = "BNSetSelectedFriend",
			Type = "Function",

		},
		{
			Name = "BNSetSelectedToonBlock",
			Type = "Function",

		},
		{
			Name = "BNSetToonBlocked",
			Type = "Function",

		},
		{
			Name = "BattlefieldMgrEntryInviteResponse",
			Type = "Function",

		},
		{
			Name = "BattlefieldMgrExitRequest",
			Type = "Function",

		},
		{
			Name = "BattlefieldMgrQueueInviteResponse",
			Type = "Function",

		},
		{
			Name = "BattlefieldMgrQueueRequest",
			Type = "Function",

		},
		{
			Name = "CalendarContextInviteTentative",
			Type = "Function",

		},
		{
			Name = "CalendarEventTentative",
			Type = "Function",

		},
		{
			Name = "CalendarGetDayEventSequenceInfo",
			Type = "Function",

		},
		{
			Name = "CanChangePlayerDifficulty",
			Type = "Function",

		},
		{
			Name = "CanMapChangeDifficulty",
			Type = "Function",

		},
		{
			Name = "CanPartyLFGBackfill",
			Type = "Function",

		},
		{
			Name = "CanResetTutorials",
			Type = "Function",

		},
		{
			Name = "CancelSell",
			Type = "Function",

		},
		{
			Name = "CannotBeResurrected",
			Type = "Function",

		},
		{
			Name = "ChangePlayerDifficulty",
			Type = "Function",

		},
		{
			Name = "ClearAllLFGDungeons",
			Type = "Function",

		},
		{
			Name = "ClearLFGDungeon",
			Type = "Function",

		},
		{
			Name = "CompleteLFGRoleCheck",
			Type = "Function",

		},
		{
			Name = "DungeonUsesTerrainMap",
			Type = "Function",

		},
		{
			Name = "FindSpellBookSlotByID",
			Type = "Function",

		},
		{
			Name = "ForceGossip",
			Type = "Function",

		},
		{
			Name = "GMReportLag",
			Type = "Function",

		},
		{
			Name = "GetAllowLowLevelRaid",
			Type = "Function",

		},
		{
			Name = "GetAutoCompletePresenceID",
			Type = "Function",

		},
		{
			Name = "GetAvailableQuestInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "availableIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "isTrivial", Type = "bool", Nilable = false },
				{ Name = "isDaily", Type = "bool", Nilable = false },
				{ Name = "isRepeatable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetChatWindowSavedDimensions",
			Type = "Function",

		},
		{
			Name = "GetChatWindowSavedPosition",
			Type = "Function",

		},
		{
			Name = "GetContainerItemQuestInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isQuest", Type = "bool", Nilable = false },
				{ Name = "questId", Type = "number", Nilable = false },
				{ Name = "isActive", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetFactionInfoByID",
			Type = "Function",

			Arguments =
			{
				{ Name = "factionID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "description", Type = "string", Nilable = false },
				{ Name = "standingID", Type = "number", Nilable = false },
				{ Name = "barMin", Type = "number", Nilable = false },
				{ Name = "barMax", Type = "number", Nilable = false },
				{ Name = "barValue", Type = "number", Nilable = false },
				{ Name = "atWarWith", Type = "bool", Nilable = false },
				{ Name = "canToggleAtWar", Type = "bool", Nilable = false },
				{ Name = "isHeader", Type = "bool", Nilable = false },
				{ Name = "isCollapsed", Type = "bool", Nilable = false },
				{ Name = "hasRep", Type = "bool", Nilable = false },
				{ Name = "isWatched", Type = "bool", Nilable = false },
				{ Name = "isChild", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetInstanceLockTimeRemainingEncounter",
			Type = "Function",

		},
		{
			Name = "GetLFDChoiceCollapseState",
			Type = "Function",

		},
		{
			Name = "GetLFDChoiceEnabledState",
			Type = "Function",

		},
		{
			Name = "GetLFDChoiceLockedState",
			Type = "Function",

		},
		{
			Name = "GetLFDLockInfo",
			Type = "Function",

		},
		{
			Name = "GetLFDLockPlayerCount",
			Type = "Function",

		},
		{
			Name = "GetLFGBootProposal",
			Type = "Function",

		},
		{
			Name = "GetLFGCompletionReward",
			Type = "Function",

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "typeID", Type = "number", Nilable = false },
				{ Name = "textureFilename", Type = "string", Nilable = false },
				{ Name = "moneyBase", Type = "number", Nilable = false },
				{ Name = "moneyVar", Type = "number", Nilable = false },
				{ Name = "experienceBase", Type = "number", Nilable = false },
				{ Name = "experienceVar", Type = "number", Nilable = false },
				{ Name = "numStrangers", Type = "number", Nilable = false },
				{ Name = "numRewards", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetLFGCompletionRewardItem",
			Type = "Function",

		},
		{
			Name = "GetLFGDeserterExpiration",
			Type = "Function",

		},
		{
			Name = "GetLFGDungeonInfo",
			Type = "Function",

		},
		{
			Name = "GetLFGDungeonRewardInfo",
			Type = "Function",

		},
		{
			Name = "GetLFGDungeonRewardLink",
			Type = "Function",

		},
		{
			Name = "GetLFGDungeonRewards",
			Type = "Function",

		},
		{
			Name = "GetLFGInfoLocal",
			Type = "Function",

		},
		{
			Name = "GetLFGInfoServer",
			Type = "Function",

		},
		{
			Name = "GetLFGProposal",
			Type = "Function",

		},
		{
			Name = "GetLFGProposalEncounter",
			Type = "Function",

		},
		{
			Name = "GetLFGProposalMember",
			Type = "Function",

		},
		{
			Name = "GetLFGQueueStats",
			Type = "Function",

		},
		{
			Name = "GetLFGQueuedList",
			Type = "Function",

		},
		{
			Name = "GetLFGRandomCooldownExpiration",
			Type = "Function",

		},
		{
			Name = "GetLFGRandomDungeonInfo",
			Type = "Function",

		},
		{
			Name = "GetLFGRoleUpdate",
			Type = "Function",

		},
		{
			Name = "GetLFGRoleUpdateMember",
			Type = "Function",

		},
		{
			Name = "GetLFGRoleUpdateSlot",
			Type = "Function",

		},
		{
			Name = "GetLFRChoiceOrder",
			Type = "Function",

		},
		{
			Name = "GetLastQueueStatusIndex",
			Type = "Function",

		},
		{
			Name = "GetMultiCastBarOffset",
			Type = "Function",

		},
		{
			Name = "GetMultiCastTotemSpells",
			Type = "Function",

		},
		{
			Name = "GetNextCompleatedTutorial",
			Type = "Function",

		},
		{
			Name = "GetNumQuestItemDrops",
			Type = "Function",

		},
		{
			Name = "GetNumQuestLogRewardFactions",
			Type = "Function",

		},
		{
			Name = "GetNumRandomDungeons",
			Type = "Function",

		},
		{
			Name = "GetPartyLFGBackfillInfo",
			Type = "Function",

		},
		{
			Name = "GetPetSpellBonusDamage",
			Type = "Function",

		},
		{
			Name = "GetPrevCompleatedTutorial",
			Type = "Function",

		},
		{
			Name = "GetQuestLogItemDrop",
			Type = "Function",

		},
		{
			Name = "GetQuestLogRewardArenaPoints",
			Type = "Function",

		},
		{
			Name = "GetQuestLogRewardFactionInfo",
			Type = "Function",

		},
		{
			Name = "GetQuestLogRewardXP",
			Type = "Function",

			Returns =
			{
				{ Name = "experience", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestPOILeaderBoard",
			Type = "Function",

		},
		{
			Name = "GetQuestSortIndex",
			Type = "Function",

		},
		{
			Name = "GetQuestWatchIndex",
			Type = "Function",

			Arguments =
			{
				{ Name = "questLogIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "questWatchIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetQuestWorldMapAreaID",
			Type = "Function",

		},
		{
			Name = "GetRaidDifficulty",
			Type = "Function",

		},
		{
			Name = "GetRandomBGHonorCurrencyBonuses",
			Type = "Function",

		},
		{
			Name = "GetRandomDungeonBestChoice",
			Type = "Function",

		},
		{
			Name = "GetRewardArenaPoints",
			Type = "Function",

			Returns =
			{
				{ Name = "arenaPoints", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetVehicleUIIndicator",
			Type = "Function",

		},
		{
			Name = "GetVehicleUIIndicatorSeat",
			Type = "Function",

		},
		{
			Name = "HasCompletedAnyAchievement",
			Type = "Function",

			Returns =
			{
				{ Name = "state", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "HasLFGRestrictions",
			Type = "Function",

		},
		{
			Name = "IsBNLogin",
			Type = "Function",

		},
		{
			Name = "IsInLFGDungeon",
			Type = "Function",

		},
		{
			Name = "IsLFGDungeonJoinable",
			Type = "Function",

		},
		{
			Name = "IsListedInLFR",
			Type = "Function",

			Returns =
			{
				{ Name = "listedInLFR", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsPartyLFG",
			Type = "Function",

		},
		{
			Name = "IsPetAttackAction",
			Type = "Function",

		},
		{
			Name = "IsTutorialFlagged",
			Type = "Function",

		},
		{
			Name = "IsZoomOutAvailable",
			Type = "Function",

		},
		{
			Name = "JoinLFG",
			Type = "Function",

		},
		{
			Name = "LeaveLFG",
			Type = "Function",

		},
		{
			Name = "PartyLFGStartBackfill",
			Type = "Function",

		},
		{
			Name = "ProcessQuestLogRewardFactions",
			Type = "Function",

		},
		{
			Name = "QuestIsDaily",
			Type = "Function",

		},
		{
			Name = "QuestIsWeekly",
			Type = "Function",

		},
		{
			Name = "QuestMapUpdateAllQuests",
			Type = "Function",

		},
		{
			Name = "QuestPOIGetIconInfo",
			Type = "Function",

		},
		{
			Name = "QuestPOIGetQuestIDByIndex",
			Type = "Function",

		},
		{
			Name = "QuestPOIGetQuestIDByVisibleIndex",
			Type = "Function",

		},
		{
			Name = "QuestPOIUpdateIcons",
			Type = "Function",

		},
		{
			Name = "RefreshLFGList",
			Type = "Function",

		},
		{
			Name = "RegisterStaticConstants",
			Type = "Function",

		},
		{
			Name = "RejectProposal",
			Type = "Function",

		},
		{
			Name = "RequestLFDPartyLockInfo",
			Type = "Function",

		},
		{
			Name = "RequestLFDPlayerLockInfo",
			Type = "Function",

		},
		{
			Name = "RespondMailLockSendItem",
			Type = "Function",

		},
		{
			Name = "SearchLFGGetEncounterResults",
			Type = "Function",

		},
		{
			Name = "SearchLFGGetJoinedID",
			Type = "Function",

		},
		{
			Name = "SearchLFGGetNumResults",
			Type = "Function",

		},
		{
			Name = "SearchLFGGetPartyResults",
			Type = "Function",

		},
		{
			Name = "SearchLFGGetResults",
			Type = "Function",

		},
		{
			Name = "SearchLFGJoin",
			Type = "Function",

		},
		{
			Name = "SearchLFGLeave",
			Type = "Function",

		},
		{
			Name = "SearchLFGSort",
			Type = "Function",

		},
		{
			Name = "SendSystemMessage",
			Type = "Function",

		},
		{
			Name = "SetAllowLowLevelRaid",
			Type = "Function",

			Arguments =
			{
				{ Name = "enable", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "SetAuctionsTabShowing",
			Type = "Function",

		},
		{
			Name = "SetChatColorNameByClass",
			Type = "Function",

			Arguments =
			{
				{ Name = "chatType", Type = "string", Nilable = false },
				{ Name = "colorByName", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "SetChatWindowSavedDimensions",
			Type = "Function",

		},
		{
			Name = "SetChatWindowSavedPosition",
			Type = "Function",

		},
		{
			Name = "SetLFGBootVote",
			Type = "Function",

		},
		{
			Name = "SetLFGDungeon",
			Type = "Function",

			Arguments =
			{
				{ Name = "queueIndex", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetLFGDungeonEnabled",
			Type = "Function",

		},
		{
			Name = "SetLFGHeaderCollapsed",
			Type = "Function",

		},
		{
			Name = "SetMapByID",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetPOIIconOverlapDistance",
			Type = "Function",

		},
		{
			Name = "SetPOIIconOverlapPushDistance",
			Type = "Function",

		},
		{
			Name = "SetSavedInstanceExtend",
			Type = "Function",

		},
		{
			Name = "ShiftQuestWatches",
			Type = "Function",

		},
		{
			Name = "SortBGList",
			Type = "Function",

		},
		{
			Name = "SortQuestWatches",
			Type = "Function",

			Returns =
			{
				{ Name = "changed", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "Stopwatch_Clear",
			Type = "Function",

		},
		{
			Name = "Stopwatch_FinishCountdown",
			Type = "Function",

		},
		{
			Name = "Stopwatch_IsPlaying",
			Type = "Function",

		},
		{
			Name = "Stopwatch_Pause",
			Type = "Function",

		},
		{
			Name = "Stopwatch_Play",
			Type = "Function",

		},
		{
			Name = "Stopwatch_StartCountdown",
			Type = "Function",

		},
		{
			Name = "Stopwatch_Toggle",
			Type = "Function",

		},
		{
			Name = "TriggerTutorial",
			Type = "Function",

		},
		{
			Name = "UnitGroupRolesAssigned",
			Type = "Function",

		},
		{
			Name = "UnitHasLFGDeserter",
			Type = "Function",

		},
		{
			Name = "UnitHasLFGRandomCooldown",
			Type = "Function",

		},
		{
			Name = "debughook",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "BindEnchant",
			Type = "Event",
			LiteralName = "BIND_ENCHANT",
		},
		{
			Name = "ConfirmBinder",
			Type = "Event",
			LiteralName = "CONFIRM_BINDER",
			Payload =
			{
				{ Name = "newHome", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ConfirmDisenchantRoll",
			Type = "Event",
			LiteralName = "CONFIRM_DISENCHANT_ROLL",
		},
		{
			Name = "ConfirmSummon",
			Type = "Event",
			LiteralName = "CONFIRM_SUMMON",
		},
		{
			Name = "ConfirmXpLoss",
			Type = "Event",
			LiteralName = "CONFIRM_XP_LOSS",
		},
		{
			Name = "CorpseInRange",
			Type = "Event",
			LiteralName = "CORPSE_IN_RANGE",
		},
		{
			Name = "CorpseOutOfRange",
			Type = "Event",
			LiteralName = "CORPSE_OUT_OF_RANGE",
		},
		{
			Name = "DisableTaxiBenchmark",
			Type = "Event",
			LiteralName = "DISABLE_TAXI_BENCHMARK",
		},
		{
			Name = "DisableXpGain",
			Type = "Event",
			LiteralName = "DISABLE_XP_GAIN",
		},
		{
			Name = "EnableTaxiBenchmark",
			Type = "Event",
			LiteralName = "ENABLE_TAXI_BENCHMARK",
		},
		{
			Name = "EnableXpGain",
			Type = "Event",
			LiteralName = "ENABLE_XP_GAIN",
		},
		{
			Name = "RunePowerUpdate",
			Type = "Event",
			LiteralName = "RUNE_POWER_UPDATE",
			Payload =
			{
				{ Name = "runeIndex", Type = "luaIndex", Nilable = false },
				{ Name = "isEnergize", Type = "string", Nilable = false },
			},
		},
		{
			Name = "RuneTypeUpdate",
			Type = "Event",
			LiteralName = "RUNE_TYPE_UPDATE",
			Payload =
			{
				{ Name = "runeIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "ScreenshotFailed",
			Type = "Event",
			LiteralName = "SCREENSHOT_FAILED",
		},
		{
			Name = "ScreenshotSucceeded",
			Type = "Event",
			LiteralName = "SCREENSHOT_SUCCEEDED",
		},
		{
			Name = "UpdateBindings",
			Type = "Event",
			LiteralName = "UPDATE_BINDINGS",
		},
		{
			Name = "UpdateExhaustion",
			Type = "Event",
			LiteralName = "UPDATE_EXHAUSTION",
		},
		{
			Name = "UpdateGmStatus",
			Type = "Event",
			LiteralName = "UPDATE_GM_STATUS",
			Payload =
			{
				{ Name = "avilable", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UpdateLfgList",
			Type = "Event",
			LiteralName = "UPDATE_LFG_LIST",
		},
		{
			Name = "UpdateLfgListIncremental",
			Type = "Event",
			LiteralName = "UPDATE_LFG_LIST_INCREMENTAL",
		},
		{
			Name = "UpdateLfgTypes",
			Type = "Event",
			LiteralName = "UPDATE_LFG_TYPES",
		},
		{
			Name = "UpdateShapeshiftCooldown",
			Type = "Event",
			LiteralName = "UPDATE_SHAPESHIFT_COOLDOWN",
		},
		{
			Name = "UpdateShapeshiftForm",
			Type = "Event",
			LiteralName = "UPDATE_SHAPESHIFT_FORM",
		},
		{
			Name = "UpdateShapeshiftForms",
			Type = "Event",
			LiteralName = "UPDATE_SHAPESHIFT_FORMS",
		},
		{
			Name = "UpdateShapeshiftUsable",
			Type = "Event",
			LiteralName = "UPDATE_SHAPESHIFT_USABLE",
		},
		{
			Name = "UpdateStealth",
			Type = "Event",
			LiteralName = "UPDATE_STEALTH",
		},
		{
			Name = "UpdateTicket",
			Type = "Event",
			LiteralName = "UPDATE_TICKET",
		},
		{
			Name = "UpdateWorldStates",
			Type = "Event",
			LiteralName = "UPDATE_WORLD_STATES",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Uncategorized);
