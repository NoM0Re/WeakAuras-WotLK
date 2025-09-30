local Money =
{
	Name = "Money",
	Type = "System",
	Namespace = "Money",

	Functions =
	{
		{
			Name = "AddTradeMoney",
			Type = "Function",

		},
		{
			Name = "CanWithdrawGuildBankMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "canWithdraw", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CursorHasMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "hasMoney", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "DepositGuildBankMoney",
			Type = "Function",

			Arguments =
			{
				{ Name = "money", Type = "number", Nilable = false },
			},

		},
		{
			Name = "DropCursorMoney",
			Type = "Function",

		},
		{
			Name = "GetCoinIcon",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "icon", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetCoinText",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
				{ Name = "separator", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "coinText", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetCoinTextureString",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
				{ Name = "fontSize", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "coinText", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetCursorMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "cursorMoney", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "money", Type = "number", Nilable = false },
			},
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
			Name = "GetQuestLogRequiredMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "money", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogRewardMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "money", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSendMailMoney",
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
			Name = "PickupGuildBankMoney",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},

		},
		{
			Name = "PickupPlayerMoney",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
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
			Name = "SetSendMailMoney",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "success", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetTradeMoney",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},

		},
		{
			Name = "WithdrawGuildBankMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "canWithdraw", Type = "bool", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "ChatMsgMoney",
			Type = "Event",
			LiteralName = "CHAT_MSG_MONEY",
			Payload =
			{
				{ Name = "message", Type = "string", Nilable = false },
				{ Name = "sender", Type = "string", Nilable = false },
				{ Name = "language", Type = "string", Nilable = false },
				{ Name = "channelString", Type = "string", Nilable = false },
				{ Name = "target", Type = "string", Nilable = false },
				{ Name = "flags", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "channelNumber", Type = "number", Nilable = false },
				{ Name = "channelName", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "counter", Type = "number", Nilable = false },
			},
		},
		{
			Name = "PlayerMoney",
			Type = "Event",
			LiteralName = "PLAYER_MONEY",
		},
		{
			Name = "PlayerTradeMoney",
			Type = "Event",
			LiteralName = "PLAYER_TRADE_MONEY",
		},
		{
			Name = "SendMailMoneyChanged",
			Type = "Event",
			LiteralName = "SEND_MAIL_MONEY_CHANGED",
		},
		{
			Name = "TradeMoneyChanged",
			Type = "Event",
			LiteralName = "TRADE_MONEY_CHANGED",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Money);
