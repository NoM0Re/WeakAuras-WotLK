local SecureExecutionUtility =
{
	Name = "Secure Execution Utility",
	Type = "System",
	Namespace = "Secure Execution Utility",

	Functions =
	{
		{
			Name = "InCombatLockdown",
			Type = "Function",

			Returns =
			{
				{ Name = "inLockdown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "forceinsecure",
			Type = "Function",

		},
		{
			Name = "hooksecurefunc",
			Type = "Function",

			Arguments =
			{
				{ Name = "table", Type = "table", Nilable = true },
				{ Name = "function", Type = "string", Nilable = false },
				{ Name = "hookfunc", Type = "function", Nilable = false },
			},

		},
		{
			Name = "issecure",
			Type = "Function",

			Returns =
			{
				{ Name = "secure", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "issecurevariable",
			Type = "Function",

			Arguments =
			{
				{ Name = "table", Type = "table", Nilable = true },
				{ Name = "variable", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "issecure", Type = "bool", Nilable = false },
				{ Name = "taint", Type = "string", Nilable = false },
			},
		},
		{
			Name = "newproxy",
			Type = "Function",

			Arguments =
			{
				{ Name = "boolean", Type = "bool", Nilable = true },
				{ Name = "userdata", Type = "userdata", Nilable = true },
			},

			Returns =
			{
				{ Name = "userdata", Type = "userdata", Nilable = false },
			},
		},
		{
			Name = "securecall",
			Type = "Function",

			Arguments =
			{
				{ Name = "function", Type = "function", Nilable = false },
				{ Name = "...", Type = "table", Nilable = false },
			},

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
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

APIDocumentation:AddDocumentationTable(SecureExecutionUtility);
