local MultiCastActions =
{
	Name = "Multi-cast_actions",
	Type = "System",
	Namespace = "",

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
