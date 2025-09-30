local MultiCastActions =
{
	Name = "Multi-cast_actions",
	Type = "System",
	Namespace = "Multi-cast_actions",

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
