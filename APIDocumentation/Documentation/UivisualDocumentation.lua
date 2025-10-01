local Uivisual =
{
	Name = "UIVisual",
	Type = "System",
	Namespace = "UIVisual",

	Functions =
	{
		{
			Name = "ConsoleAddMessage",
			Type = "Function",

		},
		{
			Name = "ConsoleExec",
			Type = "Function",

			Arguments =
			{
				{ Name = "console_command", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SetupFullscreenScale",
			Type = "Function",

			Arguments =
			{
				{ Name = "frame", Type = "frame", Nilable = false },
			},

		},
		{
			Name = "ShowCloak",
			Type = "Function",

			Arguments =
			{
				{ Name = "show", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "ShowHelm",
			Type = "Function",

			Arguments =
			{
				{ Name = "show", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "ShowingCloak",
			Type = "Function",

			Returns =
			{
				{ Name = "isShown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ShowingHelm",
			Type = "Function",

			Returns =
			{
				{ Name = "isShown", Type = "bool", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "MirrorTimerPause",
			Type = "Event",
			LiteralName = "MIRROR_TIMER_PAUSE",
			Payload =
			{
				{ Name = "duration", Type = "time_t", Nilable = false },
			},
		},
		{
			Name = "MirrorTimerStart",
			Type = "Event",
			LiteralName = "MIRROR_TIMER_START",
			Payload =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "value", Type = "number", Nilable = false },
				{ Name = "maxvalue", Type = "number", Nilable = false },
				{ Name = "step", Type = "number", Nilable = false },
				{ Name = "pause", Type = "number", Nilable = false },
				{ Name = "label", Type = "string", Nilable = false },
			},
		},
		{
			Name = "MirrorTimerStop",
			Type = "Event",
			LiteralName = "MIRROR_TIMER_STOP",
			Payload =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "TabardCansaveChanged",
			Type = "Event",
			LiteralName = "TABARD_CANSAVE_CHANGED",
		},
		{
			Name = "TabardSavePending",
			Type = "Event",
			LiteralName = "TABARD_SAVE_PENDING",
		},
		{
			Name = "UiErrorMessage",
			Type = "Event",
			LiteralName = "UI_ERROR_MESSAGE",
			Payload =
			{
				{ Name = "message", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UiInfoMessage",
			Type = "Event",
			LiteralName = "UI_INFO_MESSAGE",
			Payload =
			{
				{ Name = "message", Type = "string", Nilable = false },
			},
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Uivisual);
