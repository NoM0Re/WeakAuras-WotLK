local Tutorial =
{
	Name = "Tutorial",
	Type = "System",
	Namespace = "Tutorial",

	Functions =
	{
		{
			Name = "ClearTutorials",
			Type = "Function",

		},
		{
			Name = "FlagTutorial",
			Type = "Function",

			Arguments =
			{
				{ Name = "tutorial", Type = "string", Nilable = false },
			},

		},
		{
			Name = "ResetTutorials",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "TutorialTrigger",
			Type = "Event",
			LiteralName = "TUTORIAL_TRIGGER",
			Payload =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Tutorial);
