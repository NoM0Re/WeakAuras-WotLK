local Buff =
{
	Name = "Buff",
	Type = "System",
	Namespace = "",

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
				{ Name = "unit", Type = "string", Nilable = true },
				{ Name = "index", Type = "number", Nilable = true },
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
				{ Name = "hasMainHandEnchant", Type = "bool", Nilable = false },
				{ Name = "mainHandExpiration", Type = "number", Nilable = false },
				{ Name = "mainHandCharges", Type = "number", Nilable = false },
				{ Name = "hasOffHandEnchant", Type = "bool", Nilable = false },
				{ Name = "offHandExpiration", Type = "number", Nilable = false },
				{ Name = "offHandCharges", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitAura",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "string", Nilable = false },
				{ Name = "index", Type = "number", Nilable = true },
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
				{ Name = "duration", Type = "number", Nilable = false },
				{ Name = "expires", Type = "number", Nilable = false },
				{ Name = "caster", Type = "string", Nilable = false },
				{ Name = "isStealable", Type = "1nil", Nilable = false },
				{ Name = "shouldConsolidate", Type = "bool", Nilable = false },
				{ Name = "spellID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitDebuff",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "string", Nilable = false },
				{ Name = "index", Type = "number", Nilable = true },
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
				{ Name = "duration", Type = "number", Nilable = false },
				{ Name = "expires", Type = "number", Nilable = false },
				{ Name = "caster", Type = "string", Nilable = false },
				{ Name = "isStealable", Type = "1nil", Nilable = false },
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
