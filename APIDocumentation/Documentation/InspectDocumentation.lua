local Inspect =
{
	Name = "Inspect",
	Type = "System",
	Namespace = "Inspect",

	Functions =
	{
		{
			Name = "CanInspect",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "showError", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "canInspect", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ClearInspectPlayer",
			Type = "Function",

		},
		{
			Name = "GetInspectArenaTeamData",
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
				{ Name = "playerPlayed", Type = "number", Nilable = false },
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
			Name = "GetInspectHonorData",
			Type = "Function",

			Returns =
			{
				{ Name = "todayHK", Type = "number", Nilable = false },
				{ Name = "todayHonor", Type = "number", Nilable = false },
				{ Name = "yesterdayHK", Type = "number", Nilable = false },
				{ Name = "yesterdayHonor", Type = "number", Nilable = false },
				{ Name = "lifetimeHK", Type = "number", Nilable = false },
				{ Name = "lifetimeRank", Type = "number", Nilable = false },
			},
		},
		{
			Name = "HasInspectHonorData",
			Type = "Function",

			Returns =
			{
				{ Name = "hasData", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "NotifyInspect",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

		},
		{
			Name = "RequestInspectHonorData",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "InspectHonorUpdate",
			Type = "Event",
			LiteralName = "INSPECT_HONOR_UPDATE",
		},
		{
			Name = "InspectTalentReady",
			Type = "Event",
			LiteralName = "INSPECT_TALENT_READY",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Inspect);
