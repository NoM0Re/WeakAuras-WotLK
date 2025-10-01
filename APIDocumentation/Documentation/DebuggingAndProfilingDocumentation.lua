local DebuggingAndProfiling =
{
	Name = "Debugging and Profiling",
	Type = "System",
	Namespace = "Debugging and Profiling",

	Functions =
	{
		{
			Name = "FrameXML_Debug",
			Type = "Function",

			Arguments =
			{
				{ Name = "enable", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "GetAddOnCPUUsage",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
			},

			Returns =
			{
				{ Name = "usage", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetAddOnMemoryUsage",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
			},

			Returns =
			{
				{ Name = "mem", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetEventCPUUsage",
			Type = "Function",

			Arguments =
			{
				{ Name = "event", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "usage", Type = "number", Nilable = false },
				{ Name = "numEvents", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetFrameCPUUsage",
			Type = "Function",

			Arguments =
			{
				{ Name = "frame", Type = "frame", Nilable = false },
				{ Name = "includeChildren", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "usage", Type = "number", Nilable = false },
				{ Name = "calls", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetFramerate",
			Type = "Function",

			Returns =
			{
				{ Name = "framerate", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetFunctionCPUUsage",
			Type = "Function",

			Arguments =
			{
				{ Name = "function", Type = "function", Nilable = false },
				{ Name = "includeSubroutines", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "usage", Type = "number", Nilable = false },
				{ Name = "calls", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNetStats",
			Type = "Function",

			Returns =
			{
				{ Name = "bandwidthIn", Type = "number", Nilable = false },
				{ Name = "bandwidthOut", Type = "number", Nilable = false },
				{ Name = "latencyHome", Type = "number", Nilable = false },
				{ Name = "latencyWorld", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetScriptCPUUsage",
			Type = "Function",

			Returns =
			{
				{ Name = "usage", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTaxiBenchmarkMode",
			Type = "Function",

			Returns =
			{
				{ Name = "isBenchmark", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ResetCPUUsage",
			Type = "Function",

		},
		{
			Name = "SetTaxiBenchmarkMode",
			Type = "Function",

			Arguments =
			{
				{ Name = "arg", Type = "string", Nilable = false },
			},

		},
		{
			Name = "UpdateAddOnCPUUsage",
			Type = "Function",

		},
		{
			Name = "UpdateAddOnMemoryUsage",
			Type = "Function",

		},
		{
			Name = "debugprofilestart",
			Type = "Function",

		},
		{
			Name = "debugprofilestop",
			Type = "Function",

			Returns =
			{
				{ Name = "time", Type = "time_t", Nilable = false },
			},
		},
		{
			Name = "debugstack",
			Type = "Function",

			Arguments =
			{
				{ Name = "start", Type = "number", Nilable = false },
				{ Name = "countTop", Type = "number", Nilable = false },
				{ Name = "countBot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "debugstring", Type = "string", Nilable = false },
			},
		},
		{
			Name = "geterrorhandler",
			Type = "Function",

			Returns =
			{
				{ Name = "handler", Type = "function", Nilable = false },
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
			Name = "seterrorhandler",
			Type = "Function",

			Arguments =
			{
				{ Name = "errHandler", Type = "function", Nilable = false },
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

APIDocumentation:AddDocumentationTable(DebuggingAndProfiling);
