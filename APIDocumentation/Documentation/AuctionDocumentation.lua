local Auction =
{
	Name = "Auction",
	Type = "System",
	Namespace = "Auction",

	Functions =
	{
		{
			Name = "CalculateAuctionDeposit",
			Type = "Function",

			Arguments =
			{
				{ Name = "runTime", Type = "time_t", Nilable = false },
			},

			Returns =
			{
				{ Name = "deposit", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CanCancelAuction",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "canCancel", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanSendAuctionQuery",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "canQuery", Type = "bool", Nilable = false },
				{ Name = "canMassQuery", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CancelAuction",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "canCancel", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ClickAuctionSellItemButton",
			Type = "Function",

		},
		{
			Name = "CloseAuctionHouse",
			Type = "Function",

		},
		{
			Name = "GetAuctionHouseDepositRate",
			Type = "Function",

			Returns =
			{
				{ Name = "rate", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetAuctionInvTypes",
			Type = "Function",

			Arguments =
			{
				{ Name = "classIndex", Type = "luaIndex", Nilable = false },
				{ Name = "subClassIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "token", Type = "string", Nilable = false },
				{ Name = "display", Type = "bool", Nilable = false },
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetAuctionItemClasses",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetAuctionItemInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
				{ Name = "canUse", Type = "1nil", Nilable = false },
				{ Name = "level", Type = "number", Nilable = false },
				{ Name = "minBid", Type = "number", Nilable = false },
				{ Name = "minIncrement", Type = "number", Nilable = false },
				{ Name = "buyoutPrice", Type = "number", Nilable = false },
				{ Name = "bidAmount", Type = "number", Nilable = false },
				{ Name = "highestBidder", Type = "1nil", Nilable = false },
				{ Name = "owner", Type = "string", Nilable = false },
				{ Name = "sold", Type = "1nil", Nilable = false },
			},
		},
		{
			Name = "GetAuctionItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetAuctionItemSubClasses",
			Type = "Function",

			Arguments =
			{
				{ Name = "classIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetAuctionItemTimeLeft",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "duration", Type = "time_t", Nilable = false },
			},
		},
		{
			Name = "GetAuctionSellItemInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
				{ Name = "canUse", Type = "1nil", Nilable = false },
				{ Name = "price", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetAuctionSort",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "criterion", Type = "string", Nilable = false },
				{ Name = "reverse", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetBidderAuctionItems",
			Type = "Function",

		},
		{
			Name = "GetInboxInvoiceInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "invoiceType", Type = "string", Nilable = false },
				{ Name = "itemName", Type = "string", Nilable = false },
				{ Name = "playerName", Type = "string", Nilable = false },
				{ Name = "bid", Type = "number", Nilable = false },
				{ Name = "buyout", Type = "number", Nilable = false },
				{ Name = "deposit", Type = "number", Nilable = false },
				{ Name = "consignment", Type = "number", Nilable = false },
				{ Name = "moneyDelay", Type = "number", Nilable = false },
				{ Name = "etaHour", Type = "number", Nilable = false },
				{ Name = "etaMin", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumAuctionItems",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "numBatchAuctions", Type = "number", Nilable = false },
				{ Name = "totalAuctions", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetOwnerAuctionItems",
			Type = "Function",

		},
		{
			Name = "GetSelectedAuctionItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "IsAuctionSortReversed",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
				{ Name = "sort", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "isReversed", Type = "bool", Nilable = false },
				{ Name = "isSorted", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PlaceAuctionBid",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "bid", Type = "number", Nilable = false },
			},

		},
		{
			Name = "QueryAuctionItems",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "minLevel", Type = "number", Nilable = false },
				{ Name = "maxLevel", Type = "number", Nilable = false },
				{ Name = "invTypeIndex", Type = "luaIndex", Nilable = false },
				{ Name = "classIndex", Type = "luaIndex", Nilable = false },
				{ Name = "subClassIndex", Type = "luaIndex", Nilable = false },
				{ Name = "page", Type = "number", Nilable = false },
				{ Name = "isUsable", Type = "bool", Nilable = false },
				{ Name = "minQuality", Type = "itemQuality", Nilable = false },
				{ Name = "getAll", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "SetSelectedAuctionItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SortAuctionApplySort",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SortAuctionClearSort",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SortAuctionItems",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "sort", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SortAuctionSetSort",
			Type = "Function",

			Arguments =
			{
				{ Name = "list", Type = "string", Nilable = false },
				{ Name = "sort", Type = "number", Nilable = false },
				{ Name = "reversed", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "StartAuction",
			Type = "Function",

			Arguments =
			{
				{ Name = "minBid", Type = "number", Nilable = false },
				{ Name = "buyoutPrice", Type = "number", Nilable = false },
				{ Name = "runTime", Type = "time_t", Nilable = false },
				{ Name = "stackSize", Type = "number", Nilable = false },
				{ Name = "numStacks", Type = "number", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "AuctionBidderListUpdate",
			Type = "Event",
			LiteralName = "AUCTION_BIDDER_LIST_UPDATE",
		},
		{
			Name = "AuctionHouseClosed",
			Type = "Event",
			LiteralName = "AUCTION_HOUSE_CLOSED",
		},
		{
			Name = "AuctionHouseDisabled",
			Type = "Event",
			LiteralName = "AUCTION_HOUSE_DISABLED",
		},
		{
			Name = "AuctionHouseShow",
			Type = "Event",
			LiteralName = "AUCTION_HOUSE_SHOW",
		},
		{
			Name = "AuctionItemListUpdate",
			Type = "Event",
			LiteralName = "AUCTION_ITEM_LIST_UPDATE",
		},
		{
			Name = "AuctionMultisellFailure",
			Type = "Event",
			LiteralName = "AUCTION_MULTISELL_FAILURE",
		},
		{
			Name = "AuctionMultisellStart",
			Type = "Event",
			LiteralName = "AUCTION_MULTISELL_START",
			Payload =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "AuctionMultisellUpdate",
			Type = "Event",
			LiteralName = "AUCTION_MULTISELL_UPDATE",
			Payload =
			{
				{ Name = "createdAmount", Type = "number", Nilable = false },
				{ Name = "amount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "AuctionOwnedListUpdate",
			Type = "Event",
			LiteralName = "AUCTION_OWNED_LIST_UPDATE",
		},
		{
			Name = "NewAuctionUpdate",
			Type = "Event",
			LiteralName = "NEW_AUCTION_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Auction);
