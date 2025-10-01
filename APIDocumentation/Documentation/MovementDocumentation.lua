local Movement =
{
	Name = "Movement",
	Type = "System",
	Namespace = "Movement",

	Functions =
	{
		{
			Name = "AscendStop",
			Type = "Function",

		},
		{
			Name = "DescendStop",
			Type = "Function",

		},
		{
			Name = "FollowUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "strict", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "InteractUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

		},
		{
			Name = "JumpOrAscendStart",
			Type = "Function",

		},
		{
			Name = "MoveAndSteerStart",
			Type = "Function",

		},
		{
			Name = "MoveAndSteerStop",
			Type = "Function",

		},
		{
			Name = "MoveBackwardStart",
			Type = "Function",

		},
		{
			Name = "MoveBackwardStop",
			Type = "Function",

		},
		{
			Name = "MoveForwardStart",
			Type = "Function",

		},
		{
			Name = "MoveForwardStop",
			Type = "Function",

		},
		{
			Name = "PitchDownStart",
			Type = "Function",

		},
		{
			Name = "PitchDownStop",
			Type = "Function",

		},
		{
			Name = "PitchUpStart",
			Type = "Function",

		},
		{
			Name = "PitchUpStop",
			Type = "Function",

		},
		{
			Name = "SitStandOrDescendStart",
			Type = "Function",

		},
		{
			Name = "StrafeLeftStart",
			Type = "Function",

		},
		{
			Name = "StrafeLeftStop",
			Type = "Function",

		},
		{
			Name = "StrafeRightStart",
			Type = "Function",

		},
		{
			Name = "StrafeRightStop",
			Type = "Function",

		},
		{
			Name = "ToggleAutoRun",
			Type = "Function",

		},
		{
			Name = "ToggleRun",
			Type = "Function",

		},
		{
			Name = "TurnLeftStart",
			Type = "Function",

		},
		{
			Name = "TurnLeftStop",
			Type = "Function",

		},
		{
			Name = "TurnOrActionStart",
			Type = "Function",

		},
		{
			Name = "TurnOrActionStop",
			Type = "Function",

		},
		{
			Name = "TurnRightStart",
			Type = "Function",

		},
		{
			Name = "TurnRightStop",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "AutofollowBegin",
			Type = "Event",
			LiteralName = "AUTOFOLLOW_BEGIN",
			Payload =
			{
				{ Name = "following", Type = "number", Nilable = false },
			},
		},
		{
			Name = "AutofollowEnd",
			Type = "Event",
			LiteralName = "AUTOFOLLOW_END",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Movement);
