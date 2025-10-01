local Cursor =
{
	Name = "Cursor",
	Type = "System",
	Namespace = "Cursor",

	Functions =
	{
		{
			Name = "AddTradeMoney",
			Type = "Function",

		},
		{
			Name = "AutoEquipCursorItem",
			Type = "Function",

		},
		{
			Name = "ClearCursor",
			Type = "Function",

		},
		{
			Name = "ClickAuctionSellItemButton",
			Type = "Function",

		},
		{
			Name = "ClickSendMailItemButton",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "autoReturn", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "ClickSocketButton",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "ClickTargetTradeButton",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "ClickTradeButton",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
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
			Name = "CursorHasItem",
			Type = "Function",

			Returns =
			{
				{ Name = "hasItem", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CursorHasMacro",
			Type = "Function",

			Returns =
			{
				{ Name = "hasMacro", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CursorHasMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "hasMoney", Type = "bool", Nilable = false },
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
			Name = "DeleteCursorItem",
			Type = "Function",

		},
		{
			Name = "DropCursorMoney",
			Type = "Function",

		},
		{
			Name = "DropItemOnUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "EquipCursorItem",
			Type = "Function",

		},
		{
			Name = "GetCursorInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "data", Type = "number", Nilable = false },
				{ Name = "subType", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetCursorMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "cursorMoney", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCursorPosition",
			Type = "Function",

			Returns =
			{
				{ Name = "cursorX", Type = "number", Nilable = false },
				{ Name = "cursorY", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetMouseFocus",
			Type = "Function",

			Returns =
			{
				{ Name = "frame", Type = "frame", Nilable = false },
			},
		},
		{
			Name = "HideRepairCursor",
			Type = "Function",

		},
		{
			Name = "InRepairMode",
			Type = "Function",

			Returns =
			{
				{ Name = "inRepair", Type = "bool", Nilable = false },
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
			Name = "PickupBagFromSlot",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "PickupCompanion",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
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
			Name = "PickupGuildBankItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "PickupGuildBankMoney",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
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
			Name = "PickupMacro",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "PickupMerchantItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
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
			Name = "PickupPlayerMoney",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
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
			Name = "PickupStablePet",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "PickupTradeMoney",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
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
			Name = "ResetCursor",
			Type = "Function",

		},
		{
			Name = "SetCursor",
			Type = "Function",

		},
		{
			Name = "ShowBuybackSellCursor",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "ShowContainerSellCursor",
			Type = "Function",

			Arguments =
			{
				{ Name = "container", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "ShowInventorySellCursor",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "ShowMerchantSellCursor",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "ShowRepairCursor",
			Type = "Function",

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
			Name = "SplitGuildBankItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "tab", Type = "number", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
				{ Name = "amount", Type = "number", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "CursorUpdate",
			Type = "Event",
			LiteralName = "CURSOR_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Cursor);
