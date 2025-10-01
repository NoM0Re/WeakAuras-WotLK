local AddonRelated =
{
	Name = "Addon-related",
	Type = "System",
	Namespace = "Addon-related",

	Functions =
	{
		{
			Name = "DisableAddOn",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
			},

		},
		{
			Name = "DisableAllAddOns",
			Type = "Function",

		},
		{
			Name = "EnableAddOn",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "EnableAllAddOns",
			Type = "Function",

		},
		{
			Name = "GetAddOnDependencies",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
			},

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetAddOnInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "title", Type = "string", Nilable = false },
				{ Name = "notes", Type = "string", Nilable = false },
				{ Name = "enabled", Type = "bool", Nilable = false },
				{ Name = "loadable", Type = "bool", Nilable = false },
				{ Name = "reason", Type = "string", Nilable = false },
				{ Name = "security", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetAddOnMetadata",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "variable", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "data", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetNumAddOns",
			Type = "Function",

			Returns =
			{
				{ Name = "numAddons", Type = "number", Nilable = false },
			},
		},
		{
			Name = "InterfaceOptionsFrame_OpenToCategory",
			Type = "Function",

			Arguments =
			{
				{ Name = "panelName", Type = "string", Nilable = true },
				{ Name = "panel", Type = "table", Nilable = true },
			},

		},
		{
			Name = "InterfaceOptions_AddCategory",
			Type = "Function",

			Arguments =
			{
				{ Name = "panel", Type = "table", Nilable = false },
			},

		},
		{
			Name = "IsAddOnLoadOnDemand",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
			},

			Returns =
			{
				{ Name = "isLod", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsAddOnLoaded",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
			},

			Returns =
			{
				{ Name = "loaded", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "LoadAddOn",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
			},

			Returns =
			{
				{ Name = "loaded", Type = "number", Nilable = false },
				{ Name = "reason", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ResetDisabledAddOns",
			Type = "Function",

		},
		{
			Name = "SendAddonMessage",
			Type = "Function",

			Arguments =
			{
				{ Name = "prefix", Type = "string", Nilable = false },
				{ Name = "message", Type = "string", Nilable = false },
				{ Name = "type", Type = "string", Nilable = true },
				{ Name = "target", Type = "string", Nilable = true },
			},

		},
	},

	Events =
	{
		{
			Name = "AddonLoaded",
			Type = "Event",
			LiteralName = "ADDON_LOADED",
			Payload =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(AddonRelated);
