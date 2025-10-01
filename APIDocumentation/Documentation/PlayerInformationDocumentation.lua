local PlayerInformation =
{
	Name = "Player Information",
	Type = "System",
	Namespace = "Player Information",

	Functions =
	{
		{
			Name = "AcceptResurrect",
			Type = "Function",

		},
		{
			Name = "AcceptXPLoss",
			Type = "Function",

		},
		{
			Name = "CanHearthAndResurrectFromArea",
			Type = "Function",

			Returns =
			{
				{ Name = "status", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CheckBinderDist",
			Type = "Function",

			Returns =
			{
				{ Name = "inRange", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CheckSpiritHealerDist",
			Type = "Function",

			Returns =
			{
				{ Name = "inRange", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ConfirmBinder",
			Type = "Function",

		},
		{
			Name = "DeclineResurrect",
			Type = "Function",

		},
		{
			Name = "Dismount",
			Type = "Function",

		},
		{
			Name = "GetBindLocation",
			Type = "Function",

			Returns =
			{
				{ Name = "location", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetComboPoints",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "target", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "comboPoints", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCorpseRecoveryDelay",
			Type = "Function",

			Returns =
			{
				{ Name = "timeLeft", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCurrentTitle",
			Type = "Function",

			Returns =
			{
				{ Name = "currentTitle", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumTitles",
			Type = "Function",

			Returns =
			{
				{ Name = "numTitles", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPlayerFacing",
			Type = "Function",

			Returns =
			{
				{ Name = "facing", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogRewardTitle",
			Type = "Function",

			Returns =
			{
				{ Name = "title", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetRealmName",
			Type = "Function",

			Returns =
			{
				{ Name = "realm", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetReleaseTimeRemaining",
			Type = "Function",

			Returns =
			{
				{ Name = "timeleft", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetResSicknessDuration",
			Type = "Function",

			Returns =
			{
				{ Name = "resSicknessTime", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetRestState",
			Type = "Function",

			Returns =
			{
				{ Name = "state", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "multiplier", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetRuneCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "start", Type = "number", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "runeReady", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetRuneCount",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "count", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetRuneType",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "runeType", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTimeToWellRested",
			Type = "Function",

		},
		{
			Name = "GetTitleName",
			Type = "Function",

			Arguments =
			{
				{ Name = "titleIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "titleName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetUnitPitch",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "pitch", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetUnitSpeed",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "speed", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetXPExhaustion",
			Type = "Function",

			Returns =
			{
				{ Name = "exhaustionXP", Type = "number", Nilable = false },
			},
		},
		{
			Name = "HasFullControl",
			Type = "Function",

			Returns =
			{
				{ Name = "hasControl", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "HasKey",
			Type = "Function",

			Returns =
			{
				{ Name = "hasKey", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "HasSoulstone",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "HasWandEquipped",
			Type = "Function",

			Returns =
			{
				{ Name = "isEquipped", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsFalling",
			Type = "Function",

			Returns =
			{
				{ Name = "falling", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsFlyableArea",
			Type = "Function",

			Returns =
			{
				{ Name = "isFlyable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsFlying",
			Type = "Function",

			Returns =
			{
				{ Name = "isFlying", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsInInstance",
			Type = "Function",

			Returns =
			{
				{ Name = "isInstance", Type = "bool", Nilable = false },
				{ Name = "instanceType", Type = "string", Nilable = false },
			},
		},
		{
			Name = "IsIndoors",
			Type = "Function",

			Returns =
			{
				{ Name = "inside", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsMounted",
			Type = "Function",

			Returns =
			{
				{ Name = "mounted", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsOutOfBounds",
			Type = "Function",

			Returns =
			{
				{ Name = "outOfBounds", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsOutdoors",
			Type = "Function",

			Returns =
			{
				{ Name = "isOutdoors", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsResting",
			Type = "Function",

			Returns =
			{
				{ Name = "resting", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsStealthed",
			Type = "Function",

			Returns =
			{
				{ Name = "stealthed", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsSwimming",
			Type = "Function",

			Returns =
			{
				{ Name = "isSwimming", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsTitleKnown",
			Type = "Function",

			Arguments =
			{
				{ Name = "titleIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "isKnown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsXPUserDisabled",
			Type = "Function",

			Returns =
			{
				{ Name = "isDisabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "OffhandHasWeapon",
			Type = "Function",

			Returns =
			{
				{ Name = "hasWeapon", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "OpeningCinematic",
			Type = "Function",

		},
		{
			Name = "RepopMe",
			Type = "Function",

		},
		{
			Name = "ResurrectGetOfferer",
			Type = "Function",

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ResurrectHasSickness",
			Type = "Function",

			Returns =
			{
				{ Name = "hasSickness", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ResurrectHasTimer",
			Type = "Function",

			Returns =
			{
				{ Name = "hasTimer", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "RetrieveCorpse",
			Type = "Function",

		},
		{
			Name = "SetCurrentTitle",
			Type = "Function",

			Arguments =
			{
				{ Name = "titleIndex", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "ShowCloak",
			Type = "Function",

			Arguments =
			{
				{ Name = "show", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "ShowHelm",
			Type = "Function",

			Arguments =
			{
				{ Name = "show", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "ShowingCloak",
			Type = "Function",

			Returns =
			{
				{ Name = "isShown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ShowingHelm",
			Type = "Function",

			Returns =
			{
				{ Name = "isShown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ToggleSheath",
			Type = "Function",

		},
		{
			Name = "UnitXP",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "currXP", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitXPMax",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "playerMaxXP", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UseSoulstone",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "CharacterPointsChanged",
			Type = "Event",
			LiteralName = "CHARACTER_POINTS_CHANGED",
			Payload =
			{
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "levels", Type = "number", Nilable = false },
			},
		},
		{
			Name = "PlayerAlive",
			Type = "Event",
			LiteralName = "PLAYER_ALIVE",
		},
		{
			Name = "PlayerAurasChanged",
			Type = "Event",
			LiteralName = "PLAYER_AURAS_CHANGED",
		},
		{
			Name = "PlayerCamping",
			Type = "Event",
			LiteralName = "PLAYER_CAMPING",
		},
		{
			Name = "PlayerControlGained",
			Type = "Event",
			LiteralName = "PLAYER_CONTROL_GAINED",
		},
		{
			Name = "PlayerControlLost",
			Type = "Event",
			LiteralName = "PLAYER_CONTROL_LOST",
		},
		{
			Name = "PlayerDamageDoneMods",
			Type = "Event",
			LiteralName = "PLAYER_DAMAGE_DONE_MODS",
			Payload =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "PlayerDead",
			Type = "Event",
			LiteralName = "PLAYER_DEAD",
		},
		{
			Name = "PlayerDifficultyChanged",
			Type = "Event",
			LiteralName = "PLAYER_DIFFICULTY_CHANGED",
		},
		{
			Name = "PlayerEnteringBattleground",
			Type = "Event",
			LiteralName = "PLAYER_ENTERING_BATTLEGROUND",
		},
		{
			Name = "PlayerEnteringWorld",
			Type = "Event",
			LiteralName = "PLAYER_ENTERING_WORLD",
		},
		{
			Name = "PlayerEquipmentChanged",
			Type = "Event",
			LiteralName = "PLAYER_EQUIPMENT_CHANGED",
			Payload =
			{
				{ Name = "slot", Type = "inventoryID", Nilable = false },
				{ Name = "hasItem", Type = "1nil", Nilable = false },
			},
		},
		{
			Name = "PlayerFarsightFocusChanged",
			Type = "Event",
			LiteralName = "PLAYER_FARSIGHT_FOCUS_CHANGED",
		},
		{
			Name = "PlayerFlagsChanged",
			Type = "Event",
			LiteralName = "PLAYER_FLAGS_CHANGED",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "PlayerFocusChanged",
			Type = "Event",
			LiteralName = "PLAYER_FOCUS_CHANGED",
		},
		{
			Name = "PlayerLeavingWorld",
			Type = "Event",
			LiteralName = "PLAYER_LEAVING_WORLD",
		},
		{
			Name = "PlayerLevelUp",
			Type = "Event",
			LiteralName = "PLAYER_LEVEL_UP",
			Payload =
			{
				{ Name = "level", Type = "string", Nilable = false },
				{ Name = "hp", Type = "number", Nilable = false },
				{ Name = "mp", Type = "number", Nilable = false },
				{ Name = "talentPoints", Type = "number", Nilable = false },
				{ Name = "strength", Type = "number", Nilable = false },
				{ Name = "agility", Type = "number", Nilable = false },
				{ Name = "stamina", Type = "number", Nilable = false },
				{ Name = "intellect", Type = "number", Nilable = false },
				{ Name = "spirit", Type = "number", Nilable = false },
			},
		},
		{
			Name = "PlayerLogin",
			Type = "Event",
			LiteralName = "PLAYER_LOGIN",
		},
		{
			Name = "PlayerLogout",
			Type = "Event",
			LiteralName = "PLAYER_LOGOUT",
		},
		{
			Name = "PlayerQuiting",
			Type = "Event",
			LiteralName = "PLAYER_QUITING",
		},
		{
			Name = "PlayerRegenDisabled",
			Type = "Event",
			LiteralName = "PLAYER_REGEN_DISABLED",
		},
		{
			Name = "PlayerRegenEnabled",
			Type = "Event",
			LiteralName = "PLAYER_REGEN_ENABLED",
		},
		{
			Name = "PlayerRolesAssigned",
			Type = "Event",
			LiteralName = "PLAYER_ROLES_ASSIGNED",
		},
		{
			Name = "PlayerSkinned",
			Type = "Event",
			LiteralName = "PLAYER_SKINNED",
		},
		{
			Name = "PlayerTargetChanged",
			Type = "Event",
			LiteralName = "PLAYER_TARGET_CHANGED",
		},
		{
			Name = "PlayerTotemUpdate",
			Type = "Event",
			LiteralName = "PLAYER_TOTEM_UPDATE",
		},
		{
			Name = "PlayerUnghost",
			Type = "Event",
			LiteralName = "PLAYER_UNGHOST",
		},
		{
			Name = "PlayerUpdateResting",
			Type = "Event",
			LiteralName = "PLAYER_UPDATE_RESTING",
		},
		{
			Name = "PlayerXpUpdate",
			Type = "Event",
			LiteralName = "PLAYER_XP_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(PlayerInformation);
