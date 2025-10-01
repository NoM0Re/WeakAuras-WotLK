local Action =
{
	Name = "Action",
	Type = "System",
	Namespace = "Action",

	Functions =
	{
		{
			Name = "ActionHasRange",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "hasRange", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CastPetAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
			},

		},
		{
			Name = "GetActionAutocast",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "autocastAllowed", Type = "bool", Nilable = false },
				{ Name = "autocastEnabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetActionCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "start", Type = "number", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "enable", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetActionCount",
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
			Name = "GetActionInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "subType", Type = "string", Nilable = false },
				{ Name = "spellID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetActionText",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetActionTexture",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetPetActionCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "start", Type = "number", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "enable", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPetActionInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "subtext", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "isToken", Type = "bool", Nilable = false },
				{ Name = "isActive", Type = "bool", Nilable = false },
				{ Name = "autoCastAllowed", Type = "bool", Nilable = false },
				{ Name = "autoCastEnabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetPetActionSlotUsable",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "usable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetPetActionsUsable",
			Type = "Function",

			Returns =
			{
				{ Name = "petActionsUsable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "HasAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "hasAction", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsActionInRange",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "inRange", Type = "number", Nilable = false },
			},
		},
		{
			Name = "IsAttackAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isAttack", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsAutoRepeatAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isRepeating", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsConsumableAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isConsumable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsCurrentAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isCurrent", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsEquippedAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isEquipped", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsStackableAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isStackable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsUsableAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isUsable", Type = "bool", Nilable = false },
				{ Name = "notEnoughMana", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PickupAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "PickupPetAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "PlaceAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "TogglePetAutocast",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "UseAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
				{ Name = "target", Type = "string", Nilable = false },
				{ Name = "button", Type = "string", Nilable = true },
			},

		},
	},

	Events =
	{
		{
			Name = "AddonActionBlocked",
			Type = "Event",
			LiteralName = "ADDON_ACTION_BLOCKED",
		},
		{
			Name = "AddonActionForbidden",
			Type = "Event",
			LiteralName = "ADDON_ACTION_FORBIDDEN",
			Payload =
			{
				{ Name = "culprit", Type = "string", Nilable = false },
			},
		},
		{
			Name = "MacroActionBlocked",
			Type = "Event",
			LiteralName = "MACRO_ACTION_BLOCKED",
		},
		{
			Name = "MacroActionForbidden",
			Type = "Event",
			LiteralName = "MACRO_ACTION_FORBIDDEN",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Action);
