local ItemText =
{
	Name = "Item Text",
	Type = "System",
	Namespace = "Item Text",

	Functions =
	{
		{
			Name = "CloseItemText",
			Type = "Function",

		},
		{
			Name = "ItemTextGetCreator",
			Type = "Function",

			Returns =
			{
				{ Name = "creator", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ItemTextGetItem",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ItemTextGetMaterial",
			Type = "Function",

			Returns =
			{
				{ Name = "material", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ItemTextGetPage",
			Type = "Function",

			Returns =
			{
				{ Name = "page", Type = "number", Nilable = false },
			},
		},
		{
			Name = "ItemTextGetText",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ItemTextHasNextPage",
			Type = "Function",

			Returns =
			{
				{ Name = "next", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ItemTextNextPage",
			Type = "Function",

		},
		{
			Name = "ItemTextPrevPage",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "ItemTextBegin",
			Type = "Event",
			LiteralName = "ITEM_TEXT_BEGIN",
		},
		{
			Name = "ItemTextClosed",
			Type = "Event",
			LiteralName = "ITEM_TEXT_CLOSED",
		},
		{
			Name = "ItemTextReady",
			Type = "Event",
			LiteralName = "ITEM_TEXT_READY",
		},
		{
			Name = "ItemTextTranslation",
			Type = "Event",
			LiteralName = "ITEM_TEXT_TRANSLATION",
			Payload =
			{
				{ Name = "maxvalue", Type = "number", Nilable = false },
			},
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(ItemText);
