local ClassResource =
{
	Name = "Class Resource",
	Type = "System",
	Namespace = "Class Resource",

	Functions =
	{
		{
			Name = "DestroyTotem",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "GetRuneCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "start", Type = "number", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "runeReady", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetRuneCount",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "count", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetRuneType",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "runeType", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTotemInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "haveTotem", Type = "bool", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "startTime", Type = "time_t", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTotemTimeLeft",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "seconds", Type = "number", Nilable = false },
			},
		},
		{
			Name = "TargetTotem",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
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

APIDocumentation:AddDocumentationTable(ClassResource);
