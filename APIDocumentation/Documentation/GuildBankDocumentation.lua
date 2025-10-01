local GuildBank =
{
	Name = "Guild Bank",
	Type = "System",
	Namespace = "Guild Bank",

	Functions =
	{
		{
			Name = "AutoStoreGuildBankItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "BuyGuildBankTab",
			Type = "Function",

		},
		{
			Name = "CanEditGuildTabInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "canEdit", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanGuildBankRepair",
			Type = "Function",

			Returns =
			{
				{ Name = "canRepair", Type = "bool", Nilable = false },
			},
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
			Name = "CloseGuildBankFrame",
			Type = "Function",

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
			Name = "GetCurrentGuildBankTab",
			Type = "Function",

			Arguments =
			{
				{ Name = "currentTab", Type = "number", Nilable = false },
			},

		},
		{
			Name = "GetGuildBankItemInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "locked", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetGuildBankItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "item", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetGuildBankMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "guildBankMoney", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetGuildBankMoneyTransaction",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "hour", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetGuildBankTabCost",
			Type = "Function",

			Returns =
			{
				{ Name = "tabCost", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetGuildBankTabInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "isViewable", Type = "bool", Nilable = false },
				{ Name = "canDeposit", Type = "bool", Nilable = false },
				{ Name = "numWithdrawals", Type = "number", Nilable = false },
				{ Name = "remainingWithdrawals", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetGuildBankTabPermissions",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "canView", Type = "bool", Nilable = false },
				{ Name = "canDeposit", Type = "bool", Nilable = false },
				{ Name = "canUpdateText", Type = "bool", Nilable = false },
				{ Name = "numWithdrawls", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetGuildBankText",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetGuildBankTransaction",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "itemLink", Type = "hyperlink", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "tab1", Type = "number", Nilable = false },
				{ Name = "tab2", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "hour", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetGuildBankWithdrawLimit",
			Type = "Function",

			Returns =
			{
				{ Name = "goldWithdrawLimit", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetGuildBankWithdrawMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "withdrawLimit", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumGuildBankMoneyTransactions",
			Type = "Function",

			Returns =
			{
				{ Name = "numTransactions", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumGuildBankTabs",
			Type = "Function",

			Returns =
			{
				{ Name = "numTabs", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumGuildBankTransactions",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "numTransactions", Type = "number", Nilable = false },
			},
		},
		{
			Name = "PickupGuildBankItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
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
			Name = "QueryGuildBankLog",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
			},

		},
		{
			Name = "QueryGuildBankTab",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
			},

		},
		{
			Name = "QueryGuildBankText",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetCurrentGuildBankTab",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetGuildBankTabPermissions",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
				{ Name = "permission", Type = "number", Nilable = false },
				{ Name = "enabled", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "SetGuildBankText",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
				{ Name = "text", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SplitGuildBankItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
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
			Name = "GuildbankbagslotsChanged",
			Type = "Event",
			LiteralName = "GUILDBANKBAGSLOTS_CHANGED",
		},
		{
			Name = "GuildbankframeClosed",
			Type = "Event",
			LiteralName = "GUILDBANKFRAME_CLOSED",
		},
		{
			Name = "GuildbankframeOpened",
			Type = "Event",
			LiteralName = "GUILDBANKFRAME_OPENED",
		},
		{
			Name = "GuildbanklogUpdate",
			Type = "Event",
			LiteralName = "GUILDBANKLOG_UPDATE",
		},
		{
			Name = "GuildbankItemLockChanged",
			Type = "Event",
			LiteralName = "GUILDBANK_ITEM_LOCK_CHANGED",
		},
		{
			Name = "GuildbankTextChanged",
			Type = "Event",
			LiteralName = "GUILDBANK_TEXT_CHANGED",
		},
		{
			Name = "GuildbankUpdateMoney",
			Type = "Event",
			LiteralName = "GUILDBANK_UPDATE_MONEY",
		},
		{
			Name = "GuildbankUpdateTabs",
			Type = "Event",
			LiteralName = "GUILDBANK_UPDATE_TABS",
		},
		{
			Name = "GuildbankUpdateText",
			Type = "Event",
			LiteralName = "GUILDBANK_UPDATE_TEXT",
		},
		{
			Name = "GuildbankUpdateWithdrawmoney",
			Type = "Event",
			LiteralName = "GUILDBANK_UPDATE_WITHDRAWMONEY",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(GuildBank);
