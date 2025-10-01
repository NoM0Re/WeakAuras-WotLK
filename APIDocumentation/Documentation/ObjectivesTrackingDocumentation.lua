local ObjectivesTracking =
{
	Name = "Objectives Tracking",
	Type = "System",
	Namespace = "Objectives Tracking",

	Functions =
	{
		{
			Name = "AddQuestWatch",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "AddTrackedAchievement",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

		},
		{
			Name = "GetNumQuestWatches",
			Type = "Function",

			Returns =
			{
				{ Name = "numWatches", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumTrackedAchievements",
			Type = "Function",

			Returns =
			{
				{ Name = "count", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestIndexForWatch",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogSpecialItemCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "start", Type = "number", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "enable", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogSpecialItemInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "charges", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTrackedAchievements",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "IsQuestLogSpecialItemInRange",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "inRange", Type = "number", Nilable = false },
			},
		},
		{
			Name = "IsQuestWatched",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "isWatched", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsTrackedAchievement",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isTracked", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "RemoveQuestWatch",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "RemoveTrackedAchievement",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

		},
		{
			Name = "UseQuestLogSpecialItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
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

APIDocumentation:AddDocumentationTable(ObjectivesTracking);
