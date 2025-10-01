local Arena =
{
	Name = "Arena",
	Type = "System",
	Namespace = "Arena",

	Functions =
	{
		{
			Name = "AcceptArenaTeam",
			Type = "Function",

		},
		{
			Name = "ArenaTeamDisband",
			Type = "Function",

			Arguments =
			{
				{ Name = "team", Type = "number", Nilable = false },
			},

		},
		{
			Name = "ArenaTeamInviteByName",
			Type = "Function",

			Arguments =
			{
				{ Name = "team", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "ArenaTeamLeave",
			Type = "Function",

			Arguments =
			{
				{ Name = "team", Type = "number", Nilable = false },
			},

		},
		{
			Name = "ArenaTeamRoster",
			Type = "Function",

			Arguments =
			{
				{ Name = "team", Type = "number", Nilable = false },
			},

		},
		{
			Name = "ArenaTeamSetLeaderByName",
			Type = "Function",

			Arguments =
			{
				{ Name = "team", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "ArenaTeamUninviteByName",
			Type = "Function",

			Arguments =
			{
				{ Name = "team", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "ArenaTeam_GetTeamSizeID",
			Type = "Function",

			Arguments =
			{
				{ Name = "teamSize", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "teamID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CloseArenaTeamRoster",
			Type = "Function",

		},
		{
			Name = "DeclineArenaTeam",
			Type = "Function",

		},
		{
			Name = "GetArenaTeam",
			Type = "Function",

			Arguments =
			{
				{ Name = "team", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "teamName", Type = "string", Nilable = false },
				{ Name = "teamSize", Type = "number", Nilable = false },
				{ Name = "teamRating", Type = "number", Nilable = false },
				{ Name = "teamPlayed", Type = "number", Nilable = false },
				{ Name = "teamWins", Type = "number", Nilable = false },
				{ Name = "seasonTeamPlayed", Type = "number", Nilable = false },
				{ Name = "seasonTeamWins", Type = "number", Nilable = false },
				{ Name = "playerPlayed", Type = "number", Nilable = false },
				{ Name = "seasonPlayerPlayed", Type = "number", Nilable = false },
				{ Name = "teamRank", Type = "number", Nilable = false },
				{ Name = "playerRating", Type = "number", Nilable = false },
				{ Name = "bg_red", Type = "number", Nilable = false },
				{ Name = "bg_green", Type = "number", Nilable = false },
				{ Name = "bg_blue", Type = "number", Nilable = false },
				{ Name = "emblem", Type = "number", Nilable = false },
				{ Name = "emblem_red", Type = "number", Nilable = false },
				{ Name = "emblem_green", Type = "number", Nilable = false },
				{ Name = "emblem_blue", Type = "number", Nilable = false },
				{ Name = "border", Type = "number", Nilable = false },
				{ Name = "border_red", Type = "number", Nilable = false },
				{ Name = "border_green", Type = "number", Nilable = false },
				{ Name = "border_blue", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetArenaTeamGdfInfo",
			Type = "Function",

		},
		{
			Name = "GetArenaTeamRosterInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "team", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "rank", Type = "number", Nilable = false },
				{ Name = "level", Type = "number", Nilable = false },
				{ Name = "class", Type = "string", Nilable = false },
				{ Name = "online", Type = "bool", Nilable = false },
				{ Name = "played", Type = "number", Nilable = false },
				{ Name = "win", Type = "number", Nilable = false },
				{ Name = "seasonPlayed", Type = "number", Nilable = false },
				{ Name = "seasonWin", Type = "number", Nilable = false },
				{ Name = "rating", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetArenaTeamRosterSelection",
			Type = "Function",

			Arguments =
			{
				{ Name = "team", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetArenaTeamRosterShowOffline",
			Type = "Function",

			Returns =
			{
				{ Name = "showOffline", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetCurrentArenaSeason",
			Type = "Function",

			Returns =
			{
				{ Name = "season", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetMaxArenaCurrency",
			Type = "Function",

			Returns =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumArenaOpponents",
			Type = "Function",

			Returns =
			{
				{ Name = "numOpponents", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumArenaTeamMembers",
			Type = "Function",

			Arguments =
			{
				{ Name = "teamindex", Type = "luaIndex", Nilable = false },
				{ Name = "showOffline", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "numMembers", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPreviousArenaSeason",
			Type = "Function",

			Returns =
			{
				{ Name = "season", Type = "number", Nilable = false },
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
			Name = "IsArenaTeamCaptain",
			Type = "Function",

			Arguments =
			{
				{ Name = "team", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isCaptain", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsInArenaTeam",
			Type = "Function",

			Returns =
			{
				{ Name = "isInTeam", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetArenaTeamRosterSelection",
			Type = "Function",

			Arguments =
			{
				{ Name = "team", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetArenaTeamRosterShowOffline",
			Type = "Function",

			Arguments =
			{
				{ Name = "enable", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "SortArenaTeamRoster",
			Type = "Function",

			Arguments =
			{
				{ Name = "sortType", Type = "string", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "ArenaOpponentUpdate",
			Type = "Event",
			LiteralName = "ARENA_OPPONENT_UPDATE",
		},
		{
			Name = "ArenaSeasonWorldState",
			Type = "Event",
			LiteralName = "ARENA_SEASON_WORLD_STATE",
		},
		{
			Name = "ArenaTeamInviteRequest",
			Type = "Event",
			LiteralName = "ARENA_TEAM_INVITE_REQUEST",
			Payload =
			{
				{ Name = "source", Type = "string", Nilable = false },
				{ Name = "team", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ArenaTeamRosterUpdate",
			Type = "Event",
			LiteralName = "ARENA_TEAM_ROSTER_UPDATE",
			Payload =
			{
				{ Name = "unknown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ArenaTeamUpdate",
			Type = "Event",
			LiteralName = "ARENA_TEAM_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Arena);
