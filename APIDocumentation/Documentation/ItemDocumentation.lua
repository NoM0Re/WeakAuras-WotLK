local Item =
{
	Name = "Item",
	Type = "System",
	Namespace = "Item",

	Functions =
	{
		{
			Name = "BindEnchant",
			Type = "Function",

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
			Name = "ConfirmBindOnUse",
			Type = "Function",

		},
		{
			Name = "CursorHasItem",
			Type = "Function",

			Returns =
			{
				{ Name = "hasItem", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "DeleteCursorItem",
			Type = "Function",

		},
		{
			Name = "EndBoundTradeable",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

		},
		{
			Name = "EndRefund",
			Type = "Function",

			Arguments =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},

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
			Name = "GetItemCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "start", Type = "number", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "enable", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetItemCount",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemId", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
				{ Name = "includeBank", Type = "bool", Nilable = true },
				{ Name = "includeCharges", Type = "bool", Nilable = true },
			},

			Returns =
			{
				{ Name = "itemCount", Type = "number", Nilable = false },
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
			Name = "GetItemGem",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetItemIcon",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetItemInfo",
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
				{ Name = "link", Type = "string", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
				{ Name = "iLevel", Type = "number", Nilable = false },
				{ Name = "reqLevel", Type = "number", Nilable = false },
				{ Name = "class", Type = "string", Nilable = false },
				{ Name = "subclass", Type = "string", Nilable = false },
				{ Name = "maxStack", Type = "number", Nilable = false },
				{ Name = "equipSlot", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "vendorPrice", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetItemQualityColor",
			Type = "Function",

			Arguments =
			{
				{ Name = "quality", Type = "itemQuality", Nilable = false },
			},

			Returns =
			{
				{ Name = "redComponent", Type = "number", Nilable = false },
				{ Name = "greenComponent", Type = "number", Nilable = false },
				{ Name = "blueComponent", Type = "number", Nilable = false },
				{ Name = "hexColor", Type = "string", Nilable = false },
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
			Name = "GetItemStatDelta",
			Type = "Function",

			Arguments =
			{
				{ Name = "item1Link", Type = "string", Nilable = false },
				{ Name = "item2Link", Type = "string", Nilable = false },
				{ Name = "returnTable", Type = "table", Nilable = true },
			},

			Returns =
			{
				{ Name = "statTable", Type = "table", Nilable = false },
			},
		},
		{
			Name = "GetItemStats",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemLink", Type = "string", Nilable = false },
				{ Name = "returnTable", Type = "table", Nilable = true },
			},

			Returns =
			{
				{ Name = "statTable", Type = "table", Nilable = false },
			},
		},
		{
			Name = "GetItemUniqueness",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "uniqueFamily", Type = "number", Nilable = false },
				{ Name = "maxEquipped", Type = "number", Nilable = false },
			},
		},
		{
			Name = "IsConsumableItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "consumable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsCurrentItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isItem", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsDressableItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isDressable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsEquippableItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isEquippable", Type = "bool", Nilable = false },
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
			Name = "IsHarmfulItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isHarmful", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsHelpfulItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isHarmful", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsItemInRange",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
			},

			Returns =
			{
				{ Name = "inRange", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsUsableItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isUsable", Type = "bool", Nilable = false },
				{ Name = "notEnoughMana", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ItemHasRange",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "hasRange", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PickupItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemID", Type = "number", Nilable = true },
				{ Name = "itemName", Type = "string", Nilable = true },
				{ Name = "itemLink", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ReplaceEnchant",
			Type = "Function",

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
			Name = "UseItemByName",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "target", Type = "string", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "CloseInboxItem",
			Type = "Event",
			LiteralName = "CLOSE_INBOX_ITEM",
			Payload =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},
		},
		{
			Name = "DeleteItemConfirm",
			Type = "Event",
			LiteralName = "DELETE_ITEM_CONFIRM",
			Payload =
			{
				{ Name = "itemName", Type = "string", Nilable = false },
				{ Name = "itemQuality", Type = "number", Nilable = false },
			},
		},
		{
			Name = "ItemLocked",
			Type = "Event",
			LiteralName = "ITEM_LOCKED",
		},
		{
			Name = "ItemLockChanged",
			Type = "Event",
			LiteralName = "ITEM_LOCK_CHANGED",
		},
		{
			Name = "ItemPush",
			Type = "Event",
			LiteralName = "ITEM_PUSH",
			Payload =
			{
				{ Name = "bagID", Type = "number", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
			},
		},
		{
			Name = "ItemUnlocked",
			Type = "Event",
			LiteralName = "ITEM_UNLOCKED",
		},
		{
			Name = "MailLockSendItems",
			Type = "Event",
			LiteralName = "MAIL_LOCK_SEND_ITEMS",
		},
		{
			Name = "MailUnlockSendItems",
			Type = "Event",
			LiteralName = "MAIL_UNLOCK_SEND_ITEMS",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Item);
