local Unit =
{
	Name = "Unit",
	Type = "System",
	Namespace = "Unit",

	Functions =
	{
		{
			Name = "CanInspect",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "showError", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "canInspect", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CheckInteractDistance",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "distIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "canInteract", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetGuildInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "guildName", Type = "string", Nilable = false },
				{ Name = "guildRankName", Type = "string", Nilable = false },
				{ Name = "guildRankIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetMuteStatus",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "channel", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "muteStatus", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetPlayerInfoByGUID",
			Type = "Function",

			Arguments =
			{
				{ Name = "guid", Type = "WOWGUID", Nilable = false },
			},

			Returns =
			{
				{ Name = "class", Type = "string", Nilable = false },
				{ Name = "classFilename", Type = "string", Nilable = false },
				{ Name = "race", Type = "string", Nilable = false },
				{ Name = "raceFilename", Type = "string", Nilable = false },
				{ Name = "sex", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "realm", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetUnitName",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "showServerName", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "nameString", Type = "string", Nilable = false },
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
			Name = "IsIgnoredOrMuted",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isIgnoredOrMuted", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsMuted",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "muted", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsUnitOnQuest",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "state", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetPortraitTexture",
			Type = "Function",

			Arguments =
			{
				{ Name = "texture", Type = "table", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

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
		{
			Name = "UnitAura",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "rank", Type = "string", Nilable = true },
				{ Name = "filter", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "dispelType", Type = "string", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "expires", Type = "number", Nilable = false },
				{ Name = "caster", Type = "string", Nilable = false },
				{ Name = "isStealable", Type = "1nil", Nilable = false },
				{ Name = "shouldConsolidate", Type = "bool", Nilable = false },
				{ Name = "spellID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitCanAssist",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "canAssist", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitCanAttack",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "canAttack", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitCanCooperate",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "canCooperate", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitCastingInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "subText", Type = "string", Nilable = false },
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "startTime", Type = "time_t", Nilable = false },
				{ Name = "endTime", Type = "time_t", Nilable = false },
				{ Name = "isTradeSkill", Type = "bool", Nilable = false },
				{ Name = "castID", Type = "number", Nilable = false },
				{ Name = "notInterruptible", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitChannelInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "subText", Type = "string", Nilable = false },
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "startTime", Type = "time_t", Nilable = false },
				{ Name = "endTime", Type = "time_t", Nilable = false },
				{ Name = "isTradeSkill", Type = "bool", Nilable = false },
				{ Name = "notInterruptible", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitClass",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "class", Type = "string", Nilable = false },
				{ Name = "classFileName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UnitClassBase",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "class", Type = "string", Nilable = false },
				{ Name = "classFileName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UnitClassification",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "classification", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UnitCreatureFamily",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "family", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UnitCreatureType",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "type", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UnitDebuff",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "rank", Type = "string", Nilable = true },
				{ Name = "filter", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "dispelType", Type = "string", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "expires", Type = "number", Nilable = false },
				{ Name = "caster", Type = "string", Nilable = false },
				{ Name = "isStealable", Type = "1nil", Nilable = false },
			},
		},
		{
			Name = "UnitExists",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "exists", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitFactionGroup",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "factionGroup", Type = "string", Nilable = false },
				{ Name = "factionName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UnitGUID",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "guid", Type = "WOWGUID", Nilable = false },
			},
		},
		{
			Name = "UnitHasRelicSlot",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "hasRelic", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitHealth",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "modifier", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitHealthMax",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "maxValue", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitInBattleground",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "raidNum", Type = "number", Nilable = false },
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
			Name = "UnitInRaid",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "inRaid", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitInRange",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "inRange", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsAFK",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isAFK", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsCharmed",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isCharmed", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsConnected",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isConnected", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsControlling",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isControlling", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsCorpse",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isCorpse", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsDND",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isDND", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsDead",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isDead", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsDeadOrGhost",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isDeadOrGhost", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsEnemy",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isEnemy", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsFeignDeath",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isFeign", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsFriend",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isFriends", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsGhost",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isGhost", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsInMyGuild",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "inGuild", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsPVP",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isPVP", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsPVPFreeForAll",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isFreeForAll", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsPVPSanctuary",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "state", Type = "bool", Nilable = false },
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
			Name = "UnitIsPlayer",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isPlayer", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsPossessed",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isPossessed", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsRaidOfficer",
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
			Name = "UnitIsSameServer",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isSame", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsTapped",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

		},
		{
			Name = "UnitIsTappedByAllThreatList",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "allTapped", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsTappedByPlayer",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isTapped", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsTrivial",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isTrivial", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isSame", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsVisible",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isVisible", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitLevel",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "level", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitMana",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "regen", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitManaMax",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "maxValue", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitName",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "showServerName", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "nameString", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UnitOnTaxi",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "onTaxi", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitPVPName",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UnitPVPRank",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "rank", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitPlayerControlled",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isPlayer", Type = "bool", Nilable = false },
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
		{
			Name = "UnitPlayerOrPetInRaid",
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
		{
			Name = "UnitPower",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "modifier", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitPowerMax",
			Type = "Function",

			Arguments =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
				{ Name = "powerType", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "maxValue", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitPowerType",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "powerType", Type = "number", Nilable = false },
				{ Name = "powerToken", Type = "string", Nilable = false },
				{ Name = "altR", Type = "number", Nilable = false },
				{ Name = "altG", Type = "number", Nilable = false },
				{ Name = "altB", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitRace",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "race", Type = "string", Nilable = false },
				{ Name = "fileName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UnitReaction",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "reaction", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitSelectionColor",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "red", Type = "number", Nilable = false },
				{ Name = "green", Type = "number", Nilable = false },
				{ Name = "blue", Type = "number", Nilable = false },
				{ Name = "alpha", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitSex",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "gender", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitUsingVehicle",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "usingVehicle", Type = "bool", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "UnitAttack",
			Type = "Event",
			LiteralName = "UNIT_ATTACK",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitAttackPower",
			Type = "Event",
			LiteralName = "UNIT_ATTACK_POWER",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitAttackSpeed",
			Type = "Event",
			LiteralName = "UNIT_ATTACK_SPEED",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitAura",
			Type = "Event",
			LiteralName = "UNIT_AURA",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitClassificationChanged",
			Type = "Event",
			LiteralName = "UNIT_CLASSIFICATION_CHANGED",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitComboPoints",
			Type = "Event",
			LiteralName = "UNIT_COMBO_POINTS",
		},
		{
			Name = "UnitDamage",
			Type = "Event",
			LiteralName = "UNIT_DAMAGE",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitDefense",
			Type = "Event",
			LiteralName = "UNIT_DEFENSE",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitDisplaypower",
			Type = "Event",
			LiteralName = "UNIT_DISPLAYPOWER",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitDynamicFlags",
			Type = "Event",
			LiteralName = "UNIT_DYNAMIC_FLAGS",
		},
		{
			Name = "UnitFlags",
			Type = "Event",
			LiteralName = "UNIT_FLAGS",
			Payload =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitHealth",
			Type = "Event",
			LiteralName = "UNIT_HEALTH",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitLevel",
			Type = "Event",
			LiteralName = "UNIT_LEVEL",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitMana",
			Type = "Event",
			LiteralName = "UNIT_MANA",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitMaxhealth",
			Type = "Event",
			LiteralName = "UNIT_MAXHEALTH",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitModelChanged",
			Type = "Event",
			LiteralName = "UNIT_MODEL_CHANGED",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitNameUpdate",
			Type = "Event",
			LiteralName = "UNIT_NAME_UPDATE",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitPet",
			Type = "Event",
			LiteralName = "UNIT_PET",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitPetExperience",
			Type = "Event",
			LiteralName = "UNIT_PET_EXPERIENCE",
		},
		{
			Name = "UnitPortraitUpdate",
			Type = "Event",
			LiteralName = "UNIT_PORTRAIT_UPDATE",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitRage",
			Type = "Event",
			LiteralName = "UNIT_RAGE",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitRangeddamage",
			Type = "Event",
			LiteralName = "UNIT_RANGEDDAMAGE",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitRangedAttackPower",
			Type = "Event",
			LiteralName = "UNIT_RANGED_ATTACK_POWER",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitResistances",
			Type = "Event",
			LiteralName = "UNIT_RESISTANCES",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitStats",
			Type = "Event",
			LiteralName = "UNIT_STATS",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitTarget",
			Type = "Event",
			LiteralName = "UNIT_TARGET",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UpdateMouseoverUnit",
			Type = "Event",
			LiteralName = "UPDATE_MOUSEOVER_UNIT",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Unit);
