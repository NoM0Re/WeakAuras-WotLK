local Tradeskill =
{
	Name = "Tradeskill",
	Type = "System",
	Namespace = "Tradeskill",

	Functions =
	{
		{
			Name = "CloseTradeSkill",
			Type = "Function",

		},
		{
			Name = "CollapseTradeSkillSubClass",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "DoTradeSkill",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "repeat", Type = "number", Nilable = true },
			},

		},
		{
			Name = "ExpandTradeSkillSubClass",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "GetFirstTradeSkill",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetNumTradeSkills",
			Type = "Function",

			Returns =
			{
				{ Name = "numSkills", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "cooldown", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillDescription",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "description", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillIcon",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "texturePath", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "skillName", Type = "string", Nilable = false },
				{ Name = "skillType", Type = "string", Nilable = false },
				{ Name = "numAvailable", Type = "number", Nilable = false },
				{ Name = "isExpanded", Type = "bool", Nilable = false },
				{ Name = "serviceType", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillInvSlotFilter",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "enabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillInvSlots",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillItemLevelFilter",
			Type = "Function",

			Returns =
			{
				{ Name = "minLevel", Type = "number", Nilable = false },
				{ Name = "maxLevel", Type = "number", Nilable = false },
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
			Name = "GetTradeSkillItemNameFilter",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillLine",
			Type = "Function",

			Returns =
			{
				{ Name = "tradeskillName", Type = "string", Nilable = false },
				{ Name = "rank", Type = "number", Nilable = false },
				{ Name = "maxLevel", Type = "number", Nilable = false },
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
			Name = "GetTradeSkillNumMade",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "minMade", Type = "number", Nilable = false },
				{ Name = "maxMade", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillNumReagents",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "numReagents", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillReagentInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "skillIndex", Type = "luaIndex", Nilable = false },
				{ Name = "reagentIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "reagentName", Type = "string", Nilable = false },
				{ Name = "reagentTexture", Type = "string", Nilable = false },
				{ Name = "reagentCount", Type = "number", Nilable = false },
				{ Name = "playerReagentCount", Type = "number", Nilable = false },
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
			Name = "GetTradeSkillSelectionIndex",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillSubClassFilter",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "enabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillSubClasses",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetTradeSkillTools",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "toolName", Type = "string", Nilable = false },
				{ Name = "hasTool", Type = "bool", Nilable = false },
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetTradeskillRepeatCount",
			Type = "Function",

			Returns =
			{
				{ Name = "repeatCount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "IsTradeSkillLinked",
			Type = "Function",

			Returns =
			{
				{ Name = "isLinked", Type = "bool", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "SelectTradeSkill",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetTradeSkillInvSlotFilter",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "enable", Type = "number", Nilable = false },
				{ Name = "exclusive", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "SetTradeSkillItemLevelFilter",
			Type = "Function",

			Arguments =
			{
				{ Name = "minLevel", Type = "number", Nilable = false },
				{ Name = "maxLevel", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetTradeSkillItemNameFilter",
			Type = "Function",

			Arguments =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SetTradeSkillSubClassFilter",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "enable", Type = "number", Nilable = false },
				{ Name = "exclusive", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "StopTradeSkillRepeat",
			Type = "Function",

		},
		{
			Name = "TradeSkillOnlyShowMakeable",
			Type = "Function",

			Arguments =
			{
				{ Name = "filter", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "TradeSkillOnlyShowSkillUps",
			Type = "Function",

			Arguments =
			{
				{ Name = "filter", Type = "bool", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "ChatMsgTradeskills",
			Type = "Event",
			LiteralName = "CHAT_MSG_TRADESKILLS",
		},
		{
			Name = "TradeSkillClose",
			Type = "Event",
			LiteralName = "TRADE_SKILL_CLOSE",
		},
		{
			Name = "TradeSkillFilterUpdate",
			Type = "Event",
			LiteralName = "TRADE_SKILL_FILTER_UPDATE",
		},
		{
			Name = "TradeSkillShow",
			Type = "Event",
			LiteralName = "TRADE_SKILL_SHOW",
		},
		{
			Name = "TradeSkillUpdate",
			Type = "Event",
			LiteralName = "TRADE_SKILL_UPDATE",
		},
		{
			Name = "UpdateTradeskillRecast",
			Type = "Event",
			LiteralName = "UPDATE_TRADESKILL_RECAST",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Tradeskill);
