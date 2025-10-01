local MacClient =
{
	Name = "Mac Client",
	Type = "System",
	Namespace = "Mac Client",

	Functions =
	{
		{
			Name = "IsMacClient",
			Type = "Function",

			Returns =
			{
				{ Name = "isMac", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "MovieRecording_Cancel",
			Type = "Function",

		},
		{
			Name = "MovieRecording_DataRate",
			Type = "Function",

			Arguments =
			{
				{ Name = "width", Type = "number", Nilable = false },
				{ Name = "framerate", Type = "number", Nilable = false },
				{ Name = "sound", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "dataRate", Type = "string", Nilable = false },
			},
		},
		{
			Name = "MovieRecording_DeleteMovie",
			Type = "Function",

			Arguments =
			{
				{ Name = "filename", Type = "string", Nilable = false },
			},

		},
		{
			Name = "MovieRecording_GetAspectRatio",
			Type = "Function",

			Returns =
			{
				{ Name = "ratio", Type = "number", Nilable = false },
			},
		},
		{
			Name = "MovieRecording_GetMovieFullPath",
			Type = "Function",

			Returns =
			{
				{ Name = "path", Type = "string", Nilable = false },
			},
		},
		{
			Name = "MovieRecording_GetProgress",
			Type = "Function",

			Returns =
			{
				{ Name = "recovering", Type = "bool", Nilable = false },
				{ Name = "progress", Type = "number", Nilable = false },
			},
		},
		{
			Name = "MovieRecording_GetTime",
			Type = "Function",

			Returns =
			{
				{ Name = "time", Type = "string", Nilable = false },
			},
		},
		{
			Name = "MovieRecording_GetViewportWidth",
			Type = "Function",

			Returns =
			{
				{ Name = "width", Type = "number", Nilable = false },
			},
		},
		{
			Name = "MovieRecording_IsCodecSupported",
			Type = "Function",

			Arguments =
			{
				{ Name = "codecID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isSupported", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "MovieRecording_IsCompressing",
			Type = "Function",

			Returns =
			{
				{ Name = "isCompressing", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "MovieRecording_IsCursorRecordingSupported",
			Type = "Function",

			Returns =
			{
				{ Name = "isSupported", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "MovieRecording_IsRecording",
			Type = "Function",

			Returns =
			{
				{ Name = "isRecording", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "MovieRecording_IsSupported",
			Type = "Function",

			Returns =
			{
				{ Name = "isSupported", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "MovieRecording_MaxLength",
			Type = "Function",

			Arguments =
			{
				{ Name = "width", Type = "number", Nilable = false },
				{ Name = "framerate", Type = "number", Nilable = false },
				{ Name = "sound", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "time", Type = "string", Nilable = false },
			},
		},
		{
			Name = "MovieRecording_QueueMovieToCompress",
			Type = "Function",

			Arguments =
			{
				{ Name = "filename", Type = "string", Nilable = false },
			},

		},
		{
			Name = "MovieRecording_SearchUncompressedMovie",
			Type = "Function",

			Arguments =
			{
				{ Name = "enable", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "MovieRecording_Toggle",
			Type = "Function",

		},
		{
			Name = "MovieRecording_ToggleGUI",
			Type = "Function",

		},
		{
			Name = "MusicPlayer_BackTrack",
			Type = "Function",

		},
		{
			Name = "MusicPlayer_NextTrack",
			Type = "Function",

		},
		{
			Name = "MusicPlayer_PlayPause",
			Type = "Function",

		},
		{
			Name = "MusicPlayer_VolumeDown",
			Type = "Function",

		},
		{
			Name = "MusicPlayer_VolumeUp",
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

APIDocumentation:AddDocumentationTable(MacClient);
