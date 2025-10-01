local Inventory =
{
	Name = "Inventory",
	Type = "System",
	Namespace = "Inventory",

	Functions =
	{
		{
			Name = "AutoEquipCursorItem",
			Type = "Function",

		},
		{
			Name = "BankButtonIDToInvSlotID",
			Type = "Function",

			Arguments =
			{
				{ Name = "buttonID", Type = "number", Nilable = false },
				{ Name = "isBag", Type = "bool", Nilable = true },
			},

			Returns =
			{
				{ Name = "inventoryID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CancelPendingEquip",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "ContainerIDToInventoryID",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "inventoryID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CursorCanGoInSlot",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "canBePlaced", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "EquipCursorItem",
			Type = "Function",

		},
		{
			Name = "EquipItemByName",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

		},
		{
			Name = "EquipPendingItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
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
			Name = "GetInventoryAlertStatus",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "status", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetInventoryItemBroken",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isBroken", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetInventoryItemCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
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
			Name = "GetInventoryItemCount",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "count", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetInventoryItemDurability",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "durability", Type = "number", Nilable = false },
				{ Name = "max", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetInventoryItemGems",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "gem1", Type = "number", Nilable = false },
				{ Name = "gem2", Type = "number", Nilable = false },
				{ Name = "gem3", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetInventoryItemID",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetInventoryItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetInventoryItemQuality",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "quality", Type = "itemQuality", Nilable = false },
			},
		},
		{
			Name = "GetInventoryItemTexture",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetInventoryItemsForSlot",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "availableItems", Type = "table", Nilable = false },
			},
		},
		{
			Name = "GetInventorySlotInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "slotName", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "checkRelic", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsEquippedItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isEquipped", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsEquippedItemType",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "isEquipped", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsInventoryItemLocked",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "isLocked", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "KeyRingButtonIDToInvSlotID",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},
		},
		{
			Name = "PickupInventoryItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetInventoryPortraitTexture",
			Type = "Function",

			Arguments =
			{
				{ Name = "texture", Type = "table", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SocketInventoryItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "UpdateInventoryAlertStatus",
			Type = "Function",

		},
		{
			Name = "UseInventoryItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "UnitInventoryChanged",
			Type = "Event",
			LiteralName = "UNIT_INVENTORY_CHANGED",
			Payload =
			{
				{ Name = "unitID", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "UpdateInventoryAlerts",
			Type = "Event",
			LiteralName = "UPDATE_INVENTORY_ALERTS",
		},
		{
			Name = "UpdateInventoryDurability",
			Type = "Event",
			LiteralName = "UPDATE_INVENTORY_DURABILITY",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Inventory);
