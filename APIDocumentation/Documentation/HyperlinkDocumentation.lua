local Hyperlink =
{
	Name = "Hyperlink",
	Type = "System",
	Namespace = "Hyperlink",

	Functions =
	{
		{
			Name = "GetAchievementLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetAuctionItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetBuybackItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetContainerItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetCursorInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "data", Type = "number", Nilable = false },
				{ Name = "subType", Type = "string", Nilable = false },
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
			Name = "GetGlyphLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "socket", Type = "number", Nilable = false },
				{ Name = "talentGroup", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
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
			Name = "GetInboxItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
				{ Name = "attachmentIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "itemlink", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetInventoryItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
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
			Name = "GetLootRollItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetLootSlotLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetMacroItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetMerchantItemLink",
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
			Name = "GetQuestItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemType", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetQuestLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "questIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemType", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "GetSendMailItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "itemlink", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetSpellLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "id", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
				{ Name = "tradeLink", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTalentLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "tabIndex", Type = "luaIndex", Nilable = false },
				{ Name = "talentIndex", Type = "luaIndex", Nilable = false },
				{ Name = "inspect", Type = "bool", Nilable = false },
				{ Name = "pet", Type = "bool", Nilable = false },
				{ Name = "talentGroup", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
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
			Name = "GetTradeSkillItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillListLink",
			Type = "Function",

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillReagentItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "skillIndex", Type = "luaIndex", Nilable = false },
				{ Name = "reagentIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillRecipeLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "string", Nilable = false },
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
			Name = "GetTrainerServiceItemLink",
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
	},

	Events =
	{
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Hyperlink);
