local LocaleSpecific =
{
	Name = "Locale Specific",
	Type = "System",
	Namespace = "Locale Specific",

	Functions =
	{
		{
			Name = "DeclineName",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "gender", Type = "number", Nilable = false },
				{ Name = "declensionSet", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "genitive", Type = "string", Nilable = false },
				{ Name = "dative", Type = "string", Nilable = false },
				{ Name = "accusative", Type = "string", Nilable = false },
				{ Name = "instrumental", Type = "string", Nilable = false },
				{ Name = "prepositional", Type = "string", Nilable = false },
			},
		},
		{
			Name = "FillLocalizedClassList",
			Type = "Function",

			Arguments =
			{
				{ Name = "table", Type = "number", Nilable = false },
				{ Name = "female", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "GetNumDeclensionSets",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "gender", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "numSets", Type = "number", Nilable = false },
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

APIDocumentation:AddDocumentationTable(LocaleSpecific);
