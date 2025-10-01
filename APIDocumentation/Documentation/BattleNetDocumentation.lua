local BattleNet =
{
	Name = "Battle.net",
	Type = "System",
	Namespace = "Battle.net",

	Functions =
	{
		{
			Name = "BNGetFriendInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "friendIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "presenceID", Type = "number", Nilable = false },
				{ Name = "givenName", Type = "string", Nilable = false },
				{ Name = "surname", Type = "string", Nilable = false },
				{ Name = "toonName", Type = "string", Nilable = false },
				{ Name = "toonID", Type = "number", Nilable = false },
				{ Name = "client", Type = "string", Nilable = false },
				{ Name = "isOnline", Type = "bool", Nilable = false },
				{ Name = "lastOnline", Type = "number", Nilable = false },
				{ Name = "isAFK", Type = "bool", Nilable = false },
				{ Name = "isDND", Type = "bool", Nilable = false },
				{ Name = "messageText", Type = "string", Nilable = false },
				{ Name = "noteText", Type = "string", Nilable = false },
				{ Name = "isFriend", Type = "bool", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
			},
		},
		{
			Name = "BNGetFriendInfoByID",
			Type = "Function",

			Arguments =
			{
				{ Name = "presenceID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "presenceID", Type = "number", Nilable = false },
				{ Name = "givenName", Type = "string", Nilable = false },
				{ Name = "surname", Type = "string", Nilable = false },
				{ Name = "toonName", Type = "string", Nilable = false },
				{ Name = "toonID", Type = "number", Nilable = false },
				{ Name = "client", Type = "string", Nilable = false },
				{ Name = "isOnline", Type = "bool", Nilable = false },
				{ Name = "lastOnline", Type = "number", Nilable = false },
				{ Name = "isAFK", Type = "bool", Nilable = false },
				{ Name = "isDND", Type = "bool", Nilable = false },
				{ Name = "messageText", Type = "string", Nilable = false },
				{ Name = "noteText", Type = "string", Nilable = false },
				{ Name = "isFriend", Type = "bool", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
			},
		},
		{
			Name = "BNGetFriendToonInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "friendIndex", Type = "luaIndex", Nilable = false },
				{ Name = "toonIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "unknown", Type = "bool", Nilable = false },
				{ Name = "toonName", Type = "string", Nilable = false },
				{ Name = "client", Type = "string", Nilable = false },
				{ Name = "realmName", Type = "string", Nilable = false },
				{ Name = "faction", Type = "number", Nilable = false },
				{ Name = "race", Type = "string", Nilable = false },
				{ Name = "class", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "zoneName", Type = "string", Nilable = false },
				{ Name = "level", Type = "string", Nilable = false },
				{ Name = "gameText", Type = "string", Nilable = false },
				{ Name = "broadcastText", Type = "string", Nilable = false },
				{ Name = "broadcastTime", Type = "string", Nilable = false },
			},
		},
		{
			Name = "BNGetInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "unknown", Type = "number", Nilable = false },
				{ Name = "broadcastText", Type = "string", Nilable = false },
				{ Name = "bnetAFK", Type = "bool", Nilable = false },
				{ Name = "bnetDND", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "BNGetMatureLanguageFilter",
			Type = "Function",

			Returns =
			{
				{ Name = "isEnabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "BNGetNumFriendToons",
			Type = "Function",

			Arguments =
			{
				{ Name = "friendIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "numToons", Type = "number", Nilable = false },
			},
		},
		{
			Name = "BNGetNumFriends",
			Type = "Function",

			Returns =
			{
				{ Name = "totalBNet", Type = "number", Nilable = false },
				{ Name = "numBNetOnline", Type = "number", Nilable = false },
			},
		},
		{
			Name = "BNGetSelectedFriend",
			Type = "Function",

			Returns =
			{
				{ Name = "friendIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "BNGetToonInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "presenceID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "unknown", Type = "bool", Nilable = false },
				{ Name = "toonName", Type = "string", Nilable = false },
				{ Name = "client", Type = "string", Nilable = false },
				{ Name = "realmName", Type = "string", Nilable = false },
				{ Name = "realmID", Type = "number", Nilable = false },
				{ Name = "faction", Type = "number", Nilable = false },
				{ Name = "race", Type = "string", Nilable = false },
				{ Name = "class", Type = "string", Nilable = false },
				{ Name = "unknown", Type = "string", Nilable = false },
				{ Name = "zoneName", Type = "string", Nilable = false },
				{ Name = "level", Type = "string", Nilable = false },
				{ Name = "gameText", Type = "string", Nilable = false },
				{ Name = "broadcastText", Type = "string", Nilable = false },
				{ Name = "broadcastTime", Type = "string", Nilable = false },
			},
		},
		{
			Name = "BNSetCustomMessage",
			Type = "Function",

			Arguments =
			{
				{ Name = "broadcastText", Type = "string", Nilable = false },
			},

		},
		{
			Name = "BNSetFriendNote",
			Type = "Function",

			Arguments =
			{
				{ Name = "presenceID", Type = "number", Nilable = false },
				{ Name = "note", Type = "string", Nilable = false },
			},

		},
		{
			Name = "BNSetMatureLanguageFilter",
			Type = "Function",

			Arguments =
			{
				{ Name = "enabled", Type = "bool", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "BnBlockListUpdated",
			Type = "Event",
			LiteralName = "BN_BLOCK_LIST_UPDATED",
		},
		{
			Name = "BnConnected",
			Type = "Event",
			LiteralName = "BN_CONNECTED",
		},
		{
			Name = "BnCustomMessageChanged",
			Type = "Event",
			LiteralName = "BN_CUSTOM_MESSAGE_CHANGED",
		},
		{
			Name = "BnCustomMessageLoaded",
			Type = "Event",
			LiteralName = "BN_CUSTOM_MESSAGE_LOADED",
		},
		{
			Name = "BnDisconnected",
			Type = "Event",
			LiteralName = "BN_DISCONNECTED",
		},
		{
			Name = "BnFriendAccountOffline",
			Type = "Event",
			LiteralName = "BN_FRIEND_ACCOUNT_OFFLINE",
			Payload =
			{
				{ Name = "presenceID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "BnFriendAccountOnline",
			Type = "Event",
			LiteralName = "BN_FRIEND_ACCOUNT_ONLINE",
			Payload =
			{
				{ Name = "presenceID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "BnFriendInfoChanged",
			Type = "Event",
			LiteralName = "BN_FRIEND_INFO_CHANGED",
		},
		{
			Name = "BnFriendInviteAdded",
			Type = "Event",
			LiteralName = "BN_FRIEND_INVITE_ADDED",
		},
		{
			Name = "BnFriendInviteListInitialized",
			Type = "Event",
			LiteralName = "BN_FRIEND_INVITE_LIST_INITIALIZED",
		},
		{
			Name = "BnFriendInviteRemoved",
			Type = "Event",
			LiteralName = "BN_FRIEND_INVITE_REMOVED",
		},
		{
			Name = "BnFriendInviteSendResult",
			Type = "Event",
			LiteralName = "BN_FRIEND_INVITE_SEND_RESULT",
		},
		{
			Name = "BnFriendListSizeChanged",
			Type = "Event",
			LiteralName = "BN_FRIEND_LIST_SIZE_CHANGED",
		},
		{
			Name = "BnFriendToonOffline",
			Type = "Event",
			LiteralName = "BN_FRIEND_TOON_OFFLINE",
		},
		{
			Name = "BnFriendToonOnline",
			Type = "Event",
			LiteralName = "BN_FRIEND_TOON_ONLINE",
		},
		{
			Name = "BnMatureLanguageFilter",
			Type = "Event",
			LiteralName = "BN_MATURE_LANGUAGE_FILTER",
		},
		{
			Name = "BnNewPresence",
			Type = "Event",
			LiteralName = "BN_NEW_PRESENCE",
			Payload =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "BnSelfOffline",
			Type = "Event",
			LiteralName = "BN_SELF_OFFLINE",
		},
		{
			Name = "BnSelfOnline",
			Type = "Event",
			LiteralName = "BN_SELF_ONLINE",
		},
		{
			Name = "BnSystemMessage",
			Type = "Event",
			LiteralName = "BN_SYSTEM_MESSAGE",
		},
		{
			Name = "BnToonNameUpdated",
			Type = "Event",
			LiteralName = "BN_TOON_NAME_UPDATED",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(BattleNet);
