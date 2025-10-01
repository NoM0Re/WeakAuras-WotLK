local Combatlog =
{
	Name = "CombatLog",
	Type = "System",
	Namespace = "CombatLog",

	Functions =
	{
		{
			Name = "CombatLogAddFilter",
			Type = "Function",

			Arguments =
			{
				{ Name = "events", Type = "string", Nilable = true },
				{ Name = "srcGUID", Type = "WOWGUID", Nilable = true },
				{ Name = "srcMask", Type = "number", Nilable = true },
				{ Name = "destGUID", Type = "WOWGUID", Nilable = true },
				{ Name = "destMask", Type = "number", Nilable = true },
			},

		},
		{
			Name = "CombatLogAdvanceEntry",
			Type = "Function",

			Arguments =
			{
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "ignoreFilter", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "hasEntry", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CombatLogClearEntries",
			Type = "Function",

		},
		{
			Name = "CombatLogGetCurrentEntry",
			Type = "Function",

			Arguments =
			{
				{ Name = "ignoreFilter", Type = "bool", Nilable = true },
			},

			Returns =
			{
				{ Name = "timestamp", Type = "time_t", Nilable = false },
				{ Name = "event", Type = "string", Nilable = false },
				{ Name = "srcGUID", Type = "WOWGUID", Nilable = false },
				{ Name = "srcName", Type = "string", Nilable = false },
				{ Name = "srcFlags", Type = "number", Nilable = false },
				{ Name = "destGUID", Type = "WOWGUID", Nilable = false },
				{ Name = "destName", Type = "string", Nilable = false },
				{ Name = "destFlags", Type = "number", Nilable = false },
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "CombatLogGetNumEntries",
			Type = "Function",

			Arguments =
			{
				{ Name = "ignoreFilter", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "CombatLogGetRetentionTime",
			Type = "Function",

			Returns =
			{
				{ Name = "seconds", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CombatLogResetFilter",
			Type = "Function",

		},
		{
			Name = "CombatLogSetCurrentEntry",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "ignoreFilter", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "CombatLogSetRetentionTime",
			Type = "Function",

			Arguments =
			{
				{ Name = "seconds", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CombatLog_Object_IsA",
			Type = "Function",

			Arguments =
			{
				{ Name = "unitFlags", Type = "UnitToken", Nilable = false },
				{ Name = "mask", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isMatch", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "LoggingCombat",
			Type = "Function",

			Arguments =
			{
				{ Name = "toggle", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "isLogging", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitGUID",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "guid", Type = "WOWGUID", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "CombatLogEvent",
			Type = "Event",
			LiteralName = "COMBAT_LOG_EVENT",
		},
		{
			Name = "CombatLogEventUnfiltered",
			Type = "Event",
			LiteralName = "COMBAT_LOG_EVENT_UNFILTERED",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Combatlog);
