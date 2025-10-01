local Uncategorizedevents =
{
	Name = "UncategorizedEvents",
	Type = "System",
	Namespace = "UncategorizedEvents",

	Functions =
	{
	},

	Events =
	{
		{
			Name = "CancelSummon",
			Type = "Event",
			LiteralName = "CANCEL_SUMMON",
		},
		{
			Name = "CloseTabardFrame",
			Type = "Event",
			LiteralName = "CLOSE_TABARD_FRAME",
		},
		{
			Name = "CriteriaUpdate",
			Type = "Event",
			LiteralName = "CRITERIA_UPDATE",
		},
		{
			Name = "DisplaySizeChanged",
			Type = "Event",
			LiteralName = "DISPLAY_SIZE_CHANGED",
		},
		{
			Name = "EndRefund",
			Type = "Event",
			LiteralName = "END_REFUND",
		},
		{
			Name = "EquipBindConfirm",
			Type = "Event",
			LiteralName = "EQUIP_BIND_CONFIRM",
			Payload =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},
		},
		{
			Name = "FriendlistUpdate",
			Type = "Event",
			LiteralName = "FRIENDLIST_UPDATE",
		},
		{
			Name = "GmresponseReceived",
			Type = "Event",
			LiteralName = "GMRESPONSE_RECEIVED",
		},
		{
			Name = "GmPlayerInfo",
			Type = "Event",
			LiteralName = "GM_PLAYER_INFO",
		},
		{
			Name = "IgnorelistUpdate",
			Type = "Event",
			LiteralName = "IGNORELIST_UPDATE",
		},
		{
			Name = "IgrBillingNagDialog",
			Type = "Event",
			LiteralName = "IGR_BILLING_NAG_DIALOG",
		},
		{
			Name = "KnownTitlesUpdate",
			Type = "Event",
			LiteralName = "KNOWN_TITLES_UPDATE",
		},
		{
			Name = "LanguageListChanged",
			Type = "Event",
			LiteralName = "LANGUAGE_LIST_CHANGED",
		},
		{
			Name = "LevelGrantProposed",
			Type = "Event",
			LiteralName = "LEVEL_GRANT_PROPOSED",
		},
		{
			Name = "LogoutCancel",
			Type = "Event",
			LiteralName = "LOGOUT_CANCEL",
		},
		{
			Name = "ModifierStateChanged",
			Type = "Event",
			LiteralName = "MODIFIER_STATE_CHANGED",
			Payload =
			{
				{ Name = "key", Type = "string", Nilable = false },
				{ Name = "state", Type = "number", Nilable = false },
			},
		},
		{
			Name = "MutelistUpdate",
			Type = "Event",
			LiteralName = "MUTELIST_UPDATE",
		},
		{
			Name = "NewTitleEarned",
			Type = "Event",
			LiteralName = "NEW_TITLE_EARNED",
			Payload =
			{
				{ Name = "title", Type = "string", Nilable = false },
			},
		},
		{
			Name = "OldTitleLost",
			Type = "Event",
			LiteralName = "OLD_TITLE_LOST",
			Payload =
			{
				{ Name = "title", Type = "string", Nilable = false },
			},
		},
		{
			Name = "OpenTabardFrame",
			Type = "Event",
			LiteralName = "OPEN_TABARD_FRAME",
		},
		{
			Name = "PlaytimeChanged",
			Type = "Event",
			LiteralName = "PLAYTIME_CHANGED",
		},
		{
			Name = "PlayMovie",
			Type = "Event",
			LiteralName = "PLAY_MOVIE",
		},
		{
			Name = "RaisedAsGhoul",
			Type = "Event",
			LiteralName = "RAISED_AS_GHOUL",
		},
		{
			Name = "ReplaceEnchant",
			Type = "Event",
			LiteralName = "REPLACE_ENCHANT",
			Payload =
			{
				{ Name = "current", Type = "string", Nilable = false },
				{ Name = "new", Type = "string", Nilable = false },
			},
		},
		{
			Name = "SynchronizeSettings",
			Type = "Event",
			LiteralName = "SYNCHRONIZE_SETTINGS",
		},
		{
			Name = "TimePlayedMsg",
			Type = "Event",
			LiteralName = "TIME_PLAYED_MSG",
			Payload =
			{
				{ Name = "total", Type = "number", Nilable = false },
				{ Name = "level", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UseBindConfirm",
			Type = "Event",
			LiteralName = "USE_BIND_CONFIRM",
		},
		{
			Name = "VariablesLoaded",
			Type = "Event",
			LiteralName = "VARIABLES_LOADED",
		},
		{
			Name = "VoteKickReasonNeeded",
			Type = "Event",
			LiteralName = "VOTE_KICK_REASON_NEEDED",
		},
		{
			Name = "WearEquipmentSet",
			Type = "Event",
			LiteralName = "WEAR_EQUIPMENT_SET",
		},
		{
			Name = "WhoListUpdate",
			Type = "Event",
			LiteralName = "WHO_LIST_UPDATE",
		},
		{
			Name = "WorldStateUiTimerUpdate",
			Type = "Event",
			LiteralName = "WORLD_STATE_UI_TIMER_UPDATE",
		},
		{
			Name = "WowMouseNotFound",
			Type = "Event",
			LiteralName = "WOW_MOUSE_NOT_FOUND",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Uncategorizedevents);
