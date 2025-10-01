local Tracking =
{
	Name = "Tracking",
	Type = "System",
	Namespace = "Tracking",

	Functions =
	{
		{
			Name = "GetNumTrackingTypes",
			Type = "Function",

			Returns =
			{
				{ Name = "count", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTrackingInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "active", Type = "bool", Nilable = false },
				{ Name = "category", Type = "string", Nilable = false },
			},
		},
		{
			Name = "SetTracking",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "enabled", Type = "bool", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "MinimapUpdateTracking",
			Type = "Event",
			LiteralName = "MINIMAP_UPDATE_TRACKING",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Tracking);
