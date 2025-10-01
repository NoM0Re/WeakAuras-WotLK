local Currency =
{
	Name = "Currency",
	Type = "System",
	Namespace = "Currency",

	Functions =
	{
		{
			Name = "ExpandCurrencyList",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "shouldExpand", Type = "number", Nilable = false },
			},

		},
		{
			Name = "GetBackpackCurrencyInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "extraCurrencyType", Type = "number", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "itemID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetContainerItemPurchaseInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
				{ Name = "IsEquipped", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "money", Type = "number", Nilable = false },
				{ Name = "itemCount", Type = "number", Nilable = false },
				{ Name = "refundSec", Type = "number", Nilable = false },
				{ Name = "currecycount", Type = "number", Nilable = false },
				{ Name = "hasEnchants", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetContainerItemPurchaseItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "quantity", Type = "number", Nilable = false },
				{ Name = "link", Type = "itemLink", Nilable = false },
			},
		},
		{
			Name = "GetCurrencyListInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "isHeader", Type = "bool", Nilable = false },
				{ Name = "isExpanded", Type = "bool", Nilable = false },
				{ Name = "isUnused", Type = "bool", Nilable = false },
				{ Name = "isWatched", Type = "bool", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "extraCurrencyType", Type = "number", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "itemID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCurrencyListSize",
			Type = "Function",

			Returns =
			{
				{ Name = "numEntries", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetHolidayBGHonorCurrencyBonuses",
			Type = "Function",

			Returns =
			{
				{ Name = "unk", Type = "bool", Nilable = false },
				{ Name = "honorWinReward", Type = "number", Nilable = false },
				{ Name = "arenaWinReward", Type = "number", Nilable = false },
				{ Name = "honorLossReward", Type = "number", Nilable = false },
				{ Name = "arenaLossReward", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetHonorCurrency",
			Type = "Function",

			Returns =
			{
				{ Name = "honorPoints", Type = "number", Nilable = false },
				{ Name = "maxHonor", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetMaxArenaCurrency",
			Type = "Function",

			Returns =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "SetCurrencyBackpack",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "watch", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetCurrencyUnused",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "makeUnused", Type = "number", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "CurrencyDisplayUpdate",
			Type = "Event",
			LiteralName = "CURRENCY_DISPLAY_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Currency);
