local ExperienceXp =
{
	Name = "Experience",
	Type = "System",
	Namespace = "Experience",

	Functions =
	{
		{
			Name = "GetRewardXP",
			Type = "Function",

		},
		{
			Name = "GetXPExhaustion",
			Type = "Function",

			Returns =
			{
				{ Name = "exhaustionXP", Type = "number", Nilable = false },
			},
		},
		{
			Name = "IsXPUserDisabled",
			Type = "Function",

			Returns =
			{
				{ Name = "isDisabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitXP",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "currXP", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitXPMax",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "playerMaxXP", Type = "number", Nilable = false },
			},
		},
	},

	Events =
	{
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(ExperienceXp);
