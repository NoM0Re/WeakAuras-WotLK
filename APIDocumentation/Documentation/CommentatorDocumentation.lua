local Commentator =
{
	Name = "Commentator",
	Type = "System",
	Namespace = "Commentator",

	Functions =
	{
		{
			Name = "CommentatorAddPlayer",
			Type = "Function",

		},
		{
			Name = "CommentatorEnterInstance",
			Type = "Function",

		},
		{
			Name = "CommentatorExitInstance",
			Type = "Function",

		},
		{
			Name = "CommentatorFollowPlayer",
			Type = "Function",

		},
		{
			Name = "CommentatorGetCamera",
			Type = "Function",

		},
		{
			Name = "CommentatorGetCurrentMapID",
			Type = "Function",

		},
		{
			Name = "CommentatorGetInstanceInfo",
			Type = "Function",

		},
		{
			Name = "CommentatorGetMapInfo",
			Type = "Function",

		},
		{
			Name = "CommentatorGetMode",
			Type = "Function",

		},
		{
			Name = "CommentatorGetNumMaps",
			Type = "Function",

		},
		{
			Name = "CommentatorGetNumPlayers",
			Type = "Function",

		},
		{
			Name = "CommentatorGetPlayerInfo",
			Type = "Function",

		},
		{
			Name = "CommentatorGetSkirmishMode",
			Type = "Function",

		},
		{
			Name = "CommentatorGetSkirmishQueueCount",
			Type = "Function",

		},
		{
			Name = "CommentatorGetSkirmishQueuePlayerInfo",
			Type = "Function",

		},
		{
			Name = "CommentatorLookatPlayer",
			Type = "Function",

		},
		{
			Name = "CommentatorRemovePlayer",
			Type = "Function",

		},
		{
			Name = "CommentatorRequestSkirmishMode",
			Type = "Function",

		},
		{
			Name = "CommentatorRequestSkirmishQueueData",
			Type = "Function",

		},
		{
			Name = "CommentatorSetBattlemaster",
			Type = "Function",

		},
		{
			Name = "CommentatorSetCamera",
			Type = "Function",

		},
		{
			Name = "CommentatorSetCameraCollision",
			Type = "Function",

		},
		{
			Name = "CommentatorSetMapAndInstanceIndex",
			Type = "Function",

		},
		{
			Name = "CommentatorSetMode",
			Type = "Function",

		},
		{
			Name = "CommentatorSetMoveSpeed",
			Type = "Function",

		},
		{
			Name = "CommentatorSetPlayerIndex",
			Type = "Function",

		},
		{
			Name = "CommentatorSetSkirmishMatchmakingMode",
			Type = "Function",

		},
		{
			Name = "CommentatorSetTargetHeightOffset",
			Type = "Function",

		},
		{
			Name = "CommentatorStartInstance",
			Type = "Function",

		},
		{
			Name = "CommentatorStartSkirmishMatch",
			Type = "Function",

		},
		{
			Name = "CommentatorToggleMode",
			Type = "Function",

		},
		{
			Name = "CommentatorUpdateMapInfo",
			Type = "Function",

		},
		{
			Name = "CommentatorUpdatePlayerInfo",
			Type = "Function",

		},
		{
			Name = "CommentatorZoomIn",
			Type = "Function",

		},
		{
			Name = "CommentatorZoomOut",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "CommentatorEnterWorld",
			Type = "Event",
			LiteralName = "COMMENTATOR_ENTER_WORLD",
		},
		{
			Name = "CommentatorMapUpdate",
			Type = "Event",
			LiteralName = "COMMENTATOR_MAP_UPDATE",
		},
		{
			Name = "CommentatorPlayerUpdate",
			Type = "Event",
			LiteralName = "COMMENTATOR_PLAYER_UPDATE",
		},
		{
			Name = "CommentatorSkirmishModeRequest",
			Type = "Event",
			LiteralName = "COMMENTATOR_SKIRMISH_MODE_REQUEST",
		},
		{
			Name = "CommentatorSkirmishQueueRequest",
			Type = "Event",
			LiteralName = "COMMENTATOR_SKIRMISH_QUEUE_REQUEST",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Commentator);
