local Chat =
{
	Name = "Chat",
	Type = "System",
	Namespace = "Chat",

	Functions =
	{
		{
			Name = "AddChatWindowChannel",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "channel", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "zoneChannel", Type = "number", Nilable = false },
			},
		},
		{
			Name = "AddChatWindowMessages",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "messageGroup", Type = "string", Nilable = false },
			},

		},
		{
			Name = "CanComplainChat",
			Type = "Function",

			Arguments =
			{
				{ Name = "lineID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "canComplain", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ChangeChatColor",
			Type = "Function",

			Arguments =
			{
				{ Name = "messageType", Type = "string", Nilable = false },
				{ Name = "red", Type = "number", Nilable = false },
				{ Name = "green", Type = "number", Nilable = false },
				{ Name = "blue", Type = "number", Nilable = false },
			},

		},
		{
			Name = "ChatFrame_AddMessageEventFilter",
			Type = "Function",

			Arguments =
			{
				{ Name = "event", Type = "string", Nilable = false },
				{ Name = "filter", Type = "function", Nilable = false },
			},

		},
		{
			Name = "ChatFrame_GetMessageEventFilters",
			Type = "Function",

			Arguments =
			{
				{ Name = "event", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "filterTable", Type = "table", Nilable = false },
			},
		},
		{
			Name = "ChatFrame_RemoveMessageEventFilter",
			Type = "Function",

			Arguments =
			{
				{ Name = "event", Type = "string", Nilable = false },
				{ Name = "filter", Type = "function", Nilable = false },
			},

		},
		{
			Name = "ComplainChat",
			Type = "Function",

			Arguments =
			{
				{ Name = "lineID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "canComplain", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "DoEmote",
			Type = "Function",

			Arguments =
			{
				{ Name = "emote", Type = "string", Nilable = false },
				{ Name = "target", Type = "string", Nilable = false },
				{ Name = "hold", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "GetChatTypeIndex",
			Type = "Function",

			Arguments =
			{
				{ Name = "messageGroup", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetChatWindowChannels",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "channelName", Type = "string", Nilable = false },
				{ Name = "channelId", Type = "number", Nilable = false },
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetChatWindowInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "fontSize", Type = "number", Nilable = false },
				{ Name = "r", Type = "number", Nilable = false },
				{ Name = "g", Type = "number", Nilable = false },
				{ Name = "b", Type = "number", Nilable = false },
				{ Name = "alpha", Type = "number", Nilable = false },
				{ Name = "shown", Type = "number", Nilable = false },
				{ Name = "locked", Type = "number", Nilable = false },
				{ Name = "docked", Type = "number", Nilable = false },
				{ Name = "uninteractable", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetChatWindowMessages",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetDefaultLanguage",
			Type = "Function",

			Returns =
			{
				{ Name = "language", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetLanguageByIndex",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "language", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetNumLanguages",
			Type = "Function",

			Returns =
			{
				{ Name = "languages", Type = "number", Nilable = false },
			},
		},
		{
			Name = "LoggingChat",
			Type = "Function",

			Arguments =
			{
				{ Name = "toggle", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "isLogging", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "LoggingCombat",
			Type = "Function",

			Arguments =
			{
				{ Name = "toggle", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "isLogging", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "RandomRoll",
			Type = "Function",

			Arguments =
			{
				{ Name = "min", Type = "string", Nilable = false },
				{ Name = "max", Type = "string", Nilable = false },
			},

		},
		{
			Name = "RemoveChatWindowChannel",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "channel", Type = "string", Nilable = false },
			},

		},
		{
			Name = "RemoveChatWindowMessages",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "messageGroup", Type = "string", Nilable = false },
			},

		},
		{
			Name = "ResetChatColors",
			Type = "Function",

		},
		{
			Name = "ResetChatWindows",
			Type = "Function",

		},
		{
			Name = "SendChatMessage",
			Type = "Function",

			Arguments =
			{
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "chatType", Type = "string", Nilable = false },
				{ Name = "language", Type = "string", Nilable = false },
				{ Name = "channel", Type = "string", Nilable = true },
			},

		},
		{
			Name = "SetChatWindowAlpha",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "alpha", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetChatWindowColor",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "r", Type = "number", Nilable = false },
				{ Name = "g", Type = "number", Nilable = false },
				{ Name = "b", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetChatWindowDocked",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "docked", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "SetChatWindowLocked",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "locked", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "SetChatWindowName",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SetChatWindowShown",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "shown", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "SetChatWindowSize",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "size", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetChatWindowUninteractable",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "setUninteractable", Type = "bool", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "BnChatWhisperUndeliverable",
			Type = "Event",
			LiteralName = "BN_CHAT_WHISPER_UNDELIVERABLE",
		},
		{
			Name = "ChatMsgAddon",
			Type = "Event",
			LiteralName = "CHAT_MSG_ADDON",
			Payload =
			{
				{ Name = "prefix", Type = "string", Nilable = false },
				{ Name = "message", Type = "string", Nilable = false },
				{ Name = "channel", Type = "string", Nilable = false },
				{ Name = "sender", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ChatMsgAfk",
			Type = "Event",
			LiteralName = "CHAT_MSG_AFK",
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
				{ Name = "senderGUID", Type = "WOWGUID", Nilable = false },
			},
		},
		{
			Name = "ChatMsgBattleground",
			Type = "Event",
			LiteralName = "CHAT_MSG_BATTLEGROUND",
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
			Name = "ChatMsgBattlegroundLeader",
			Type = "Event",
			LiteralName = "CHAT_MSG_BATTLEGROUND_LEADER",
			Payload =
			{
				{ Name = "message", Type = "string", Nilable = false },
				{ Name = "author", Type = "string", Nilable = false },
				{ Name = "language", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ChatMsgBgSystemAlliance",
			Type = "Event",
			LiteralName = "CHAT_MSG_BG_SYSTEM_ALLIANCE",
			Payload =
			{
				{ Name = "message", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ChatMsgBgSystemHorde",
			Type = "Event",
			LiteralName = "CHAT_MSG_BG_SYSTEM_HORDE",
			Payload =
			{
				{ Name = "message", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ChatMsgBgSystemNeutral",
			Type = "Event",
			LiteralName = "CHAT_MSG_BG_SYSTEM_NEUTRAL",
			Payload =
			{
				{ Name = "message", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ChatMsgBnConversation",
			Type = "Event",
			LiteralName = "CHAT_MSG_BN_CONVERSATION",
			Payload =
			{
				{ Name = "message", Type = "string", Nilable = false },
				{ Name = "sender", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "channelString", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "channelNumber", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "counter", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "presenceID", Type = "presenceID", Nilable = false },
				{ Name = "unknown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ChatMsgBnConversationList",
			Type = "Event",
			LiteralName = "CHAT_MSG_BN_CONVERSATION_LIST",
		},
		{
			Name = "ChatMsgBnConversationNotice",
			Type = "Event",
			LiteralName = "CHAT_MSG_BN_CONVERSATION_NOTICE",
			Payload =
			{
				{ Name = "message/status", Type = "string", Nilable = false },
				{ Name = "sender", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "channelString", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "channelNumber", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "counter", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "presenceID", Type = "presenceID", Nilable = false },
				{ Name = "unknown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ChatMsgBnInlineToastAlert",
			Type = "Event",
			LiteralName = "CHAT_MSG_BN_INLINE_TOAST_ALERT",
		},
		{
			Name = "ChatMsgBnInlineToastBroadcast",
			Type = "Event",
			LiteralName = "CHAT_MSG_BN_INLINE_TOAST_BROADCAST",
			Payload =
			{
				{ Name = "message", Type = "string", Nilable = false },
				{ Name = "sender", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "counter", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "presenceID", Type = "presenceID", Nilable = false },
				{ Name = "unknown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ChatMsgBnInlineToastBroadcastInform",
			Type = "Event",
			LiteralName = "CHAT_MSG_BN_INLINE_TOAST_BROADCAST_INFORM",
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
				{ Name = "guid", Type = "WOWGUID", Nilable = false },
			},
		},
		{
			Name = "ChatMsgBnInlineToastConversation",
			Type = "Event",
			LiteralName = "CHAT_MSG_BN_INLINE_TOAST_CONVERSATION",
		},
		{
			Name = "ChatMsgBnWhisper",
			Type = "Event",
			LiteralName = "CHAT_MSG_BN_WHISPER",
			Payload =
			{
				{ Name = "message", Type = "string", Nilable = false },
				{ Name = "sender", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "counter", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "presenceID", Type = "presenceID", Nilable = false },
				{ Name = "unknown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ChatMsgBnWhisperInform",
			Type = "Event",
			LiteralName = "CHAT_MSG_BN_WHISPER_INFORM",
		},
		{
			Name = "ChatMsgDnd",
			Type = "Event",
			LiteralName = "CHAT_MSG_DND",
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
			Name = "ChatMsgEmote",
			Type = "Event",
			LiteralName = "CHAT_MSG_EMOTE",
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
			Name = "ChatMsgFiltered",
			Type = "Event",
			LiteralName = "CHAT_MSG_FILTERED",
		},
		{
			Name = "ChatMsgIgnored",
			Type = "Event",
			LiteralName = "CHAT_MSG_IGNORED",
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
			Name = "ChatMsgLoot",
			Type = "Event",
			LiteralName = "CHAT_MSG_LOOT",
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
			Name = "ChatMsgMonsterEmote",
			Type = "Event",
			LiteralName = "CHAT_MSG_MONSTER_EMOTE",
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
			Name = "ChatMsgMonsterSay",
			Type = "Event",
			LiteralName = "CHAT_MSG_MONSTER_SAY",
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
			Name = "ChatMsgMonsterWhisper",
			Type = "Event",
			LiteralName = "CHAT_MSG_MONSTER_WHISPER",
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
			Name = "ChatMsgMonsterYell",
			Type = "Event",
			LiteralName = "CHAT_MSG_MONSTER_YELL",
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
			Name = "ChatMsgOfficer",
			Type = "Event",
			LiteralName = "CHAT_MSG_OFFICER",
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
			Name = "ChatMsgOpening",
			Type = "Event",
			LiteralName = "CHAT_MSG_OPENING",
		},
		{
			Name = "ChatMsgPetInfo",
			Type = "Event",
			LiteralName = "CHAT_MSG_PET_INFO",
		},
		{
			Name = "ChatMsgRaid",
			Type = "Event",
			LiteralName = "CHAT_MSG_RAID",
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
			Name = "ChatMsgRaidBossEmote",
			Type = "Event",
			LiteralName = "CHAT_MSG_RAID_BOSS_EMOTE",
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
			Name = "ChatMsgRaidBossWhisper",
			Type = "Event",
			LiteralName = "CHAT_MSG_RAID_BOSS_WHISPER",
		},
		{
			Name = "ChatMsgRaidLeader",
			Type = "Event",
			LiteralName = "CHAT_MSG_RAID_LEADER",
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
			Name = "ChatMsgRaidWarning",
			Type = "Event",
			LiteralName = "CHAT_MSG_RAID_WARNING",
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
			Name = "ChatMsgRestricted",
			Type = "Event",
			LiteralName = "CHAT_MSG_RESTRICTED",
		},
		{
			Name = "ChatMsgSay",
			Type = "Event",
			LiteralName = "CHAT_MSG_SAY",
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
			Name = "ChatMsgSystem",
			Type = "Event",
			LiteralName = "CHAT_MSG_SYSTEM",
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
			Name = "ChatMsgTargeticons",
			Type = "Event",
			LiteralName = "CHAT_MSG_TARGETICONS",
		},
		{
			Name = "ChatMsgTextEmote",
			Type = "Event",
			LiteralName = "CHAT_MSG_TEXT_EMOTE",
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
			Name = "ChatMsgWhisper",
			Type = "Event",
			LiteralName = "CHAT_MSG_WHISPER",
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
				{ Name = "guid", Type = "WOWGUID", Nilable = false },
			},
		},
		{
			Name = "ChatMsgWhisperInform",
			Type = "Event",
			LiteralName = "CHAT_MSG_WHISPER_INFORM",
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
			Name = "ChatMsgYell",
			Type = "Event",
			LiteralName = "CHAT_MSG_YELL",
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
			Name = "ExecuteChatLine",
			Type = "Event",
			LiteralName = "EXECUTE_CHAT_LINE",
		},
		{
			Name = "UpdateChatColor",
			Type = "Event",
			LiteralName = "UPDATE_CHAT_COLOR",
			Payload =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "red", Type = "number", Nilable = false },
				{ Name = "green", Type = "number", Nilable = false },
				{ Name = "blue", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UpdateChatColorNameByClass",
			Type = "Event",
			LiteralName = "UPDATE_CHAT_COLOR_NAME_BY_CLASS",
		},
		{
			Name = "UpdateChatWindows",
			Type = "Event",
			LiteralName = "UPDATE_CHAT_WINDOWS",
		},
		{
			Name = "UpdateFloatingChatWindows",
			Type = "Event",
			LiteralName = "UPDATE_FLOATING_CHAT_WINDOWS",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Chat);
