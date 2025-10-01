local Complaint =
{
	Name = "Complaint",
	Type = "System",
	Namespace = "Complaint",

	Functions =
	{
		{
			Name = "CalendarContextEventCanComplain",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "canReport", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarContextEventComplain",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CanComplainChat",
			Type = "Function",

			Arguments =
			{
				{ Name = "lineID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "canComplain", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanComplainInboxItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "complain", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ComplainChat",
			Type = "Function",

			Arguments =
			{
				{ Name = "lineID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "canComplain", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ComplainInboxItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "complain", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PlayerIsPVPInactive",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
			},

			Returns =
			{
				{ Name = "isInactive", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ReportPlayerIsPVPAFK",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
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

APIDocumentation:AddDocumentationTable(Complaint);
