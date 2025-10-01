local Spell =
{
	Name = "Spell",
	Type = "System",
	Namespace = "Spell",

	Functions =
	{
		{
			Name = "CastSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "bookType", Type = "string", Nilable = false },
			},

		},
		{
			Name = "CastSpellByID",
			Type = "Function",

			Arguments =
			{
				{ Name = "spellID", Type = "number", Nilable = false },
				{ Name = "target", Type = "string", Nilable = true },
			},

		},
		{
			Name = "CastSpellByName",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "target", Type = "string", Nilable = true },
			},

		},
		{
			Name = "CursorHasSpell",
			Type = "Function",

			Returns =
			{
				{ Name = "hasSpell", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "DisableSpellAutocast",
			Type = "Function",

			Arguments =
			{
				{ Name = "spell", Type = "string", Nilable = false },
			},

		},
		{
			Name = "EnableSpellAutocast",
			Type = "Function",

			Arguments =
			{
				{ Name = "spell", Type = "string", Nilable = false },
			},

		},
		{
			Name = "GetItemSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetKnownSlotFromHighestRankSlot",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "maxRankSlot", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumSpellTabs",
			Type = "Function",

			Returns =
			{
				{ Name = "numTabs", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetQuestLogRewardSpell",
			Type = "Function",

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "isTradeskillSpell", Type = "bool", Nilable = false },
				{ Name = "isSpellLearned", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetRewardSpell",
			Type = "Function",

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "isTradeskillSpell", Type = "bool", Nilable = false },
				{ Name = "isSpellLearned", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetSpellAutocast",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "bookType", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "autocastAllowed", Type = "bool", Nilable = false },
				{ Name = "autocastEnabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetSpellCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "id", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "start", Type = "number", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "enable", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSpellCount",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "numCasts", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSpellInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "id", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "powerCost", Type = "number", Nilable = false },
				{ Name = "isFunnel", Type = "bool", Nilable = false },
				{ Name = "powerType", Type = "number", Nilable = false },
				{ Name = "castingTime", Type = "time_t", Nilable = false },
				{ Name = "minRange", Type = "number", Nilable = false },
				{ Name = "maxRange", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSpellLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "id", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
				{ Name = "tradeLink", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetSpellName",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "bookType", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "spellName", Type = "string", Nilable = false },
				{ Name = "subSpellName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetSpellTabInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "offset", Type = "number", Nilable = false },
				{ Name = "numSpells", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSpellTexture",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
			},
		},
		{
			Name = "HasPetSpells",
			Type = "Function",

			Returns =
			{
				{ Name = "hasPetSpells", Type = "bool", Nilable = false },
				{ Name = "petType", Type = "string", Nilable = false },
			},
		},
		{
			Name = "IsAttackSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isAttack", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsAutoRepeatSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "spellName", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "isAutoRepeat", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsConsumableSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isConsumable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsCurrentSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isCurrent", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsHarmfulSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isHarmful", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsHelpfulSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isHarmful", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsPassiveSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isPassive", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsSpellInRange",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
			},

			Returns =
			{
				{ Name = "inRange", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsSpellKnown",
			Type = "Function",

			Arguments =
			{
				{ Name = "spellID", Type = "number", Nilable = false },
				{ Name = "isPet", Type = "bool", Nilable = true },
			},

			Returns =
			{
				{ Name = "isKnown", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsUsableSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isUsable", Type = "bool", Nilable = false },
				{ Name = "notEnoughMana", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PickupSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "bookType", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SetMultiCastSpell",
			Type = "Function",

			Arguments =
			{
				{ Name = "action", Type = "number", Nilable = false },
				{ Name = "spell", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SpellCanTargetGlyph",
			Type = "Function",

			Returns =
			{
				{ Name = "canTarget", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SpellCanTargetItem",
			Type = "Function",

			Returns =
			{
				{ Name = "canTarget", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SpellCanTargetUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "canTarget", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SpellHasRange",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "hasRange", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SpellIsTargeting",
			Type = "Function",

			Returns =
			{
				{ Name = "isTargeting", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SpellStopCasting",
			Type = "Function",

		},
		{
			Name = "SpellStopTargeting",
			Type = "Function",

		},
		{
			Name = "SpellTargetItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

		},
		{
			Name = "SpellTargetUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ToggleSpellAutocast",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "bookType", Type = "string", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
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
	},

	Events =
	{
		{
			Name = "CurrentSpellCastChanged",
			Type = "Event",
			LiteralName = "CURRENT_SPELL_CAST_CHANGED",
		},
		{
			Name = "LearnedSpellInTab",
			Type = "Event",
			LiteralName = "LEARNED_SPELL_IN_TAB",
			Payload =
			{
				{ Name = "spellID", Type = "number", Nilable = false },
				{ Name = "tabID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "PetSpellPowerUpdate",
			Type = "Event",
			LiteralName = "PET_SPELL_POWER_UPDATE",
		},
		{
			Name = "SpellsChanged",
			Type = "Event",
			LiteralName = "SPELLS_CHANGED",
		},
		{
			Name = "SpellUpdateCooldown",
			Type = "Event",
			LiteralName = "SPELL_UPDATE_COOLDOWN",
		},
		{
			Name = "SpellUpdateUsable",
			Type = "Event",
			LiteralName = "SPELL_UPDATE_USABLE",
		},
		{
			Name = "StartAutorepeatSpell",
			Type = "Event",
			LiteralName = "START_AUTOREPEAT_SPELL",
		},
		{
			Name = "StopAutorepeatSpell",
			Type = "Event",
			LiteralName = "STOP_AUTOREPEAT_SPELL",
		},
		{
			Name = "UnitSpellcastDelayed",
			Type = "Event",
			LiteralName = "UNIT_SPELLCAST_DELAYED",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
				{ Name = "spell", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UnitSpellcastFailed",
			Type = "Event",
			LiteralName = "UNIT_SPELLCAST_FAILED",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
				{ Name = "spell", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
				{ Name = "unknownid", Type = "number", Nilable = false },
				{ Name = "spellid", Type = "blizzid", Nilable = false },
			},
		},
		{
			Name = "UnitSpellcastFailedQuiet",
			Type = "Event",
			LiteralName = "UNIT_SPELLCAST_FAILED_QUIET",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
				{ Name = "spell", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
			},
		},
		{
			Name = "UnitSpellcastInterrupted",
			Type = "Event",
			LiteralName = "UNIT_SPELLCAST_INTERRUPTED",
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
			Name = "UnitSpellcastInterruptible",
			Type = "Event",
			LiteralName = "UNIT_SPELLCAST_INTERRUPTIBLE",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitSpellcastNotInterruptible",
			Type = "Event",
			LiteralName = "UNIT_SPELLCAST_NOT_INTERRUPTIBLE",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UnitSpellcastSent",
			Type = "Event",
			LiteralName = "UNIT_SPELLCAST_SENT",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
				{ Name = "spell", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
				{ Name = "target", Type = "string", Nilable = false },
				{ Name = "lineID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitSpellcastStart",
			Type = "Event",
			LiteralName = "UNIT_SPELLCAST_START",
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
			Name = "UnitSpellcastStop",
			Type = "Event",
			LiteralName = "UNIT_SPELLCAST_STOP",
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
			Name = "UnitSpellcastSucceeded",
			Type = "Event",
			LiteralName = "UNIT_SPELLCAST_SUCCEEDED",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
				{ Name = "spell", Type = "string", Nilable = false },
				{ Name = "rank", Type = "string", Nilable = false },
				{ Name = "?", Type = "number", Nilable = false },
				{ Name = "spellID", Type = "number", Nilable = false },
			},
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Spell);
