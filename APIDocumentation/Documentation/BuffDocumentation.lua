local Buff =
{
	Name = "Buff",
	Type = "System",
	Namespace = "Buff",

	Functions =
	{
		{
			Name = "CancelItemTempEnchantment",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CancelShapeshiftForm",
			Type = "Function",

		},
		{
			Name = "CancelUnitBuff",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "rank", Type = "string", Nilable = true },
				{ Name = "filter", Type = "string", Nilable = true },
			},

		},
		{
			Name = "GetWeaponEnchantInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "hasMainHandEnchant", Type = "bool", Nilable = true },
				{ Name = "mainHandExpiration", Type = "number", Nilable = true },
				{ Name = "mainHandCharges", Type = "number", Nilable = true },
				{ Name = "hasOffHandEnchant", Type = "bool", Nilable = true },
				{ Name = "offHandExpiration", Type = "number", Nilable = true },
				{ Name = "offHandCharges", Type = "number", Nilable = true },
			},
		},
		{
			Name = "UnitAura",
			Type = "Function",
			--[=[ Documentation =
			{
				"UnitAura(unit, index [, filter]) or UnitAura(unit, name [, rank [, filter]]). The numeric argument is an aura index, not a spell ID.",
				"Returns no values when no matching aura is available. The aura index is a position in the filtered list and is not a stable aura identifier.",
				"Filters are separated by spaces or |: HELPFUL, HARMFUL, PLAYER, RAID, CANCELABLE, NOT_CANCELABLE. RAID uses the client raid-buff/dispel filters.",
				"Defaults to HELPFUL; the last HELPFUL/HARMFUL token selects the list.",
				"For units represented only by cached group data, count is 1, duration and expires are 0, and caster and isStealable are nil. Zero duration does not necessarily mean a permanent aura.",
				"Returns eleven values, ending with isStealable, shouldConsolidate and spellID.",
			}, ]=]

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "indexOrName", Type = "LuaValueVariant", Nilable = false },
				{ Name = "rankOrFilter", Type = "string", Nilable = true, --[[ Documentation = { "Filter for an index lookup; rank for a name lookup." } ]] },
				{ Name = "filter", Type = "string", Nilable = true, --[[ Documentation = { "Used by a name lookup; pass nil for rank when filtering by name without a rank." } ]] },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "rank", Type = "string", Nilable = true },
				{ Name = "icon", Type = "string", Nilable = true },
				{ Name = "count", Type = "number", Nilable = true },
				{ Name = "dispelType", Type = "string", Nilable = true },
				{ Name = "duration", Type = "number", Nilable = true, --[[ Documentation = { "Seconds; zero when no duration is available." } ]] },
				{ Name = "expires", Type = "number", Nilable = true, --[[ Documentation = { "Expiration time in seconds on the GetTime() time base, or zero." } ]] },
				{ Name = "caster", Type = "UnitToken", Nilable = true, --[[ Documentation = { "An available unit token for the caster or its owner, not a GUID; may be nil." } ]] },
				{ Name = "isStealable", Type = "bool", Nilable = true },
				{ Name = "shouldConsolidate", Type = "bool", Nilable = true },
				{ Name = "spellID", Type = "number", Nilable = true },
			},
		},
		{
			Name = "UnitDebuff",
			Type = "Function",
			--[=[ Documentation =
			{
				"UnitDebuff(unit, index [, filter]) or UnitDebuff(unit, name [, rank [, filter]]). The numeric argument is an aura index, not a spell ID.",
				"Returns no values when no matching aura is available. The aura index is a position in the filtered list and is not a stable aura identifier.",
				"Filters are separated by spaces or |: HELPFUL, HARMFUL, PLAYER, RAID, CANCELABLE, NOT_CANCELABLE. RAID uses the client raid-buff/dispel filters.",
				"Always selects harmful auras.",
				"For units represented only by cached group data, count is 1, duration and expires are 0, and caster and isStealable are nil. Zero duration does not necessarily mean a permanent aura.",
				"Returns eleven values, ending with isStealable, shouldConsolidate and spellID.",
			}, ]=]

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "indexOrName", Type = "LuaValueVariant", Nilable = false },
				{ Name = "rankOrFilter", Type = "string", Nilable = true, --[[ Documentation = { "Filter for an index lookup; rank for a name lookup." } ]] },
				{ Name = "filter", Type = "string", Nilable = true, --[[ Documentation = { "Used by a name lookup; pass nil for rank when filtering by name without a rank." } ]] },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "rank", Type = "string", Nilable = true },
				{ Name = "icon", Type = "string", Nilable = true },
				{ Name = "count", Type = "number", Nilable = true },
				{ Name = "dispelType", Type = "string", Nilable = true },
				{ Name = "duration", Type = "number", Nilable = true, --[[ Documentation = { "Seconds; zero when no duration is available." } ]] },
				{ Name = "expires", Type = "number", Nilable = true, --[[ Documentation = { "Expiration time in seconds on the GetTime() time base, or zero." } ]] },
				{ Name = "caster", Type = "UnitToken", Nilable = true, --[[ Documentation = { "An available unit token for the caster or its owner, not a GUID; may be nil." } ]] },
				{ Name = "isStealable", Type = "bool", Nilable = true },
				{ Name = "shouldConsolidate", Type = "bool", Nilable = true },
				{ Name = "spellID", Type = "number", Nilable = true },
			},
		},
		{
			Name = "UnitBuff",
			Type = "Function",
			--[=[ Documentation =
			{
				"UnitBuff(unit, index [, filter]) or UnitBuff(unit, name [, rank [, filter]]). The numeric argument is an aura index, not a spell ID.",
				"Returns no values when no matching aura is available. The aura index is a position in the filtered list and is not a stable aura identifier.",
				"Filters are separated by spaces or |: HELPFUL, HARMFUL, PLAYER, RAID, CANCELABLE, NOT_CANCELABLE. RAID uses the client raid-buff/dispel filters.",
				"Always selects helpful auras.",
				"For units represented only by cached group data, count is 1, duration and expires are 0, and caster and isStealable are nil. Zero duration does not necessarily mean a permanent aura.",
				"Returns eleven values, ending with isStealable, shouldConsolidate and spellID.",
			}, ]=]

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "indexOrName", Type = "LuaValueVariant", Nilable = false },
				{ Name = "rankOrFilter", Type = "string", Nilable = true, --[[ Documentation = { "Filter for an index lookup; rank for a name lookup." } ]] },
				{ Name = "filter", Type = "string", Nilable = true, --[[ Documentation = { "Used by a name lookup; pass nil for rank when filtering by name without a rank." } ]] },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "rank", Type = "string", Nilable = true },
				{ Name = "icon", Type = "string", Nilable = true },
				{ Name = "count", Type = "number", Nilable = true },
				{ Name = "dispelType", Type = "string", Nilable = true },
				{ Name = "duration", Type = "number", Nilable = true, --[[ Documentation = { "Seconds; zero when no duration is available." } ]] },
				{ Name = "expires", Type = "number", Nilable = true, --[[ Documentation = { "Expiration time in seconds on the GetTime() time base, or zero." } ]] },
				{ Name = "caster", Type = "UnitToken", Nilable = true, --[[ Documentation = { "An available unit token for the caster or its owner, not a GUID; may be nil." } ]] },
				{ Name = "isStealable", Type = "bool", Nilable = true },
				{ Name = "shouldConsolidate", Type = "bool", Nilable = true },
				{ Name = "spellID", Type = "number", Nilable = true },
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

APIDocumentation:AddDocumentationTable(Buff);
