local Keybind =
{
	Name = "Keybind",
	Type = "System",
	Namespace = "Keybind",

	Functions =
	{
		{
			Name = "ClearOverrideBindings",
			Type = "Function",

			Arguments =
			{
				{ Name = "owner", Type = "table", Nilable = false },
			},

		},
		{
			Name = "GetBinding",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "commandName", Type = "string", Nilable = false },
				{ Name = "binding1", Type = "string", Nilable = false },
				{ Name = "binding2", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetBindingAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "key", Type = "string", Nilable = false },
				{ Name = "checkOverride", Type = "bool", Nilable = true },
			},

			Returns =
			{
				{ Name = "action", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetBindingByKey",
			Type = "Function",

			Arguments =
			{
				{ Name = "key", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "action", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetBindingKey",
			Type = "Function",

			Arguments =
			{
				{ Name = "COMMAND", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "key1", Type = "string", Nilable = false },
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetCurrentBindingSet",
			Type = "Function",

			Returns =
			{
				{ Name = "bindingSet", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumBindings",
			Type = "Function",

			Returns =
			{
				{ Name = "numBindings", Type = "number", Nilable = false },
			},
		},
		{
			Name = "LoadBindings",
			Type = "Function",

			Arguments =
			{
				{ Name = "set", Type = "number", Nilable = false },
			},

		},
		{
			Name = "RunBinding",
			Type = "Function",

			Arguments =
			{
				{ Name = "COMMAND", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SaveBindings",
			Type = "Function",

			Arguments =
			{
				{ Name = "set", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetBinding",
			Type = "Function",

			Arguments =
			{
				{ Name = "key", Type = "string", Nilable = false },
				{ Name = "command", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "success", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetBindingClick",
			Type = "Function",

			Arguments =
			{
				{ Name = "key", Type = "string", Nilable = false },
				{ Name = "buttonName", Type = "string", Nilable = false },
				{ Name = "mouseButton", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "success", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetBindingItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "key", Type = "string", Nilable = true },
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "success", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetBindingMacro",
			Type = "Function",

			Arguments =
			{
				{ Name = "key", Type = "string", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "success", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetBindingSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "key", Type = "string", Nilable = false },
				{ Name = "spellname", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "success", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetMouselookOverrideBinding",
			Type = "Function",

			Arguments =
			{
				{ Name = "key", Type = "string", Nilable = false },
				{ Name = "binding", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SetOverrideBinding",
			Type = "Function",

			Arguments =
			{
				{ Name = "owner", Type = "table", Nilable = false },
				{ Name = "isPriority", Type = "bool", Nilable = false },
				{ Name = "key", Type = "string", Nilable = false },
				{ Name = "command", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SetOverrideBindingClick",
			Type = "Function",

			Arguments =
			{
				{ Name = "owner", Type = "table", Nilable = false },
				{ Name = "isPriority", Type = "bool", Nilable = false },
				{ Name = "key", Type = "string", Nilable = false },
				{ Name = "buttonName", Type = "string", Nilable = false },
				{ Name = "mouseButton", Type = "string", Nilable = true },
			},

		},
		{
			Name = "SetOverrideBindingItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "owner", Type = "table", Nilable = true },
				{ Name = "isPriority", Type = "bool", Nilable = true },
				{ Name = "key", Type = "string", Nilable = true },
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

		},
		{
			Name = "SetOverrideBindingMacro",
			Type = "Function",

			Arguments =
			{
				{ Name = "owner", Type = "table", Nilable = true },
				{ Name = "isPriority", Type = "bool", Nilable = true },
				{ Name = "key", Type = "string", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "SetOverrideBindingSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "owner", Type = "table", Nilable = false },
				{ Name = "isPriority", Type = "bool", Nilable = false },
				{ Name = "key", Type = "string", Nilable = false },
				{ Name = "spellname", Type = "string", Nilable = false },
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

APIDocumentation:AddDocumentationTable(Keybind);
