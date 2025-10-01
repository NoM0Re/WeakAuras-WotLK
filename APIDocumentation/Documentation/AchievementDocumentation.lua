local Achievement =
{
	Name = "Achievement",
	Type = "System",
	Namespace = "Achievement",

	Functions =
	{
		{
			Name = "AddTrackedAchievement",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CanShowAchievementUI",
			Type = "Function",

			Returns =
			{
				{ Name = "canShow", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ClearAchievementComparisonUnit",
			Type = "Function",

		},
		{
			Name = "GetAchievementCategory",
			Type = "Function",

			Arguments =
			{
				{ Name = "achievementID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "categoryID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetAchievementComparisonInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "completed", Type = "bool", Nilable = false },
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetAchievementCriteriaInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "achievementID", Type = "number", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "statisticID", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "description", Type = "string", Nilable = false },
				{ Name = "type", Type = "number", Nilable = false },
				{ Name = "completed", Type = "bool", Nilable = false },
				{ Name = "quantity", Type = "number", Nilable = false },
				{ Name = "requiredQuantity", Type = "number", Nilable = false },
				{ Name = "characterName", Type = "string", Nilable = false },
				{ Name = "flags", Type = "number", Nilable = false },
				{ Name = "assetID", Type = "number", Nilable = false },
				{ Name = "quantityString", Type = "string", Nilable = false },
				{ Name = "criteriaID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetAchievementInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "category", Type = "number", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "id", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "points", Type = "number", Nilable = false },
				{ Name = "completed", Type = "bool", Nilable = false },
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
				{ Name = "description", Type = "string", Nilable = false },
				{ Name = "flags", Type = "number", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "rewardText", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetAchievementInfoFromCriteria",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "points", Type = "number", Nilable = false },
				{ Name = "description", Type = "string", Nilable = false },
				{ Name = "flags", Type = "number", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "rewardText", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetAchievementLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetAchievementNumCriteria",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "count", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetAchievementNumRewards",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "count", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetAchievementReward",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "points", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCategoryInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "parentID", Type = "number", Nilable = false },
				{ Name = "flags", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCategoryList",
			Type = "Function",

			Returns =
			{
				{ Name = "categories", Type = "table", Nilable = false },
			},
		},
		{
			Name = "GetCategoryNumAchievements",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "numItems", Type = "number", Nilable = false },
				{ Name = "numCompleted", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetComparisonAchievementPoints",
			Type = "Function",

			Returns =
			{
				{ Name = "points", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetComparisonCategoryNumAchievements",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "numCompleted", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetComparisonStatistic",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "info", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetLatestCompletedAchievements",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetLatestCompletedComparisonAchievements",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetLatestUpdatedComparisonStats",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetLatestUpdatedStats",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetNextAchievement",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "nextID", Type = "number", Nilable = false },
				{ Name = "completed", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetNumComparisonCompletedAchievements",
			Type = "Function",

			Returns =
			{
				{ Name = "total", Type = "number", Nilable = false },
				{ Name = "completed", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumCompletedAchievements",
			Type = "Function",

			Returns =
			{
				{ Name = "total", Type = "number", Nilable = false },
				{ Name = "completed", Type = "number", Nilable = false },
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
			Name = "GetPreviousAchievement",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "previousID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetStatistic",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "info", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetStatisticsCategoryList",
			Type = "Function",

			Returns =
			{
				{ Name = "categories", Type = "table", Nilable = false },
			},
		},
		{
			Name = "GetTotalAchievementPoints",
			Type = "Function",

			Returns =
			{
				{ Name = "points", Type = "number", Nilable = false },
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
			Name = "RemoveTrackedAchievement",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetAchievementComparisonUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "success", Type = "bool", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "AchievementEarned",
			Type = "Event",
			LiteralName = "ACHIEVEMENT_EARNED",
		},
		{
			Name = "ChatMsgAchievement",
			Type = "Event",
			LiteralName = "CHAT_MSG_ACHIEVEMENT",
		},
		{
			Name = "ChatMsgGuildAchievement",
			Type = "Event",
			LiteralName = "CHAT_MSG_GUILD_ACHIEVEMENT",
			Payload =
			{
				{ Name = "message", Type = "string", Nilable = false },
				{ Name = "sender", Type = "string", Nilable = false },
			},
		},
		{
			Name = "InspectAchievementReady",
			Type = "Event",
			LiteralName = "INSPECT_ACHIEVEMENT_READY",
		},
		{
			Name = "ReceivedAchievementList",
			Type = "Event",
			LiteralName = "RECEIVED_ACHIEVEMENT_LIST",
		},
		{
			Name = "TrackedAchievementUpdate",
			Type = "Event",
			LiteralName = "TRACKED_ACHIEVEMENT_UPDATE",
			Payload =
			{
				{ Name = "achievementId", Type = "number", Nilable = false },
			},
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Achievement);
