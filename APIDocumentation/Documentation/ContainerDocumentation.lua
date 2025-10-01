local Container =
{
	Name = "Container",
	Type = "System",
	Namespace = "Container",

	Functions =
	{
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
			Name = "ContainerRefundItemPurchase",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
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
			Name = "GetBagName",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetContainerFreeSlots",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "returnTable", Type = "table", Nilable = true },
			},

			Returns =
			{
				{ Name = "slotTable", Type = "table", Nilable = false },
			},
		},
		{
			Name = "GetContainerItemCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
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
			Name = "GetContainerItemDurability",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "durability", Type = "number", Nilable = false },
				{ Name = "max", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetContainerItemGems",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
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
			Name = "GetContainerItemID",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetContainerItemInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "locked", Type = "1nil", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
				{ Name = "readable", Type = "1nil", Nilable = false },
				{ Name = "lootable", Type = "1nil", Nilable = false },
				{ Name = "link", Type = "itemLink", Nilable = false },
			},
		},
		{
			Name = "GetContainerItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetContainerItemPurchaseInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
				{ Name = "IsEquipped", Type = "bool", Nilable = false },
			},

			Returns =
			{
				{ Name = "money", Type = "number", Nilable = false },
				{ Name = "itemCount", Type = "number", Nilable = false },
				{ Name = "refundSec", Type = "number", Nilable = false },
				{ Name = "currecycount", Type = "number", Nilable = false },
				{ Name = "hasEnchants", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetContainerItemPurchaseItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "quantity", Type = "number", Nilable = false },
				{ Name = "link", Type = "itemLink", Nilable = false },
			},
		},
		{
			Name = "GetContainerNumFreeSlots",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "freeSlots", Type = "number", Nilable = false },
				{ Name = "bagType", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetContainerNumSlots",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "numSlots", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetItemFamily",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "bagType", Type = "number", Nilable = false },
			},
		},
		{
			Name = "PickupBagFromSlot",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "PickupContainerItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "PutItemInBackpack",
			Type = "Function",

			Returns =
			{
				{ Name = "hadItem", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PutItemInBag",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "hadItem", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetBagPortraitTexture",
			Type = "Function",

			Arguments =
			{
				{ Name = "texture", Type = "table", Nilable = false },
				{ Name = "container", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SocketContainerItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SplitContainerItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
				{ Name = "amount", Type = "number", Nilable = false },
			},

		},
		{
			Name = "UseContainerItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
				{ Name = "target", Type = "string", Nilable = true },
			},

		},
	},

	Events =
	{
		{
			Name = "BagClosed",
			Type = "Event",
			LiteralName = "BAG_CLOSED",
			Payload =
			{
				{ Name = "bagID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "BagOpen",
			Type = "Event",
			LiteralName = "BAG_OPEN",
			Payload =
			{
				{ Name = "bagID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "BagUpdate",
			Type = "Event",
			LiteralName = "BAG_UPDATE",
			Payload =
			{
				{ Name = "bagID", Type = "containerID", Nilable = false },
			},
		},
		{
			Name = "BagUpdateCooldown",
			Type = "Event",
			LiteralName = "BAG_UPDATE_COOLDOWN",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Container);
