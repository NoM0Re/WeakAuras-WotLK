local Socketing =
{
	Name = "Socketing",
	Type = "System",
	Namespace = "Socketing",

	Functions =
	{
		{
			Name = "AcceptSockets",
			Type = "Function",

		},
		{
			Name = "ClickSocketButton",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CloseSocketInfo",
			Type = "Function",

		},
		{
			Name = "GetExistingSocketInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "name", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetExistingSocketLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetItemGem",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetNewSocketInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "matches", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetNewSocketLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetNumSockets",
			Type = "Function",

			Returns =
			{
				{ Name = "numSockets", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSocketItemBoundTradeable",
			Type = "Function",

			Returns =
			{
				{ Name = "tradeable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetSocketItemInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
			},
		},
		{
			Name = "GetSocketItemRefundable",
			Type = "Function",

			Returns =
			{
				{ Name = "refundable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetSocketTypes",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "gemColor", Type = "string", Nilable = false },
			},
		},
		{
			Name = "SocketContainerItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SocketInventoryItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "SocketInfoClose",
			Type = "Event",
			LiteralName = "SOCKET_INFO_CLOSE",
		},
		{
			Name = "SocketInfoUpdate",
			Type = "Event",
			LiteralName = "SOCKET_INFO_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Socketing);
