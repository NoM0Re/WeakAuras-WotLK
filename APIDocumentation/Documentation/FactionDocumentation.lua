local Faction =
{
	Name = "Faction",
	Type = "System",
	Namespace = "Faction",

	Functions =
	{
		{
			Name = "CollapseAllFactionHeaders",
			Type = "Function",

		},
		{
			Name = "CollapseFactionHeader",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "ExpandAllFactionHeaders",
			Type = "Function",

		},
		{
			Name = "ExpandFactionHeader",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "FactionToggleAtWar",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "GetFactionInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
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
			Name = "GetNumFactions",
			Type = "Function",

			Returns =
			{
				{ Name = "numFactions", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSelectedFaction",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetWatchedFactionInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "standingID", Type = "number", Nilable = false },
				{ Name = "barMin", Type = "number", Nilable = false },
				{ Name = "barMax", Type = "number", Nilable = false },
				{ Name = "barValue", Type = "number", Nilable = false },
			},
		},
		{
			Name = "IsFactionInactive",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "isInactive", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetFactionActive",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetFactionInactive",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetSelectedFaction",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetWatchedFactionIndex",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "ChatMsgCombatFactionChange",
			Type = "Event",
			LiteralName = "CHAT_MSG_COMBAT_FACTION_CHANGE",
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
			Name = "UnitFaction",
			Type = "Event",
			LiteralName = "UNIT_FACTION",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UpdateFaction",
			Type = "Event",
			LiteralName = "UPDATE_FACTION",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Faction);
