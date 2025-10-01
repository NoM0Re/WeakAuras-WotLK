local Combat =
{
	Name = "Combat",
	Type = "System",
	Namespace = "Combat",

	Functions =
	{
		{
			Name = "StartAttack",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "StopAttack",
			Type = "Function",

		},
		{
			Name = "UnitAffectingCombat",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "inCombat", Type = "bool", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "ChatMsgCombatHonorGain",
			Type = "Event",
			LiteralName = "CHAT_MSG_COMBAT_HONOR_GAIN",
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
			Name = "ChatMsgCombatMiscInfo",
			Type = "Event",
			LiteralName = "CHAT_MSG_COMBAT_MISC_INFO",
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
			Name = "ChatMsgCombatXpGain",
			Type = "Event",
			LiteralName = "CHAT_MSG_COMBAT_XP_GAIN",
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
			Name = "CombatRatingUpdate",
			Type = "Event",
			LiteralName = "COMBAT_RATING_UPDATE",
		},
		{
			Name = "CombatTextUpdate",
			Type = "Event",
			LiteralName = "COMBAT_TEXT_UPDATE",
			Payload =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "desc1", Type = "varies", Nilable = false },
				{ Name = "desc2", Type = "varies", Nilable = false },
			},
		},
		{
			Name = "PlayerEnterCombat",
			Type = "Event",
			LiteralName = "PLAYER_ENTER_COMBAT",
		},
		{
			Name = "PlayerLeaveCombat",
			Type = "Event",
			LiteralName = "PLAYER_LEAVE_COMBAT",
		},
		{
			Name = "UnitCombat",
			Type = "Event",
			LiteralName = "UNIT_COMBAT",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
				{ Name = "action", Type = "string", Nilable = false },
				{ Name = "descriptor", Type = "string", Nilable = false },
				{ Name = "damage", Type = "number", Nilable = false },
				{ Name = "damageType", Type = "number", Nilable = false },
			},
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Combat);
