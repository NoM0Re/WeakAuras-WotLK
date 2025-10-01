local Bank =
{
	Name = "Bank",
	Type = "System",
	Namespace = "Bank",

	Functions =
	{
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
			Name = "CloseBankFrame",
			Type = "Function",

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
			Name = "GetBankSlotCost",
			Type = "Function",

			Returns =
			{
				{ Name = "cost", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumBankSlots",
			Type = "Function",

			Returns =
			{
				{ Name = "numSlots", Type = "number", Nilable = false },
				{ Name = "isFull", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PurchaseSlot",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "BankframeClosed",
			Type = "Event",
			LiteralName = "BANKFRAME_CLOSED",
		},
		{
			Name = "BankframeOpened",
			Type = "Event",
			LiteralName = "BANKFRAME_OPENED",
		},
		{
			Name = "PlayerbankbagslotsChanged",
			Type = "Event",
			LiteralName = "PLAYERBANKBAGSLOTS_CHANGED",
		},
		{
			Name = "PlayerbankslotsChanged",
			Type = "Event",
			LiteralName = "PLAYERBANKSLOTS_CHANGED",
			Payload =
			{
				{ Name = "slotID", Type = "number", Nilable = false },
			},
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Bank);
