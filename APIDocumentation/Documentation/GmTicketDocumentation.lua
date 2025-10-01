local GmTicket =
{
	Name = "GM Ticket",
	Type = "System",
	Namespace = "GM Ticket",

	Functions =
	{
		{
			Name = "DeleteGMTicket",
			Type = "Function",

		},
		{
			Name = "GMResponseNeedMoreHelp",
			Type = "Function",

		},
		{
			Name = "GMResponseResolve",
			Type = "Function",

		},
		{
			Name = "GetGMStatus",
			Type = "Function",

		},
		{
			Name = "GetGMTicket",
			Type = "Function",

		},
		{
			Name = "GetGMTicketCategories",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "NewGMTicket",
			Type = "Function",

			Arguments =
			{
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "needResponse", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "Stuck",
			Type = "Function",

		},
		{
			Name = "UpdateGMTicket",
			Type = "Function",

			Arguments =
			{
				{ Name = "text", Type = "string", Nilable = false },
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

APIDocumentation:AddDocumentationTable(GmTicket);
