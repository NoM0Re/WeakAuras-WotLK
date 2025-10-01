local Targeting =
{
	Name = "Targeting",
	Type = "System",
	Namespace = "Targeting",

	Functions =
	{
		{
			Name = "AssistUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ClearFocus",
			Type = "Function",

		},
		{
			Name = "ClearTarget",
			Type = "Function",

		},
		{
			Name = "FocusUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "SpellCanTargetUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "canTarget", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SpellTargetUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "TargetLastEnemy",
			Type = "Function",

		},
		{
			Name = "TargetLastFriend",
			Type = "Function",

		},
		{
			Name = "TargetLastTarget",
			Type = "Function",

		},
		{
			Name = "TargetNearest",
			Type = "Function",

			Arguments =
			{
				{ Name = "backward", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "TargetNearestEnemy",
			Type = "Function",

			Arguments =
			{
				{ Name = "backward", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "TargetNearestEnemyPlayer",
			Type = "Function",

			Arguments =
			{
				{ Name = "backward", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "TargetNearestFriend",
			Type = "Function",

			Arguments =
			{
				{ Name = "backward", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "TargetNearestFriendPlayer",
			Type = "Function",

			Arguments =
			{
				{ Name = "backward", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "TargetNearestPartyMember",
			Type = "Function",

			Arguments =
			{
				{ Name = "backward", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "TargetNearestRaidMember",
			Type = "Function",

			Arguments =
			{
				{ Name = "backward", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "TargetUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "canTarget", Type = "bool", Nilable = false },
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

APIDocumentation:AddDocumentationTable(Targeting);
