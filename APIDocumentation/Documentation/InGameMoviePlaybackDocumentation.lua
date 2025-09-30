local InGameMoviePlayback =
{
	Name = "In-game_movie_playback",
	Type = "System",
	Namespace = "In-game_movie_playback",

	Functions =
	{
		{
			Name = "GameMovieFinished",
			Type = "Function",

		},
		{
			Name = "GetMovieResolution",
			Type = "Function",

			Returns =
			{
				{ Name = "resolution", Type = "number", Nilable = false },
			},
		},
		{
			Name = "InCinematic",
			Type = "Function",

			Returns =
			{
				{ Name = "inCinematic", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "OpeningCinematic",
			Type = "Function",

		},
		{
			Name = "StopCinematic",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "CinematicStart",
			Type = "Event",
			LiteralName = "CINEMATIC_START",
		},
		{
			Name = "CinematicStop",
			Type = "Event",
			LiteralName = "CINEMATIC_STOP",
		},
		{
			Name = "MovieCompressingProgress",
			Type = "Event",
			LiteralName = "MOVIE_COMPRESSING_PROGRESS",
		},
		{
			Name = "MovieRecordingProgress",
			Type = "Event",
			LiteralName = "MOVIE_RECORDING_PROGRESS",
		},
		{
			Name = "MovieUncompressedMovie",
			Type = "Event",
			LiteralName = "MOVIE_UNCOMPRESSED_MOVIE",
			Payload =
			{
				{ Name = "filename", Type = "string", Nilable = false },
			},
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(InGameMoviePlayback);
