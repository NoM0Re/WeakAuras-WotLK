local Skill =
{
	Name = "Skill",
	Type = "System",
	Namespace = "Skill",

	Functions =
	{
		{
			Name = "AbandonSkill",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "ExpandSkillHeader",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "GetNumSkillLines",
			Type = "Function",

			Returns =
			{
				{ Name = "numSkills", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSkillLineInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "skillName", Type = "string", Nilable = false },
				{ Name = "header", Type = "bool", Nilable = false },
				{ Name = "isExpanded", Type = "bool", Nilable = false },
				{ Name = "skillRank", Type = "number", Nilable = false },
				{ Name = "numTempPoints", Type = "number", Nilable = false },
				{ Name = "skillModifier", Type = "number", Nilable = false },
				{ Name = "skillMaxRank", Type = "number", Nilable = false },
				{ Name = "isAbandonable", Type = "bool", Nilable = false },
				{ Name = "stepCost", Type = "number", Nilable = false },
				{ Name = "rankCost", Type = "number", Nilable = false },
				{ Name = "minLevel", Type = "number", Nilable = false },
				{ Name = "skillCostType", Type = "number", Nilable = false },
				{ Name = "skillDescription", Type = "string", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "ChatMsgSkill",
			Type = "Event",
			LiteralName = "CHAT_MSG_SKILL",
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
			Name = "SkillLinesChanged",
			Type = "Event",
			LiteralName = "SKILL_LINES_CHANGED",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Skill);
