local Utility =
{
	Name = "Utility",
	Type = "System",
	Namespace = "Utility",

	Functions =
	{
		{
			Name = "CreateFont",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "fontObject", Type = "table", Nilable = false },
			},
		},
		{
			Name = "CreateFrame",
			Type = "Function",

			Arguments =
			{
				{ Name = "frameType", Type = "string", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "parent", Type = "table", Nilable = false },
				{ Name = "template", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "frame", Type = "frame", Nilable = false },
			},
		},
		{
			Name = "EnumerateFrames",
			Type = "Function",

			Arguments =
			{
				{ Name = "currentFrame", Type = "frame", Nilable = true },
			},

			Returns =
			{
				{ Name = "nextFrame", Type = "frame", Nilable = false },
			},
		},
		{
			Name = "GetAutoCompleteResults",
			Type = "Function",

			Arguments =
			{
				{ Name = "inputString", Type = "string", Nilable = false },
				{ Name = "includeBitfield", Type = "number", Nilable = false },
				{ Name = "excludeBitfield", Type = "number", Nilable = false },
				{ Name = "maxResults", Type = "number", Nilable = false },
				{ Name = "cursorPosition", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetClickFrame",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "frame", Type = "frame", Nilable = false },
			},
		},
		{
			Name = "GetCurrentKeyBoardFocus",
			Type = "Function",

			Returns =
			{
				{ Name = "frame", Type = "frame", Nilable = false },
			},
		},
		{
			Name = "GetFramesRegisteredForEvent",
			Type = "Function",

			Arguments =
			{
				{ Name = "event", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetMirrorTimerInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "timer", Type = "string", Nilable = false },
				{ Name = "value", Type = "number", Nilable = false },
				{ Name = "maxvalue", Type = "number", Nilable = false },
				{ Name = "scale", Type = "number", Nilable = false },
				{ Name = "paused", Type = "number", Nilable = false },
				{ Name = "label", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetMirrorTimerProgress",
			Type = "Function",

			Arguments =
			{
				{ Name = "timer", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "progress", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetMouseButtonClicked",
			Type = "Function",

			Returns =
			{
				{ Name = "button", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetMouseButtonName",
			Type = "Function",

			Arguments =
			{
				{ Name = "buttonNumber", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "buttonName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetMouseFocus",
			Type = "Function",

			Returns =
			{
				{ Name = "frame", Type = "frame", Nilable = false },
			},
		},
		{
			Name = "GetMuteName",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetNumFrames",
			Type = "Function",

			Returns =
			{
				{ Name = "numFrames", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetText",
			Type = "Function",

			Arguments =
			{
				{ Name = "eventType", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "expansion", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTime",
			Type = "Function",

			Returns =
			{
				{ Name = "time", Type = "time_t", Nilable = false },
			},
		},
		{
			Name = "IsLoggedIn",
			Type = "Function",

			Returns =
			{
				{ Name = "loggedIn", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsMouseButtonDown",
			Type = "Function",

			Arguments =
			{
				{ Name = "button", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "isDown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "RegisterForSave",
			Type = "Function",

		},
		{
			Name = "RegisterForSavePerCharacter",
			Type = "Function",

		},
		{
			Name = "RequestTimePlayed",
			Type = "Function",

		},
		{
			Name = "RunScript",
			Type = "Function",

			Arguments =
			{
				{ Name = "script", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SecondsToTime",
			Type = "Function",

			Arguments =
			{
				{ Name = "seconds", Type = "number", Nilable = false },
				{ Name = "noSeconds", Type = "bool", Nilable = false },
				{ Name = "notAbbreviated", Type = "bool", Nilable = false },
				{ Name = "maxCount", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "time", Type = "string", Nilable = false },
			},
		},
		{
			Name = "SetPortraitToTexture",
			Type = "Function",

			Arguments =
			{
				{ Name = "frameName", Type = "string", Nilable = false },
				{ Name = "texturePath", Type = "string", Nilable = false },
			},

		},
		{
			Name = "debuglocals",
			Type = "Function",

			Arguments =
			{
				{ Name = "stackLevel", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "localsInfo", Type = "string", Nilable = false },
			},
		},
		{
			Name = "getglobal",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "value", Type = "string", Nilable = false },
			},
		},
		{
			Name = "scrub",
			Type = "Function",

			Arguments =
			{
				{ Name = "...", Type = "table", Nilable = false },
			},

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "setglobal",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "value", Type = "string", Nilable = false },
			},

		},
		{
			Name = "strconcat",
			Type = "Function",

			Arguments =
			{
				{ Name = "...", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "result", Type = "string", Nilable = false },
			},
		},
		{
			Name = "strjoin",
			Type = "Function",

			Arguments =
			{
				{ Name = "sep", Type = "string", Nilable = false },
				{ Name = "...", Type = "table", Nilable = false },
			},

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "strlenutf8",
			Type = "Function",

			Arguments =
			{
				{ Name = "string", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "length", Type = "number", Nilable = false },
			},
		},
		{
			Name = "strreplace",
			Type = "Function",

			Arguments =
			{
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "pattern", Type = "string", Nilable = false },
				{ Name = "replacement", Type = "string", Nilable = false },
				{ Name = "count", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "newText", Type = "string", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
			},
		},
		{
			Name = "strsplit",
			Type = "Function",

			Arguments =
			{
				{ Name = "sep", Type = "string", Nilable = false },
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "limit", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "strtrim",
			Type = "Function",

			Arguments =
			{
				{ Name = "str", Type = "string", Nilable = false },
				{ Name = "trimChars", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "wipe",
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

APIDocumentation:AddDocumentationTable(Utility);
