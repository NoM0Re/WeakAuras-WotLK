local Battlefield =
{
	Name = "Battlefield",
	Type = "System",
	Namespace = "Battlefield",

	Functions =
	{
		{
			Name = "AcceptAreaSpiritHeal",
			Type = "Function",

		},
		{
			Name = "AcceptBattlefieldPort",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "accept", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "CanJoinBattlefieldAsGroup",
			Type = "Function",

			Returns =
			{
				{ Name = "canGroupJoin", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CancelAreaSpiritHeal",
			Type = "Function",

		},
		{
			Name = "CloseBattlefield",
			Type = "Function",

		},
		{
			Name = "GetAreaSpiritHealerTime",
			Type = "Function",

			Returns =
			{
				{ Name = "timeleft", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldArenaFaction",
			Type = "Function",

		},
		{
			Name = "GetBattlefieldEstimatedWaitTime",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "waitTime", Type = "time_t", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldFlagPosition",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "flagX", Type = "number", Nilable = false },
				{ Name = "flagY", Type = "number", Nilable = false },
				{ Name = "flagToken", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldInstanceExpiration",
			Type = "Function",

			Returns =
			{
				{ Name = "timeLeft", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldInstanceInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "instanceID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldInstanceRunTime",
			Type = "Function",

			Returns =
			{
				{ Name = "time", Type = "time_t", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldMapIconScale",
			Type = "Function",

			Returns =
			{
				{ Name = "scale", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldPortExpiration",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "expiration", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldPosition",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "unitX", Type = "UnitToken", Nilable = false },
				{ Name = "unitY", Type = "UnitToken", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldScore",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "killingBlows", Type = "number", Nilable = false },
				{ Name = "honorableKills", Type = "number", Nilable = false },
				{ Name = "deaths", Type = "number", Nilable = false },
				{ Name = "honorGained", Type = "number", Nilable = false },
				{ Name = "faction", Type = "number", Nilable = false },
				{ Name = "race", Type = "string", Nilable = false },
				{ Name = "class", Type = "string", Nilable = false },
				{ Name = "classToken", Type = "string", Nilable = false },
				{ Name = "damageDone", Type = "number", Nilable = false },
				{ Name = "healingDone", Type = "number", Nilable = false },
				{ Name = "bgRating", Type = "number", Nilable = false },
				{ Name = "ratingChange", Type = "number", Nilable = false },
				{ Name = "preMatchMMR", Type = "number", Nilable = false },
				{ Name = "mmrChange", Type = "number", Nilable = false },
				{ Name = "talentSpec", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldStatData",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "statIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "columnData", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldStatInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "statIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "tooltip", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldStatus",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "status", Type = "string", Nilable = false },
				{ Name = "mapName", Type = "string", Nilable = false },
				{ Name = "instanceID", Type = "number", Nilable = false },
				{ Name = "bracketMin", Type = "number", Nilable = false },
				{ Name = "bracketMax", Type = "number", Nilable = false },
				{ Name = "teamSize", Type = "number", Nilable = false },
				{ Name = "registeredMatch", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldTeamInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "teamName", Type = "string", Nilable = false },
				{ Name = "teamRating", Type = "number", Nilable = false },
				{ Name = "newTeamRating", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldTimeWaited",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "timeInQueue", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldVehicleInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "vehicleX", Type = "number", Nilable = false },
				{ Name = "vehicleY", Type = "number", Nilable = false },
				{ Name = "unitName", Type = "string", Nilable = false },
				{ Name = "isPossessed", Type = "bool", Nilable = false },
				{ Name = "vehicleType", Type = "string", Nilable = false },
				{ Name = "orientation", Type = "number", Nilable = false },
				{ Name = "isPlayer", Type = "bool", Nilable = false },
				{ Name = "isAlive", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetBattlefieldWinner",
			Type = "Function",

			Returns =
			{
				{ Name = "winner", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetBattlegroundInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "canEnter", Type = "bool", Nilable = false },
				{ Name = "isHoliday", Type = "bool", Nilable = false },
				{ Name = "minlevel", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumBattlefieldFlagPositions",
			Type = "Function",

			Returns =
			{
				{ Name = "numFlags", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumBattlefieldPositions",
			Type = "Function",

			Returns =
			{
				{ Name = "numTeamMembers", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumBattlefieldScores",
			Type = "Function",

			Returns =
			{
				{ Name = "numScores", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumBattlefieldStats",
			Type = "Function",

			Returns =
			{
				{ Name = "numStats", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumBattlefieldVehicles",
			Type = "Function",

			Returns =
			{
				{ Name = "numVehicles", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumBattlefields",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
			},

			Returns =
			{
				{ Name = "numBattlefields", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumBattlegroundTypes",
			Type = "Function",

			Returns =
			{
				{ Name = "numBattlegrounds", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetRealNumPartyMembers",
			Type = "Function",

			Returns =
			{
				{ Name = "numMembers", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetRealNumRaidMembers",
			Type = "Function",

			Returns =
			{
				{ Name = "numMembers", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSelectedBattlefield",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "IsActiveBattlefieldArena",
			Type = "Function",

			Returns =
			{
				{ Name = "isArena", Type = "bool", Nilable = false },
				{ Name = "isRegistered", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsRealPartyLeader",
			Type = "Function",

			Returns =
			{
				{ Name = "isLeader", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsRealRaidLeader",
			Type = "Function",

			Returns =
			{
				{ Name = "isLeader", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "JoinBattlefield",
			Type = "Function",

			Returns =
			{
				{ Name = "canGroupJoin", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "LeaveBattlefield",
			Type = "Function",

		},
		{
			Name = "PlayerIsPVPInactive",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
			},

			Returns =
			{
				{ Name = "isInactive", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ReportPlayerIsPVPAFK",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
			},

		},
		{
			Name = "RequestBattlefieldPositions",
			Type = "Function",

		},
		{
			Name = "RequestBattlefieldScoreData",
			Type = "Function",

		},
		{
			Name = "RequestBattlegroundInstanceInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetBattlefieldScoreFaction",
			Type = "Function",

			Arguments =
			{
				{ Name = "faction", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetSelectedBattlefield",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "ShowMiniWorldMapArrowFrame",
			Type = "Function",

			Arguments =
			{
				{ Name = "show", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "SortBattlefieldScoreData",
			Type = "Function",

			Arguments =
			{
				{ Name = "sortType", Type = "string", Nilable = false },
			},

		},
		{
			Name = "UnitInBattleground",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "raidNum", Type = "number", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "BattlefieldsClosed",
			Type = "Event",
			LiteralName = "BATTLEFIELDS_CLOSED",
		},
		{
			Name = "BattlefieldsShow",
			Type = "Event",
			LiteralName = "BATTLEFIELDS_SHOW",
		},
		{
			Name = "BattlefieldMgrEjected",
			Type = "Event",
			LiteralName = "BATTLEFIELD_MGR_EJECTED",
		},
		{
			Name = "BattlefieldMgrEjectPending",
			Type = "Event",
			LiteralName = "BATTLEFIELD_MGR_EJECT_PENDING",
		},
		{
			Name = "BattlefieldMgrEntered",
			Type = "Event",
			LiteralName = "BATTLEFIELD_MGR_ENTERED",
		},
		{
			Name = "BattlefieldMgrEntryInvite",
			Type = "Event",
			LiteralName = "BATTLEFIELD_MGR_ENTRY_INVITE",
		},
		{
			Name = "BattlefieldMgrQueueInvite",
			Type = "Event",
			LiteralName = "BATTLEFIELD_MGR_QUEUE_INVITE",
		},
		{
			Name = "BattlefieldMgrQueueRequestResponse",
			Type = "Event",
			LiteralName = "BATTLEFIELD_MGR_QUEUE_REQUEST_RESPONSE",
		},
		{
			Name = "BattlefieldMgrStateChange",
			Type = "Event",
			LiteralName = "BATTLEFIELD_MGR_STATE_CHANGE",
		},
		{
			Name = "UpdateBattlefieldScore",
			Type = "Event",
			LiteralName = "UPDATE_BATTLEFIELD_SCORE",
		},
		{
			Name = "UpdateBattlefieldStatus",
			Type = "Event",
			LiteralName = "UPDATE_BATTLEFIELD_STATUS",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Battlefield);
