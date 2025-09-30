local Minigame =
{
	Name = "Minigame",
	Type = "System",
	Namespace = "Minigame",

	Functions =
	{
		{
			Name = "GetMinigameState",
			Type = "Function",

		},
		{
			Name = "GetMinigameType",
			Type = "Function",

		},
		{
			Name = "MakeMinigameMove",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "MinigameUpdate",
			Type = "Event",
			LiteralName = "MINIGAME_UPDATE",
		},
		{
			Name = "StartMinigame",
			Type = "Event",
			LiteralName = "START_MINIGAME",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Minigame);
