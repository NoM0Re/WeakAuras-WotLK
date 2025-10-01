local Loot =
{
	Name = "Loot",
	Type = "System",
	Namespace = "Loot",

	Functions =
	{
		{
			Name = "CloseLoot",
			Type = "Function",

		},
		{
			Name = "ConfirmLootRoll",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "rollType", Type = "number", Nilable = false },
			},

		},
		{
			Name = "ConfirmLootSlot",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "GetLootMethod",
			Type = "Function",

			Returns =
			{
				{ Name = "method", Type = "string", Nilable = false },
				{ Name = "partyMaster", Type = "number", Nilable = false },
				{ Name = "raidMaster", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetLootRollItemInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
				{ Name = "bindOnPickUp", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetLootRollItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetLootRollTimeLeft",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "timeLeft", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetLootSlotInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "item", Type = "string", Nilable = false },
				{ Name = "quantity", Type = "number", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
				{ Name = "locked", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetLootSlotLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetLootThreshold",
			Type = "Function",

			Returns =
			{
				{ Name = "threshold", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetMasterLootCandidate",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "candidate", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetNumLootItems",
			Type = "Function",

			Returns =
			{
				{ Name = "numItems", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetOptOutOfLoot",
			Type = "Function",

			Returns =
			{
				{ Name = "isOptOut", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GiveMasterLoot",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "IsFishingLoot",
			Type = "Function",

			Returns =
			{
				{ Name = "isFishing", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "LootSlot",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "LootSlotIsCoin",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isCoin", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "LootSlotIsItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isItem", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "RollOnLoot",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "rollType", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetLootMethod",
			Type = "Function",

			Arguments =
			{
				{ Name = "method", Type = "string", Nilable = false },
				{ Name = "master", Type = "string", Nilable = true },
			},

		},
		{
			Name = "SetLootPortrait",
			Type = "Function",

			Arguments =
			{
				{ Name = "texture", Type = "table", Nilable = false },
			},

		},
		{
			Name = "SetLootThreshold",
			Type = "Function",

			Arguments =
			{
				{ Name = "threshold", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetOptOutOfLoot",
			Type = "Function",

			Arguments =
			{
				{ Name = "enable", Type = "bool", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "CancelLootRoll",
			Type = "Event",
			LiteralName = "CANCEL_LOOT_ROLL",
			Payload =
			{
				{ Name = "rollID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "ConfirmLootRoll",
			Type = "Event",
			LiteralName = "CONFIRM_LOOT_ROLL",
			Payload =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "rolltype", Type = "number", Nilable = false },
			},
		},
		{
			Name = "LootBindConfirm",
			Type = "Event",
			LiteralName = "LOOT_BIND_CONFIRM",
			Payload =
			{
				{ Name = "slotID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "LootClosed",
			Type = "Event",
			LiteralName = "LOOT_CLOSED",
		},
		{
			Name = "LootOpened",
			Type = "Event",
			LiteralName = "LOOT_OPENED",
			Payload =
			{
				{ Name = "autoLoot", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "LootSlotChanged",
			Type = "Event",
			LiteralName = "LOOT_SLOT_CHANGED",
		},
		{
			Name = "LootSlotCleared",
			Type = "Event",
			LiteralName = "LOOT_SLOT_CLEARED",
			Payload =
			{
				{ Name = "slotID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "OpenMasterLootList",
			Type = "Event",
			LiteralName = "OPEN_MASTER_LOOT_LIST",
		},
		{
			Name = "StartLootRoll",
			Type = "Event",
			LiteralName = "START_LOOT_ROLL",
			Payload =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "time", Type = "time_t", Nilable = false },
			},
		},
		{
			Name = "UpdateMasterLootList",
			Type = "Event",
			LiteralName = "UPDATE_MASTER_LOOT_LIST",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Loot);
