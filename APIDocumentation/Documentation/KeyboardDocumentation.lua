local Keyboard =
{
	Name = "Keyboard",
	Type = "System",
	Namespace = "Keyboard",

	Functions =
	{
		{
			Name = "GetCurrentKeyBoardFocus",
			Type = "Function",

			Returns =
			{
				{ Name = "frame", Type = "frame", Nilable = false },
			},
		},
		{
			Name = "IsAltKeyDown",
			Type = "Function",

			Returns =
			{
				{ Name = "isDown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsControlKeyDown",
			Type = "Function",

			Returns =
			{
				{ Name = "isDown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsLeftAltKeyDown",
			Type = "Function",

			Returns =
			{
				{ Name = "isDown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsLeftControlKeyDown",
			Type = "Function",

			Returns =
			{
				{ Name = "isDown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsLeftShiftKeyDown",
			Type = "Function",

			Returns =
			{
				{ Name = "isDown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsModifierKeyDown",
			Type = "Function",

			Returns =
			{
				{ Name = "isDown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsRightAltKeyDown",
			Type = "Function",

			Returns =
			{
				{ Name = "isDown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsRightControlKeyDown",
			Type = "Function",

			Returns =
			{
				{ Name = "isDown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsRightShiftKeyDown",
			Type = "Function",

			Returns =
			{
				{ Name = "isDown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsShiftKeyDown",
			Type = "Function",

			Returns =
			{
				{ Name = "isDown", Type = "bool", Nilable = false },
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

APIDocumentation:AddDocumentationTable(Keyboard);
