local NpcGossipDialog =
{
	Name = "NPC Gossip Dialog",
	Type = "System",
	Namespace = "NPC Gossip Dialog",

	Functions =
	{
		{
			Name = "CloseGossip",
			Type = "Function",

		},
		{
			Name = "GetGossipActiveQuests",
			Type = "Function",

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "level", Type = "number", Nilable = false },
				{ Name = "isTrivial", Type = "bool", Nilable = false },
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetGossipAvailableQuests",
			Type = "Function",

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "level", Type = "number", Nilable = false },
				{ Name = "isTrivial", Type = "bool", Nilable = false },
				{ Name = "isDaily", Type = "bool", Nilable = false },
				{ Name = "isRepeatable", Type = "bool", Nilable = false },
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetGossipOptions",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "gossipType", Type = "string", Nilable = false },
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetGossipText",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetNumGossipActiveQuests",
			Type = "Function",

			Returns =
			{
				{ Name = "num", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumGossipAvailableQuests",
			Type = "Function",

			Returns =
			{
				{ Name = "num", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumGossipOptions",
			Type = "Function",

			Returns =
			{
				{ Name = "numOptions", Type = "number", Nilable = false },
			},
		},
		{
			Name = "SelectGossipActiveQuest",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SelectGossipAvailableQuest",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SelectGossipOption",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "confirm", Type = "bool", Nilable = true },
			},

		},
	},

	Events =
	{
		{
			Name = "GossipClosed",
			Type = "Event",
			LiteralName = "GOSSIP_CLOSED",
		},
		{
			Name = "GossipConfirm",
			Type = "Event",
			LiteralName = "GOSSIP_CONFIRM",
			Payload =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "message", Type = "string", Nilable = false },
				{ Name = "cost", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GossipConfirmCancel",
			Type = "Event",
			LiteralName = "GOSSIP_CONFIRM_CANCEL",
		},
		{
			Name = "GossipEnterCode",
			Type = "Event",
			LiteralName = "GOSSIP_ENTER_CODE",
			Payload =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GossipShow",
			Type = "Event",
			LiteralName = "GOSSIP_SHOW",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(NpcGossipDialog);
