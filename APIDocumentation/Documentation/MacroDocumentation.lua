local Macro =
{
	Name = "Macro",
	Type = "System",
	Namespace = "Macro",

	Functions =
	{
		{
			Name = "CreateMacro",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "icon", Type = "number", Nilable = false },
				{ Name = "body", Type = "string", Nilable = false },
				{ Name = "perCharacter", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "CursorHasMacro",
			Type = "Function",

			Returns =
			{
				{ Name = "hasMacro", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "DeleteMacro",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "EditMacro",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "iconTexture", Type = "string", Nilable = false },
				{ Name = "body", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "newIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetMacroBody",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "body", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetMacroIconInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetMacroIndexByName",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetMacroInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "body", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetMacroItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetMacroItemIconInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetMacroSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetNumMacroIcons",
			Type = "Function",

			Returns =
			{
				{ Name = "numMacroIcons", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumMacroItemIcons",
			Type = "Function",

			Returns =
			{
				{ Name = "numIcons", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumMacros",
			Type = "Function",

			Returns =
			{
				{ Name = "numAccountMacros", Type = "number", Nilable = false },
				{ Name = "numCharacterMacros", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetRunningMacro",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetRunningMacroButton",
			Type = "Function",

			Returns =
			{
				{ Name = "button", Type = "string", Nilable = false },
			},
		},
		{
			Name = "PickupMacro",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "RunMacro",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "button", Type = "string", Nilable = true },
			},

		},
		{
			Name = "RunMacroText",
			Type = "Function",

			Arguments =
			{
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "button", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SecureCmdOptionParse",
			Type = "Function",

			Arguments =
			{
				{ Name = "cmd", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "action", Type = "string", Nilable = false },
				{ Name = "target", Type = "string", Nilable = false },
			},
		},
		{
			Name = "SetMacroItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "item", Type = "string", Nilable = true },
				{ Name = "target", Type = "string", Nilable = true },
			},

		},
		{
			Name = "SetMacroSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "spell", Type = "string", Nilable = true },
				{ Name = "target", Type = "string", Nilable = true },
			},

		},
		{
			Name = "StopMacro",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "UpdateMacros",
			Type = "Event",
			LiteralName = "UPDATE_MACROS",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Macro);
