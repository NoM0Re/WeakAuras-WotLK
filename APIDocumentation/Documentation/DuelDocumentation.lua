local Duel =
{
	Name = "Duel",
	Type = "System",
	Namespace = "Duel",

	Functions =
	{
		{
			Name = "AcceptDuel",
			Type = "Function",

		},
		{
			Name = "CancelDuel",
			Type = "Function",

		},
		{
			Name = "StartDuel",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "exactMatch", Type = "bool", Nilable = true },
			},

		},
	},

	Events =
	{
		{
			Name = "DuelFinished",
			Type = "Event",
			LiteralName = "DUEL_FINISHED",
		},
		{
			Name = "DuelInbounds",
			Type = "Event",
			LiteralName = "DUEL_INBOUNDS",
		},
		{
			Name = "DuelOutofbounds",
			Type = "Event",
			LiteralName = "DUEL_OUTOFBOUNDS",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Duel);
