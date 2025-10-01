local Pvp =
{
	Name = "PvP",
	Type = "System",
	Namespace = "PvP",

	Functions =
	{
		{
			Name = "CanHearthAndResurrectFromArea",
			Type = "Function",

			Returns =
			{
				{ Name = "status", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanQueueForWintergrasp",
			Type = "Function",

			Returns =
			{
				{ Name = "canQueue", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetHolidayBGHonorCurrencyBonuses",
			Type = "Function",

			Returns =
			{
				{ Name = "unk", Type = "bool", Nilable = false },
				{ Name = "honorWinReward", Type = "number", Nilable = false },
				{ Name = "arenaWinReward", Type = "number", Nilable = false },
				{ Name = "honorLossReward", Type = "number", Nilable = false },
				{ Name = "arenaLossReward", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetHonorCurrency",
			Type = "Function",

			Returns =
			{
				{ Name = "honorPoints", Type = "number", Nilable = false },
				{ Name = "maxHonor", Type = "number", Nilable = false },
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
			Name = "GetPVPDesired",
			Type = "Function",

			Returns =
			{
				{ Name = "isPVPDesired", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPVPLifetimeStats",
			Type = "Function",

			Returns =
			{
				{ Name = "hk", Type = "number", Nilable = false },
				{ Name = "highestRank", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPVPRankInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
			},

			Returns =
			{
				{ Name = "rankName", Type = "string", Nilable = false },
				{ Name = "rankNumber", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPVPRankProgress",
			Type = "Function",

		},
		{
			Name = "GetPVPSessionStats",
			Type = "Function",

			Returns =
			{
				{ Name = "honorKills", Type = "number", Nilable = false },
				{ Name = "honorPoints", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPVPTimer",
			Type = "Function",

			Returns =
			{
				{ Name = "timer", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPVPYesterdayStats",
			Type = "Function",

			Returns =
			{
				{ Name = "honorKills", Type = "number", Nilable = false },
				{ Name = "honorPoints", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetWorldPVPQueueStatus",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "status", Type = "string", Nilable = false },
				{ Name = "mapName", Type = "string", Nilable = false },
				{ Name = "queueID", Type = "number", Nilable = false },
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
			Name = "GetZonePVPInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "pvpType", Type = "string", Nilable = false },
				{ Name = "isSubZonePVP", Type = "bool", Nilable = false },
				{ Name = "factionName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "HearthAndResurrectFromArea",
			Type = "Function",

			Returns =
			{
				{ Name = "status", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsPVPTimerRunning",
			Type = "Function",

			Returns =
			{
				{ Name = "isRunning", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsSubZonePVPPOI",
			Type = "Function",

			Returns =
			{
				{ Name = "isPVPPOI", Type = "bool", Nilable = false },
			},
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
			Name = "SetPVP",
			Type = "Function",

			Arguments =
			{
				{ Name = "state", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "TogglePVP",
			Type = "Function",

		},
		{
			Name = "UnitIsPVPFreeForAll",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isFreeForAll", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsPVPSanctuary",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "state", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitPVPName",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UnitPVPRank",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "rank", Type = "number", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "NpcPvpqueueAnywhere",
			Type = "Event",
			LiteralName = "NPC_PVPQUEUE_ANYWHERE",
		},
		{
			Name = "PlayerPvpKillsChanged",
			Type = "Event",
			LiteralName = "PLAYER_PVP_KILLS_CHANGED",
		},
		{
			Name = "PlayerPvpRankChanged",
			Type = "Event",
			LiteralName = "PLAYER_PVP_RANK_CHANGED",
		},
		{
			Name = "PvpqueueAnywhereShow",
			Type = "Event",
			LiteralName = "PVPQUEUE_ANYWHERE_SHOW",
		},
		{
			Name = "PvpqueueAnywhereUpdateAvailable",
			Type = "Event",
			LiteralName = "PVPQUEUE_ANYWHERE_UPDATE_AVAILABLE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Pvp);
