local Threat =
{
	Name = "Threat",
	Type = "System",
	Namespace = "Threat",

	Functions =
	{
		{
			Name = "GetThreatStatusColor",
			Type = "Function",

			Arguments =
			{
				{ Name = "status", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "red", Type = "number", Nilable = false },
				{ Name = "green", Type = "number", Nilable = false },
				{ Name = "blue", Type = "number", Nilable = false },
			},
		},
		{
			Name = "IsThreatWarningEnabled",
			Type = "Function",

			Returns =
			{
				{ Name = "enabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitDetailedThreatSituation",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "mobUnit", Type = "UnitToken", Nilable = true },
			},

			Returns =
			{
				{ Name = "isTanking", Type = "bool", Nilable = false },
				{ Name = "status", Type = "number", Nilable = false },
				{ Name = "scaledPercent", Type = "number", Nilable = false },
				{ Name = "rawPercent", Type = "number", Nilable = false },
				{ Name = "threatValue", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitThreatSituation",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "mobUnit", Type = "UnitToken", Nilable = true },
			},

			Returns =
			{
				{ Name = "status", Type = "number", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "UnitThreatListUpdate",
			Type = "Event",
			LiteralName = "UNIT_THREAT_LIST_UPDATE",
		},
		{
			Name = "UnitThreatSituationUpdate",
			Type = "Event",
			LiteralName = "UNIT_THREAT_SITUATION_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Threat);
