local StatInformation =
{
	Name = "Stat Information",
	Type = "System",
	Namespace = "Stat Information",

	Functions =
	{
		{
			Name = "GetArmorPenetration",
			Type = "Function",

			Returns =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetAttackPowerForStat",
			Type = "Function",

			Arguments =
			{
				{ Name = "statIndex", Type = "luaIndex", Nilable = false },
				{ Name = "effectiveStat", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "attackPower", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetBlockChance",
			Type = "Function",

			Returns =
			{
				{ Name = "chance", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCombatRating",
			Type = "Function",

			Arguments =
			{
				{ Name = "ratingIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "rating", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCombatRatingBonus",
			Type = "Function",

			Arguments =
			{
				{ Name = "ratingIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "ratingBonus", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCritChance",
			Type = "Function",

			Returns =
			{
				{ Name = "critChance", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCritChanceFromAgility",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
			},

			Returns =
			{
				{ Name = "critChance", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetDamageBonusStat",
			Type = "Function",

			Returns =
			{
				{ Name = "bonusStat", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetDodgeChance",
			Type = "Function",

			Returns =
			{
				{ Name = "chance", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetExpertise",
			Type = "Function",

			Returns =
			{
				{ Name = "expertise", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetExpertisePercent",
			Type = "Function",

			Returns =
			{
				{ Name = "expertisePerc", Type = "number", Nilable = false },
				{ Name = "offhandExpertisePercent", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetManaRegen",
			Type = "Function",

			Returns =
			{
				{ Name = "base", Type = "number", Nilable = false },
				{ Name = "casting", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetMaxCombatRatingBonus",
			Type = "Function",

			Arguments =
			{
				{ Name = "ratingIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "max", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetParryChance",
			Type = "Function",

			Returns =
			{
				{ Name = "chance", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPowerRegen",
			Type = "Function",

			Returns =
			{
				{ Name = "inactiveRegen", Type = "number", Nilable = false },
				{ Name = "activeRegen", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetRangedCritChance",
			Type = "Function",

			Returns =
			{
				{ Name = "critChance", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetShieldBlock",
			Type = "Function",

			Returns =
			{
				{ Name = "damage", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSpellBonusDamage",
			Type = "Function",

			Arguments =
			{
				{ Name = "school", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "minModifier", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSpellBonusHealing",
			Type = "Function",

			Returns =
			{
				{ Name = "bonusHealing", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSpellCritChance",
			Type = "Function",

			Arguments =
			{
				{ Name = "school", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "minCrit", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSpellCritChanceFromIntellect",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
			},

			Returns =
			{
				{ Name = "critChance", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSpellPenetration",
			Type = "Function",

			Returns =
			{
				{ Name = "penetration", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetUnitHealthModifier",
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
			Name = "GetUnitHealthRegenRateFromSpirit",
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
			Name = "GetUnitManaRegenRateFromSpirit",
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
			Name = "GetUnitMaxHealthModifier",
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
			Name = "GetUnitPowerModifier",
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
			Name = "UnitArmor",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "base", Type = "number", Nilable = false },
				{ Name = "effectiveArmor", Type = "number", Nilable = false },
				{ Name = "armor", Type = "number", Nilable = false },
				{ Name = "posBuff", Type = "number", Nilable = false },
				{ Name = "negBuff", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitAttackBothHands",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "mainHandAttackBase", Type = "number", Nilable = false },
				{ Name = "mainHandAttackMod", Type = "number", Nilable = false },
				{ Name = "offHandHandAttackBase", Type = "number", Nilable = false },
				{ Name = "offHandAttackMod", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitAttackPower",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "base", Type = "number", Nilable = false },
				{ Name = "posBuff", Type = "number", Nilable = false },
				{ Name = "negBuff", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitAttackSpeed",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "speed", Type = "number", Nilable = false },
				{ Name = "offhandSpeed", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitDamage",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "minDamage", Type = "number", Nilable = false },
				{ Name = "maxDamage", Type = "number", Nilable = false },
				{ Name = "minOffHandDamage", Type = "number", Nilable = false },
				{ Name = "maxOffHandDamage", Type = "number", Nilable = false },
				{ Name = "physicalBonusPos", Type = "number", Nilable = false },
				{ Name = "physicalBonusNeg", Type = "number", Nilable = false },
				{ Name = "percent", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitDefense",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "base", Type = "number", Nilable = false },
				{ Name = "modifier", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitRangedAttack",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "rangedAttackBase", Type = "number", Nilable = false },
				{ Name = "rangedAttackMod", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitRangedAttackPower",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "base", Type = "number", Nilable = false },
				{ Name = "posBuff", Type = "number", Nilable = false },
				{ Name = "negBuff", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitRangedDamage",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "rangedAttackSpeed", Type = "number", Nilable = false },
				{ Name = "minDamage", Type = "number", Nilable = false },
				{ Name = "maxDamage", Type = "number", Nilable = false },
				{ Name = "physicalBonusPos", Type = "number", Nilable = false },
				{ Name = "physicalBonusNeg", Type = "number", Nilable = false },
				{ Name = "percent", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitResistance",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "resistanceIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "base", Type = "number", Nilable = false },
				{ Name = "resistance", Type = "number", Nilable = false },
				{ Name = "positive", Type = "number", Nilable = false },
				{ Name = "negative", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitStat",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "statIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "stat", Type = "number", Nilable = false },
				{ Name = "effectiveStat", Type = "number", Nilable = false },
				{ Name = "posBuff", Type = "number", Nilable = false },
				{ Name = "negBuff", Type = "number", Nilable = false },
			},
		},
	},

	Events =
	{
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(StatInformation);
