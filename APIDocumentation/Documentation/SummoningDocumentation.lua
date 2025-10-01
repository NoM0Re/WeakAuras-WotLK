local Summoning =
{
	Name = "Summoning",
	Type = "System",
	Namespace = "Summoning",

	Functions =
	{
		{
			Name = "CancelSummon",
			Type = "Function",

		},
		{
			Name = "ConfirmSummon",
			Type = "Function",

		},
		{
			Name = "GetSummonConfirmAreaName",
			Type = "Function",

			Returns =
			{
				{ Name = "area", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetSummonConfirmSummoner",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetSummonConfirmTimeLeft",
			Type = "Function",

			Returns =
			{
				{ Name = "timeleft", Type = "number", Nilable = false },
			},
		},
		{
			Name = "PlayerCanTeleport",
			Type = "Function",

			Returns =
			{
				{ Name = "amount", Type = "bool", Nilable = false },
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

APIDocumentation:AddDocumentationTable(Summoning);
