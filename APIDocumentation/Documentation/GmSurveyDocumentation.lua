local GmSurvey =
{
	Name = "GM_Survey",
	Type = "System",
	Namespace = "",

	Functions =
	{
		{
			Name = "GMSurveyAnswer",
			Type = "Function",

			Arguments =
			{
				{ Name = "questionIndex", Type = "number", Nilable = false },
				{ Name = "answerIndex", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "answerText", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GMSurveyAnswerSubmit",
			Type = "Function",

			Arguments =
			{
				{ Name = "question", Type = "number", Nilable = false },
				{ Name = "rank", Type = "number", Nilable = false },
				{ Name = "comment", Type = "string", Nilable = false },
			},

		},
		{
			Name = "GMSurveyCommentSubmit",
			Type = "Function",

			Arguments =
			{
				{ Name = "comment", Type = "string", Nilable = false },
			},

		},
		{
			Name = "GMSurveyNumAnswers",
			Type = "Function",

			Arguments =
			{
				{ Name = "questionIndex", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "numAnswers", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GMSurveyQuestion",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "surveyQuestion", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GMSurveySubmit",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "GmsurveyDisplay",
			Type = "Event",
			LiteralName = "GMSURVEY_DISPLAY",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(GmSurvey);
