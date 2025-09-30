local ModifiedClick =
{
	Name = "Modified_click",
	Type = "System",
	Namespace = "",

	Functions =
	{
		{
			Name = "GetModifiedClick",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "binding", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetModifiedClickAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "action", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetNumModifiedClickActions",
			Type = "Function",

			Returns =
			{
				{ Name = "num", Type = "number", Nilable = false },
			},
		},
		{
			Name = "IsModifiedClick",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "modifiedClick", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetModifiedClick",
			Type = "Function",

			Arguments =
			{
				{ Name = "action", Type = "string", Nilable = false },
				{ Name = "binding", Type = "string", Nilable = false },
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

APIDocumentation:AddDocumentationTable(ModifiedClick);
