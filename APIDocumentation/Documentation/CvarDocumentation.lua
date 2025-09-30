local Cvar =
{
	Name = "CVar",
	Type = "System",
	Namespace = "CVar",

	Functions =
	{
		{
			Name = "GetCVar",
			Type = "Function",

			Arguments =
			{
				{ Name = "cvar", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "string", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetCVarAbsoluteMin",
			Type = "Function",

			Arguments =
			{
				{ Name = "cvar", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "min", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCVarBool",
			Type = "Function",

			Arguments =
			{
				{ Name = "cvar", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "value", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetCVarDefault",
			Type = "Function",

			Arguments =
			{
				{ Name = "CVar", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "value", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetCVarInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "cvar", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "value", Type = "string", Nilable = false },
				{ Name = "defaultValue", Type = "string", Nilable = false },
				{ Name = "serverStoredAccountWide", Type = "bool", Nilable = false },
				{ Name = "serverStoredPerCharacter", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetCVarMin",
			Type = "Function",

			Arguments =
			{
				{ Name = "cvar", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "min", Type = "number", Nilable = false },
			},
		},
		{
			Name = "RegisterCVar",
			Type = "Function",

			Arguments =
			{
				{ Name = "cvar", Type = "string", Nilable = false },
				{ Name = "default", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SetCVar",
			Type = "Function",

			Arguments =
			{
				{ Name = "cvar", Type = "string", Nilable = false },
				{ Name = "value", Type = "any", Nilable = false },
				{ Name = "raiseEvent", Type = "string", Nilable = true },
			},

		},
	},

	Events =
	{
		{
			Name = "CvarUpdate",
			Type = "Event",
			LiteralName = "CVAR_UPDATE",
			Payload =
			{
				{ Name = "glStr", Type = "string", Nilable = false },
				{ Name = "value", Type = "string", Nilable = false },
			},
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Cvar);
