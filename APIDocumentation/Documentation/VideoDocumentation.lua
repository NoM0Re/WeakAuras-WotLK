local Video =
{
	Name = "Video",
	Type = "System",
	Namespace = "Video",

	Functions =
	{
		{
			Name = "GetCurrentMultisampleFormat",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetCurrentResolution",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetFarclip",
			Type = "Function",

			Returns =
			{
				{ Name = "distance", Type = "number", Nilable = false },
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
			Name = "GetGamma",
			Type = "Function",

			Returns =
			{
				{ Name = "gamma", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetMultisampleFormats",
			Type = "Function",

			Returns =
			{
				{ Name = "color", Type = "number", Nilable = false },
				{ Name = "depth", Type = "number", Nilable = false },
				{ Name = "multisample", Type = "number", Nilable = false },
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetRefreshRates",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetScreenHeight",
			Type = "Function",

			Returns =
			{
				{ Name = "height", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetScreenResolutions",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetScreenWidth",
			Type = "Function",

			Returns =
			{
				{ Name = "screenWidth", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTerrainMip",
			Type = "Function",

			Returns =
			{
				{ Name = "terrainDetail", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetVideoCaps",
			Type = "Function",

			Returns =
			{
				{ Name = "hasAnisotropic", Type = "number", Nilable = false },
				{ Name = "hasPixelShaders", Type = "number", Nilable = false },
				{ Name = "hasVertexShaders", Type = "number", Nilable = false },
				{ Name = "hasTrilinear", Type = "number", Nilable = false },
				{ Name = "hasTripleBufering", Type = "number", Nilable = false },
				{ Name = "maxAnisotropy", Type = "number", Nilable = false },
				{ Name = "hasHardwareCursor", Type = "number", Nilable = false },
			},
		},
		{
			Name = "IsDesaturateSupported",
			Type = "Function",

			Returns =
			{
				{ Name = "isSupported", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsPlayerResolutionAvailable",
			Type = "Function",

			Returns =
			{
				{ Name = "isAvailable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsStereoVideoAvailable",
			Type = "Function",

			Returns =
			{
				{ Name = "isAvailable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "RestartGx",
			Type = "Function",

		},
		{
			Name = "RestoreVideoStereoDefaults",
			Type = "Function",

		},
		{
			Name = "SetGamma",
			Type = "Function",

			Arguments =
			{
				{ Name = "value", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetMultisampleFormat",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetScreenResolution",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetTexLodBias",
			Type = "Function",

		},
		{
			Name = "SetWaterDetail",
			Type = "Function",

			Arguments =
			{
				{ Name = "value", Type = "number", Nilable = false },
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

APIDocumentation:AddDocumentationTable(Video);
