local ClientControlAndInformation =
{
	Name = "Client Control and Information",
	Type = "System",
	Namespace = "Client Control and Information",

	Functions =
	{
		{
			Name = "CancelLogout",
			Type = "Function",

		},
		{
			Name = "DownloadSettings",
			Type = "Function",

		},
		{
			Name = "ForceLogout",
			Type = "Function",

		},
		{
			Name = "ForceQuit",
			Type = "Function",

		},
		{
			Name = "GetAccountExpansionLevel",
			Type = "Function",

			Returns =
			{
				{ Name = "expansionLevel", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetBuildInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "version", Type = "string", Nilable = false },
				{ Name = "internalVersion", Type = "string", Nilable = false },
				{ Name = "date", Type = "string", Nilable = false },
				{ Name = "uiVersion", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetExistingLocales",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetExpansionLevel",
			Type = "Function",

		},
		{
			Name = "GetGameTime",
			Type = "Function",

			Returns =
			{
				{ Name = "hour", Type = "number", Nilable = false },
				{ Name = "minute", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetLocale",
			Type = "Function",

			Returns =
			{
				{ Name = "locale", Type = "string", Nilable = false },
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
			Name = "IsLinuxClient",
			Type = "Function",

			Returns =
			{
				{ Name = "isLinux", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsMacClient",
			Type = "Function",

			Returns =
			{
				{ Name = "isMac", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsWindowsClient",
			Type = "Function",

			Returns =
			{
				{ Name = "isWindows", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "Logout",
			Type = "Function",

		},
		{
			Name = "NotWhileDeadError",
			Type = "Function",

		},
		{
			Name = "Quit",
			Type = "Function",

		},
		{
			Name = "ReloadUI",
			Type = "Function",

		},
		{
			Name = "Screenshot",
			Type = "Function",

		},
		{
			Name = "SetEuropeanNumbers",
			Type = "Function",

			Arguments =
			{
				{ Name = "enable", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "SetUIVisibility",
			Type = "Function",

			Arguments =
			{
				{ Name = "visible", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "UploadSettings",
			Type = "Function",

		},
	},

	Events =
	{
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(ClientControlAndInformation);
