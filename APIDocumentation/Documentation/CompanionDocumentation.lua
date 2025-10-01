local Companion =
{
	Name = "Companion",
	Type = "System",
	Namespace = "Companion",

	Functions =
	{
		{
			Name = "CallCompanion",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "DismissCompanion",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
			},

		},
		{
			Name = "GetCompanionCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "start", Type = "number", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "enable", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCompanionInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "creatureID", Type = "number", Nilable = false },
				{ Name = "creatureName", Type = "string", Nilable = false },
				{ Name = "spellID", Type = "number", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "active", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetNumCompanions",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "count", Type = "number", Nilable = false },
			},
		},
		{
			Name = "PickupCompanion",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SummonRandomCritter",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "CompanionLearned",
			Type = "Event",
			LiteralName = "COMPANION_LEARNED",
		},
		{
			Name = "CompanionUnlearned",
			Type = "Event",
			LiteralName = "COMPANION_UNLEARNED",
		},
		{
			Name = "CompanionUpdate",
			Type = "Event",
			LiteralName = "COMPANION_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Companion);
