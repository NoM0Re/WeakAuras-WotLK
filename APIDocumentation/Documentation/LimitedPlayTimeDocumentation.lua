local LimitedPlayTime =
{
	Name = "Limited Play Time",
	Type = "System",
	Namespace = "Limited Play Time",

	Functions =
	{
		{
			Name = "GetBillingTimeRested",
			Type = "Function",

			Returns =
			{
				{ Name = "time", Type = "time_t", Nilable = false },
			},
		},
		{
			Name = "NoPlayTime",
			Type = "Function",

			Returns =
			{
				{ Name = "hasNoTime", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PartialPlayTime",
			Type = "Function",

			Returns =
			{
				{ Name = "partialPlayTime", Type = "bool", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "BillingNagDialog",
			Type = "Event",
			LiteralName = "BILLING_NAG_DIALOG",
			Payload =
			{
				{ Name = "remaining", Type = "number", Nilable = false },
			},
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(LimitedPlayTime);
