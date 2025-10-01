local Party =
{
	Name = "Party",
	Type = "System",
	Namespace = "Party",

	Functions =
	{
		{
			Name = "AcceptGroup",
			Type = "Function",

		},
		{
			Name = "ClearPartyAssignment",
			Type = "Function",

			Arguments =
			{
				{ Name = "assignment", Type = "string", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "exactMatch", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "ConfirmReadyCheck",
			Type = "Function",

			Arguments =
			{
				{ Name = "ready", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "ConvertToRaid",
			Type = "Function",

		},
		{
			Name = "DeclineGroup",
			Type = "Function",

		},
		{
			Name = "DoReadyCheck",
			Type = "Function",

		},
		{
			Name = "GetNumPartyMembers",
			Type = "Function",

			Returns =
			{
				{ Name = "numPartyMembers", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPartyAssignment",
			Type = "Function",

			Arguments =
			{
				{ Name = "assignment", Type = "string", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "exactMatch", Type = "bool", Nilable = true },
			},

			Returns =
			{
				{ Name = "isAssigned", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetPartyLeaderIndex",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetPartyMember",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "hasMember", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetReadyCheckStatus",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "status", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetReadyCheckTimeLeft",
			Type = "Function",

			Returns =
			{
				{ Name = "timeLeft", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetRealNumPartyMembers",
			Type = "Function",

			Returns =
			{
				{ Name = "numMembers", Type = "number", Nilable = false },
			},
		},
		{
			Name = "InviteUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "IsPartyLeader",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isLeader", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsRealPartyLeader",
			Type = "Function",

			Returns =
			{
				{ Name = "isLeader", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "LeaveParty",
			Type = "Function",

		},
		{
			Name = "PromoteToLeader",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "exactMatch", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "SetPartyAssignment",
			Type = "Function",

			Arguments =
			{
				{ Name = "assignment", Type = "string", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "exactMatch", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "UninviteUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "UnitInParty",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "inParty", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsPartyLeader",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "leader", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitPlayerOrPetInParty",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "inParty", Type = "bool", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "ChatMsgMonsterParty",
			Type = "Event",
			LiteralName = "CHAT_MSG_MONSTER_PARTY",
		},
		{
			Name = "ChatMsgParty",
			Type = "Event",
			LiteralName = "CHAT_MSG_PARTY",
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
			Name = "ChatMsgPartyLeader",
			Type = "Event",
			LiteralName = "CHAT_MSG_PARTY_LEADER",
		},
		{
			Name = "PartyConvertedToRaid",
			Type = "Event",
			LiteralName = "PARTY_CONVERTED_TO_RAID",
		},
		{
			Name = "PartyInviteCancel",
			Type = "Event",
			LiteralName = "PARTY_INVITE_CANCEL",
		},
		{
			Name = "PartyInviteRequest",
			Type = "Event",
			LiteralName = "PARTY_INVITE_REQUEST",
			Payload =
			{
				{ Name = "sender", Type = "string", Nilable = false },
			},
		},
		{
			Name = "PartyLeaderChanged",
			Type = "Event",
			LiteralName = "PARTY_LEADER_CHANGED",
		},
		{
			Name = "PartyLfgRestricted",
			Type = "Event",
			LiteralName = "PARTY_LFG_RESTRICTED",
		},
		{
			Name = "PartyLootMethodChanged",
			Type = "Event",
			LiteralName = "PARTY_LOOT_METHOD_CHANGED",
		},
		{
			Name = "PartyMembersChanged",
			Type = "Event",
			LiteralName = "PARTY_MEMBERS_CHANGED",
		},
		{
			Name = "PartyMemberDisable",
			Type = "Event",
			LiteralName = "PARTY_MEMBER_DISABLE",
			Payload =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},
		},
		{
			Name = "PartyMemberEnable",
			Type = "Event",
			LiteralName = "PARTY_MEMBER_ENABLE",
			Payload =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},
		},
		{
			Name = "ReadyCheck",
			Type = "Event",
			LiteralName = "READY_CHECK",
			Payload =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ReadyCheckConfirm",
			Type = "Event",
			LiteralName = "READY_CHECK_CONFIRM",
			Payload =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "response", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ReadyCheckFinished",
			Type = "Event",
			LiteralName = "READY_CHECK_FINISHED",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Party);
