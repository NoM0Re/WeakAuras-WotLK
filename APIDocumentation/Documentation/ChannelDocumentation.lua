local Channel =
{
	Name = "Channel",
	Type = "System",
	Namespace = "Channel",

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
			Name = "ChannelBan",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = false },
				{ Name = "fullname", Type = "string", Nilable = false },
			},

		},
		{
			Name = "ChannelInvite",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "ChannelKick",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = false },
				{ Name = "fullname", Type = "string", Nilable = false },
			},

		},
		{
			Name = "ChannelModerator",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = false },
				{ Name = "fullname", Type = "string", Nilable = false },
			},

		},
		{
			Name = "ChannelMute",
			Type = "Function",

			Arguments =
			{
				{ Name = "channelName", Type = "string", Nilable = true },
				{ Name = "channelId", Type = "number", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ChannelSilenceAll",
			Type = "Function",

			Arguments =
			{
				{ Name = "channelName", Type = "string", Nilable = true },
				{ Name = "channelId", Type = "number", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ChannelSilenceVoice",
			Type = "Function",

			Arguments =
			{
				{ Name = "channelName", Type = "string", Nilable = true },
				{ Name = "channelId", Type = "number", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ChannelToggleAnnouncements",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = false },
			},

		},
		{
			Name = "ChannelUnSilenceAll",
			Type = "Function",

			Arguments =
			{
				{ Name = "channelName", Type = "string", Nilable = true },
				{ Name = "channelId", Type = "number", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ChannelUnSilenceVoice",
			Type = "Function",

			Arguments =
			{
				{ Name = "channelName", Type = "string", Nilable = true },
				{ Name = "channelId", Type = "number", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ChannelUnban",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = false },
				{ Name = "fullname", Type = "string", Nilable = false },
			},

		},
		{
			Name = "ChannelUnmoderator",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = false },
				{ Name = "fullname", Type = "string", Nilable = false },
			},

		},
		{
			Name = "ChannelUnmute",
			Type = "Function",

			Arguments =
			{
				{ Name = "channelName", Type = "string", Nilable = true },
				{ Name = "channelId", Type = "number", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ChannelVoiceOff",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = true },
				{ Name = "channelIndex", Type = "luaIndex", Nilable = true },
			},

		},
		{
			Name = "ChannelVoiceOn",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = true },
				{ Name = "channelIndex", Type = "luaIndex", Nilable = true },
			},

		},
		{
			Name = "ClearChannelWatch",
			Type = "Function",

		},
		{
			Name = "CollapseChannelHeader",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "DeclineInvite",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = false },
			},

		},
		{
			Name = "DisplayChannelOwner",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = true },
				{ Name = "channelIndex", Type = "luaIndex", Nilable = true },
			},

		},
		{
			Name = "DisplayChannelVoiceOff",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "DisplayChannelVoiceOn",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "EnumerateServerChannels",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "ExpandChannelHeader",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "GetActiveVoiceChannel",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetChannelDisplayInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "header", Type = "1nil", Nilable = false },
				{ Name = "collapsed", Type = "1nil", Nilable = false },
				{ Name = "channelNumber", Type = "number", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "active", Type = "1nil", Nilable = false },
				{ Name = "category", Type = "string", Nilable = false },
				{ Name = "voiceEnabled", Type = "1nil", Nilable = false },
				{ Name = "voiceActive", Type = "1nil", Nilable = false },
			},
		},
		{
			Name = "GetChannelList",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "channel", Type = "string", Nilable = false },
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetChannelName",
			Type = "Function",

			Arguments =
			{
				{ Name = "channelIndex", Type = "luaIndex", Nilable = true },
				{ Name = "channelName", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "channel", Type = "number", Nilable = false },
				{ Name = "channelName", Type = "string", Nilable = false },
				{ Name = "instanceID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetChannelRosterInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "rosterIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "owner", Type = "bool", Nilable = false },
				{ Name = "moderator", Type = "bool", Nilable = false },
				{ Name = "muted", Type = "bool", Nilable = false },
				{ Name = "active", Type = "bool", Nilable = false },
				{ Name = "enabled", Type = "bool", Nilable = false },
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
			Name = "GetNumChannelMembers",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "numMembers", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumDisplayChannels",
			Type = "Function",

			Returns =
			{
				{ Name = "channelCount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSelectedDisplayChannel",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "IsDisplayChannelModerator",
			Type = "Function",

			Returns =
			{
				{ Name = "isModerator", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsDisplayChannelOwner",
			Type = "Function",

			Returns =
			{
				{ Name = "isOwner", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsSilenced",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "channel", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "isSilenced", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "JoinChannelByName",
			Type = "Function",

		},
		{
			Name = "JoinPermanentChannel",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "password", Type = "string", Nilable = false },
				{ Name = "chatFrameIndex", Type = "luaIndex", Nilable = false },
				{ Name = "enableVoice", Type = "bool", Nilable = true },
			},

			Returns =
			{
				{ Name = "zoneChannel", Type = "number", Nilable = false },
				{ Name = "channelName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "JoinTemporaryChannel",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = false },
			},

		},
		{
			Name = "LeaveChannelByName",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "ListChannelByName",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = true },
				{ Name = "channelIndex", Type = "luaIndex", Nilable = true },
			},

		},
		{
			Name = "ListChannels",
			Type = "Function",

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
			Name = "SetActiveVoiceChannel",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetActiveVoiceChannelBySessionID",
			Type = "Function",

			Arguments =
			{
				{ Name = "session", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetChannelOwner",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = false },
				{ Name = "fullname", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SetChannelPassword",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = false },
				{ Name = "password", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SetSelectedDisplayChannel",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SilenceMember",
			Type = "Function",

		},
		{
			Name = "UnSilenceMember",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "BnChatChannelClosed",
			Type = "Event",
			LiteralName = "BN_CHAT_CHANNEL_CLOSED",
		},
		{
			Name = "BnChatChannelCreateFailed",
			Type = "Event",
			LiteralName = "BN_CHAT_CHANNEL_CREATE_FAILED",
		},
		{
			Name = "BnChatChannelCreateSucceeded",
			Type = "Event",
			LiteralName = "BN_CHAT_CHANNEL_CREATE_SUCCEEDED",
		},
		{
			Name = "BnChatChannelInviteFailed",
			Type = "Event",
			LiteralName = "BN_CHAT_CHANNEL_INVITE_FAILED",
		},
		{
			Name = "BnChatChannelInviteSucceeded",
			Type = "Event",
			LiteralName = "BN_CHAT_CHANNEL_INVITE_SUCCEEDED",
		},
		{
			Name = "BnChatChannelJoined",
			Type = "Event",
			LiteralName = "BN_CHAT_CHANNEL_JOINED",
		},
		{
			Name = "BnChatChannelLeft",
			Type = "Event",
			LiteralName = "BN_CHAT_CHANNEL_LEFT",
		},
		{
			Name = "BnChatChannelMemberJoined",
			Type = "Event",
			LiteralName = "BN_CHAT_CHANNEL_MEMBER_JOINED",
		},
		{
			Name = "BnChatChannelMemberLeft",
			Type = "Event",
			LiteralName = "BN_CHAT_CHANNEL_MEMBER_LEFT",
		},
		{
			Name = "BnChatChannelMemberUpdated",
			Type = "Event",
			LiteralName = "BN_CHAT_CHANNEL_MEMBER_UPDATED",
		},
		{
			Name = "BnChatChannelMessageBlocked",
			Type = "Event",
			LiteralName = "BN_CHAT_CHANNEL_MESSAGE_BLOCKED",
		},
		{
			Name = "BnChatChannelMessageUndeliverable",
			Type = "Event",
			LiteralName = "BN_CHAT_CHANNEL_MESSAGE_UNDELIVERABLE",
		},
		{
			Name = "ChannelCountUpdate",
			Type = "Event",
			LiteralName = "CHANNEL_COUNT_UPDATE",
			Payload =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
			},
		},
		{
			Name = "ChannelFlagsUpdated",
			Type = "Event",
			LiteralName = "CHANNEL_FLAGS_UPDATED",
			Payload =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},
		},
		{
			Name = "ChannelInviteRequest",
			Type = "Event",
			LiteralName = "CHANNEL_INVITE_REQUEST",
			Payload =
			{
				{ Name = "channelName", Type = "string", Nilable = false },
				{ Name = "inviterName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ChannelPasswordRequest",
			Type = "Event",
			LiteralName = "CHANNEL_PASSWORD_REQUEST",
			Payload =
			{
				{ Name = "channelName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ChannelRosterUpdate",
			Type = "Event",
			LiteralName = "CHANNEL_ROSTER_UPDATE",
			Payload =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},
		},
		{
			Name = "ChannelUiUpdate",
			Type = "Event",
			LiteralName = "CHANNEL_UI_UPDATE",
		},
		{
			Name = "ChannelVoiceUpdate",
			Type = "Event",
			LiteralName = "CHANNEL_VOICE_UPDATE",
			Payload =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "enabled", Type = "bool", Nilable = false },
				{ Name = "active", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ChatMsgChannel",
			Type = "Event",
			LiteralName = "CHAT_MSG_CHANNEL",
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
			Name = "ChatMsgChannelJoin",
			Type = "Event",
			LiteralName = "CHAT_MSG_CHANNEL_JOIN",
			Payload =
			{
				{ Name = "unkown", Type = "string", Nilable = false },
				{ Name = "sender", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "channelString", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "channelNumber", Type = "number", Nilable = false },
				{ Name = "channelName", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
			},
		},
		{
			Name = "ChatMsgChannelLeave",
			Type = "Event",
			LiteralName = "CHAT_MSG_CHANNEL_LEAVE",
			Payload =
			{
				{ Name = "unkown", Type = "string", Nilable = false },
				{ Name = "sender", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "channelString", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "channelNumber", Type = "number", Nilable = false },
				{ Name = "channelName", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
			},
		},
		{
			Name = "ChatMsgChannelList",
			Type = "Event",
			LiteralName = "CHAT_MSG_CHANNEL_LIST",
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
			Name = "ChatMsgChannelNotice",
			Type = "Event",
			LiteralName = "CHAT_MSG_CHANNEL_NOTICE",
		},
		{
			Name = "ChatMsgChannelNoticeUser",
			Type = "Event",
			LiteralName = "CHAT_MSG_CHANNEL_NOTICE_USER",
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
			Name = "UnitSpellcastChannelStart",
			Type = "Event",
			LiteralName = "UNIT_SPELLCAST_CHANNEL_START",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
				{ Name = "spell", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
				{ Name = "lineID", Type = "number", Nilable = false },
				{ Name = "spellID", Type = "spellID", Nilable = false },
			},
		},
		{
			Name = "UnitSpellcastChannelStop",
			Type = "Event",
			LiteralName = "UNIT_SPELLCAST_CHANNEL_STOP",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
				{ Name = "spell", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UnitSpellcastChannelUpdate",
			Type = "Event",
			LiteralName = "UNIT_SPELLCAST_CHANNEL_UPDATE",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
				{ Name = "spell", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
				{ Name = "lineID", Type = "number", Nilable = false },
				{ Name = "spellID", Type = "spellID", Nilable = false },
			},
		},
		{
			Name = "VoiceChannelStatusUpdate",
			Type = "Event",
			LiteralName = "VOICE_CHANNEL_STATUS_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Channel);
