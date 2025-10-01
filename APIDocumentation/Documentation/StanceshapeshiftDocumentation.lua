local Stanceshapeshift =
{
	Name = "StanceShapeshift",
	Type = "System",
	Namespace = "StanceShapeshift",

	Functions =
	{
		{
			Name = "CancelShapeshiftForm",
			Type = "Function",

		},
		{
			Name = "CastShapeshiftForm",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "GetNumShapeshiftForms",
			Type = "Function",

			Returns =
			{
				{ Name = "numForms", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetShapeshiftForm",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetShapeshiftFormCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "start", Type = "number", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "enable", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetShapeshiftFormInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "isActive", Type = "bool", Nilable = false },
				{ Name = "isCastable", Type = "bool", Nilable = false },
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

APIDocumentation:AddDocumentationTable(Stanceshapeshift);
