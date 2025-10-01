local EquipmentManager =
{
	Name = "Equipment Manager",
	Type = "System",
	Namespace = "Equipment Manager",

	Functions =
	{
		{
			Name = "CanUseEquipmentSets",
			Type = "Function",

			Returns =
			{
				{ Name = "enabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "DeleteEquipmentSet",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "EquipmentManagerClearIgnoredSlotsForSave",
			Type = "Function",

		},
		{
			Name = "EquipmentManagerIgnoreSlotForSave",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "EquipmentManagerIsSlotIgnoredForSave",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isIgnored", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "EquipmentManagerUnignoreSlotForSave",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "EquipmentManager_UnpackLocation",
			Type = "Function",

			Arguments =
			{
				{ Name = "location", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "player", Type = "bool", Nilable = false },
				{ Name = "bank", Type = "bool", Nilable = false },
				{ Name = "bags", Type = "bool", Nilable = false },
				{ Name = "location or slot", Type = "number", Nilable = false },
				{ Name = "bag", Type = "number", Nilable = false },
			},
		},
		{
			Name = "EquipmentSetContainsLockedItems",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "isLocked", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetEquipmentSetInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "setID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetEquipmentSetInfoByName",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "setID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetEquipmentSetItemIDs",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "itemIDs", Type = "table", Nilable = false },
			},
		},
		{
			Name = "GetEquipmentSetLocations",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "itemIDs", Type = "table", Nilable = false },
			},
		},
		{
			Name = "GetNumEquipmentSets",
			Type = "Function",

			Returns =
			{
				{ Name = "numSets", Type = "number", Nilable = false },
			},
		},
		{
			Name = "PickupEquipmentSet",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "PickupEquipmentSetByName",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SaveEquipmentSet",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "icon", Type = "number", Nilable = false },
			},

		},
		{
			Name = "UseEquipmentSet",
			Type = "Function",

			Returns =
			{
				{ Name = "enabled", Type = "bool", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "AutoequipBindConfirm",
			Type = "Event",
			LiteralName = "AUTOEQUIP_BIND_CONFIRM",
			Payload =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},
		},
		{
			Name = "EquipmentSetsChanged",
			Type = "Event",
			LiteralName = "EQUIPMENT_SETS_CHANGED",
		},
		{
			Name = "EquipmentSwapFinished",
			Type = "Event",
			LiteralName = "EQUIPMENT_SWAP_FINISHED",
		},
		{
			Name = "EquipmentSwapPending",
			Type = "Event",
			LiteralName = "EQUIPMENT_SWAP_PENDING",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(EquipmentManager);
