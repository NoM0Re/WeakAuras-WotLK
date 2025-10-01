local MultiCastActions =
{
	Name = "MultiCast Actions",
	Type = "System",
	Namespace = "MultiCast Actions",

	Functions =
	{
		{
			Name = "SetMultiCastSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "action", Type = "number", Nilable = false },
				{ Name = "spell", Type = "number", Nilable = false },
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

APIDocumentation:AddDocumentationTable(MultiCastActions);
