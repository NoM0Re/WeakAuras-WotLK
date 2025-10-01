local Trade =
{
	Name = "Trade",
	Type = "System",
	Namespace = "Trade",

	Functions =
	{
		{
			Name = "AcceptTrade",
			Type = "Function",

		},
		{
			Name = "AddTradeMoney",
			Type = "Function",

		},
		{
			Name = "BeginTrade",
			Type = "Function",

		},
		{
			Name = "CancelTrade",
			Type = "Function",

		},
		{
			Name = "CancelTradeAccept",
			Type = "Function",

		},
		{
			Name = "ClickTargetTradeButton",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "ClickTradeButton",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CloseTrade",
			Type = "Function",

		},
		{
			Name = "GetPlayerTradeMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTargetTradeMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTradePlayerItemInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "numItems", Type = "number", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
				{ Name = "isUsable", Type = "bool", Nilable = false },
				{ Name = "enchantment", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTradePlayerItemLink",
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
			Name = "GetTradeTargetItemInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "numItems", Type = "number", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
				{ Name = "isUsable", Type = "bool", Nilable = false },
				{ Name = "enchantment", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTradeTargetItemLink",
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
			Name = "InitiateTrade",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "PickupTradeMoney",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},

		},
		{
			Name = "ReplaceTradeEnchant",
			Type = "Function",

		},
		{
			Name = "SetTradeMoney",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "EndBoundTradeable",
			Type = "Event",
			LiteralName = "END_BOUND_TRADEABLE",
		},
		{
			Name = "TradeAcceptUpdate",
			Type = "Event",
			LiteralName = "TRADE_ACCEPT_UPDATE",
			Payload =
			{
				{ Name = "player", Type = "number", Nilable = false },
				{ Name = "target", Type = "number", Nilable = false },
			},
		},
		{
			Name = "TradeClosed",
			Type = "Event",
			LiteralName = "TRADE_CLOSED",
		},
		{
			Name = "TradePlayerItemChanged",
			Type = "Event",
			LiteralName = "TRADE_PLAYER_ITEM_CHANGED",
			Payload =
			{
				{ Name = "slotID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "TradePotentialBindEnchant",
			Type = "Event",
			LiteralName = "TRADE_POTENTIAL_BIND_ENCHANT",
		},
		{
			Name = "TradeReplaceEnchant",
			Type = "Event",
			LiteralName = "TRADE_REPLACE_ENCHANT",
			Payload =
			{
				{ Name = "current", Type = "string", Nilable = false },
				{ Name = "new", Type = "string", Nilable = false },
			},
		},
		{
			Name = "TradeShow",
			Type = "Event",
			LiteralName = "TRADE_SHOW",
		},
		{
			Name = "TradeTargetItemChanged",
			Type = "Event",
			LiteralName = "TRADE_TARGET_ITEM_CHANGED",
			Payload =
			{
				{ Name = "slotID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "TradeUpdate",
			Type = "Event",
			LiteralName = "TRADE_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Trade);
