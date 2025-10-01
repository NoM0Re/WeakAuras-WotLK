local Guild =
{
	Name = "Guild",
	Type = "System",
	Namespace = "Guild",

	Functions =
	{
		{
			Name = "AcceptGuild",
			Type = "Function",

		},
		{
			Name = "BuyGuildCharter",
			Type = "Function",

			Arguments =
			{
				{ Name = "guildName", Type = "string", Nilable = false },
			},

		},
		{
			Name = "CanEditGuildEvent",
			Type = "Function",

			Returns =
			{
				{ Name = "canEdit", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanEditGuildInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "canEdit", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanEditMOTD",
			Type = "Function",

			Returns =
			{
				{ Name = "canEdit", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanEditOfficerNote",
			Type = "Function",

			Returns =
			{
				{ Name = "canEdit", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanEditPublicNote",
			Type = "Function",

			Returns =
			{
				{ Name = "canEdit", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanGuildDemote",
			Type = "Function",

			Returns =
			{
				{ Name = "canDemote", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanGuildInvite",
			Type = "Function",

			Returns =
			{
				{ Name = "canInvite", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanGuildPromote",
			Type = "Function",

			Returns =
			{
				{ Name = "canPromote", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanGuildRemove",
			Type = "Function",

			Returns =
			{
				{ Name = "canRemove", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanViewOfficerNote",
			Type = "Function",

			Returns =
			{
				{ Name = "canView", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CloseGuildRegistrar",
			Type = "Function",

		},
		{
			Name = "CloseGuildRoster",
			Type = "Function",

		},
		{
			Name = "CloseTabardCreation",
			Type = "Function",

		},
		{
			Name = "DeclineGuild",
			Type = "Function",

		},
		{
			Name = "GetGuildCharterCost",
			Type = "Function",

			Returns =
			{
				{ Name = "cost", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetGuildEventInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "player1", Type = "string", Nilable = false },
				{ Name = "player2", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "hour", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetGuildInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "guildName", Type = "string", Nilable = false },
				{ Name = "guildRankName", Type = "string", Nilable = false },
				{ Name = "guildRankIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetGuildInfoText",
			Type = "Function",

			Returns =
			{
				{ Name = "guildInfoText", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetGuildRosterInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
				{ Name = "rankIndex", Type = "luaIndex", Nilable = false },
				{ Name = "level", Type = "number", Nilable = false },
				{ Name = "class", Type = "string", Nilable = false },
				{ Name = "zone", Type = "string", Nilable = false },
				{ Name = "note", Type = "string", Nilable = false },
				{ Name = "officernote", Type = "string", Nilable = false },
				{ Name = "online", Type = "bool", Nilable = false },
				{ Name = "status", Type = "string", Nilable = false },
				{ Name = "classFileName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetGuildRosterLastOnline",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "years", Type = "number", Nilable = false },
				{ Name = "months", Type = "number", Nilable = false },
				{ Name = "days", Type = "number", Nilable = false },
				{ Name = "hours", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetGuildRosterMOTD",
			Type = "Function",

			Returns =
			{
				{ Name = "guildMOTD", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetGuildRosterSelection",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetGuildRosterShowOffline",
			Type = "Function",

			Returns =
			{
				{ Name = "showOffline", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetGuildTabardFileNames",
			Type = "Function",

			Returns =
			{
				{ Name = "tabardBackgroundUpper", Type = "string", Nilable = false },
				{ Name = "tabardBackgroundLower", Type = "string", Nilable = false },
				{ Name = "tabardEmblemUpper", Type = "string", Nilable = false },
				{ Name = "tabardEmblemLower", Type = "string", Nilable = false },
				{ Name = "tabardBorderUpper", Type = "string", Nilable = false },
				{ Name = "tabardBorderLower", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetNumGuildEvents",
			Type = "Function",

			Returns =
			{
				{ Name = "numEvents", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumGuildMembers",
			Type = "Function",

			Arguments =
			{
				{ Name = "includeOffline", Type = "bool", Nilable = true },
			},

			Returns =
			{
				{ Name = "numGuildMembers", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTabardCreationCost",
			Type = "Function",

			Returns =
			{
				{ Name = "cost", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTabardInfo",
			Type = "Function",

		},
		{
			Name = "GuildControlAddRank",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "GuildControlDelRank",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "GuildControlGetNumRanks",
			Type = "Function",

			Returns =
			{
				{ Name = "numRanks", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GuildControlGetRankFlags",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GuildControlGetRankName",
			Type = "Function",

			Arguments =
			{
				{ Name = "rank", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "rankName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GuildControlSaveRank",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "GuildControlSetRank",
			Type = "Function",

			Arguments =
			{
				{ Name = "rank", Type = "number", Nilable = false },
			},

		},
		{
			Name = "GuildControlSetRankFlag",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "enabled", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "GuildDemote",
			Type = "Function",

			Returns =
			{
				{ Name = "canDemote", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GuildDisband",
			Type = "Function",

		},
		{
			Name = "GuildInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "canEdit", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GuildInvite",
			Type = "Function",

			Returns =
			{
				{ Name = "canInvite", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GuildLeave",
			Type = "Function",

		},
		{
			Name = "GuildPromote",
			Type = "Function",

			Returns =
			{
				{ Name = "canPromote", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GuildRoster",
			Type = "Function",

		},
		{
			Name = "GuildRosterSetOfficerNote",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "note", Type = "string", Nilable = false },
			},

		},
		{
			Name = "GuildRosterSetPublicNote",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "note", Type = "string", Nilable = false },
			},

		},
		{
			Name = "GuildSetLeader",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "GuildSetMOTD",
			Type = "Function",

			Arguments =
			{
				{ Name = "message", Type = "string", Nilable = false },
			},

		},
		{
			Name = "GuildUninvite",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "IsGuildLeader",
			Type = "Function",

			Returns =
			{
				{ Name = "isLeader", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsInGuild",
			Type = "Function",

			Returns =
			{
				{ Name = "inGuild", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "QueryGuildEventLog",
			Type = "Function",

		},
		{
			Name = "SetGuildInfoText",
			Type = "Function",

			Arguments =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SetGuildRosterSelection",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetGuildRosterShowOffline",
			Type = "Function",

			Arguments =
			{
				{ Name = "showOffline", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "SortGuildRoster",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
			},

		},
		{
			Name = "TurnInGuildCharter",
			Type = "Function",

		},
		{
			Name = "UnitIsInMyGuild",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "inGuild", Type = "bool", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "ChatMsgGuild",
			Type = "Event",
			LiteralName = "CHAT_MSG_GUILD",
			Payload =
			{
				{ Name = "message", Type = "string", Nilable = false },
				{ Name = "sender", Type = "string", Nilable = false },
				{ Name = "language", Type = "string", Nilable = false },
				{ Name = "channelString", Type = "string", Nilable = false },
				{ Name = "target", Type = "string", Nilable = false },
				{ Name = "flags", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "channelNumber", Type = "number", Nilable = false },
				{ Name = "channelName", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "counter", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GuildtabardUpdate",
			Type = "Event",
			LiteralName = "GUILDTABARD_UPDATE",
		},
		{
			Name = "GuildEventLogUpdate",
			Type = "Event",
			LiteralName = "GUILD_EVENT_LOG_UPDATE",
		},
		{
			Name = "GuildInviteCancel",
			Type = "Event",
			LiteralName = "GUILD_INVITE_CANCEL",
		},
		{
			Name = "GuildInviteRequest",
			Type = "Event",
			LiteralName = "GUILD_INVITE_REQUEST",
			Payload =
			{
				{ Name = "from", Type = "string", Nilable = false },
				{ Name = "guildname", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GuildMotd",
			Type = "Event",
			LiteralName = "GUILD_MOTD",
			Payload =
			{
				{ Name = "message", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GuildRegistrarClosed",
			Type = "Event",
			LiteralName = "GUILD_REGISTRAR_CLOSED",
		},
		{
			Name = "GuildRegistrarShow",
			Type = "Event",
			LiteralName = "GUILD_REGISTRAR_SHOW",
		},
		{
			Name = "GuildRosterUpdate",
			Type = "Event",
			LiteralName = "GUILD_ROSTER_UPDATE",
			Payload =
			{
				{ Name = "update", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PlayerGuildUpdate",
			Type = "Event",
			LiteralName = "PLAYER_GUILD_UPDATE",
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

APIDocumentation:AddDocumentationTable(Guild);
