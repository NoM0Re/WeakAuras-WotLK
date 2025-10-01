local Mail =
{
	Name = "Mail",
	Type = "System",
	Namespace = "Mail",

	Functions =
	{
		{
			Name = "AutoLootMailItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CanComplainInboxItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "complain", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CheckInbox",
			Type = "Function",

		},
		{
			Name = "ClearSendMail",
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
			Name = "CloseMail",
			Type = "Function",

		},
		{
			Name = "ComplainInboxItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "complain", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "DeleteInboxItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
			},

		},
		{
			Name = "GetInboxHeaderInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "packageIcon", Type = "string", Nilable = false },
				{ Name = "stationeryIcon", Type = "string", Nilable = false },
				{ Name = "sender", Type = "string", Nilable = false },
				{ Name = "subject", Type = "string", Nilable = false },
				{ Name = "money", Type = "number", Nilable = false },
				{ Name = "CODAmount", Type = "number", Nilable = false },
				{ Name = "daysLeft", Type = "number", Nilable = false },
				{ Name = "itemCount", Type = "number", Nilable = false },
				{ Name = "wasRead", Type = "bool", Nilable = false },
				{ Name = "wasReturned", Type = "bool", Nilable = false },
				{ Name = "textCreated", Type = "bool", Nilable = false },
				{ Name = "canReply", Type = "bool", Nilable = false },
				{ Name = "isGM", Type = "bool", Nilable = false },
				{ Name = "itemQuantity", Type = "number", Nilable = false },
			},
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
			Name = "GetInboxItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
				{ Name = "attachmentIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "itemTexture", Type = "string", Nilable = false },
				{ Name = "count", Type = "number", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
				{ Name = "canUse", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetInboxItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
				{ Name = "attachmentIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "itemlink", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetInboxNumItems",
			Type = "Function",

			Returns =
			{
				{ Name = "numItems", Type = "number", Nilable = false },
				{ Name = "totalItems", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetInboxText",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "bodyText", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "isTakeable", Type = "bool", Nilable = false },
				{ Name = "isInvoice", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetLatestThreeSenders",
			Type = "Function",

			Returns =
			{
				{ Name = "sender1", Type = "string", Nilable = false },
				{ Name = "sender2", Type = "string", Nilable = false },
				{ Name = "sender3", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetNumPackages",
			Type = "Function",

		},
		{
			Name = "GetNumStationeries",
			Type = "Function",

			Returns =
			{
				{ Name = "numStationeries", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPackageInfo",
			Type = "Function",

		},
		{
			Name = "GetSelectedStationeryTexture",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetSendMailCOD",
			Type = "Function",

			Returns =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSendMailItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "itemName", Type = "string", Nilable = false },
				{ Name = "itemTexture", Type = "string", Nilable = false },
				{ Name = "stackCount", Type = "string", Nilable = false },
				{ Name = "quality", Type = "itemQuality", Nilable = false },
			},
		},
		{
			Name = "GetSendMailItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "itemlink", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetSendMailMoney",
			Type = "Function",

			Returns =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSendMailPrice",
			Type = "Function",

			Returns =
			{
				{ Name = "price", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetStationeryInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "cost", Type = "number", Nilable = false },
			},
		},
		{
			Name = "HasNewMail",
			Type = "Function",

			Returns =
			{
				{ Name = "hasMail", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "InboxItemCanDelete",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "canDelete", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ReturnInboxItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SelectPackage",
			Type = "Function",

		},
		{
			Name = "SelectStationery",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SendMail",
			Type = "Function",

		},
		{
			Name = "SetSendMailCOD",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetSendMailMoney",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "success", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetSendMailShowing",
			Type = "Function",

			Arguments =
			{
				{ Name = "enable", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "TakeInboxItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
				{ Name = "attachmentIndex", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "TakeInboxMoney",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
			},

		},
		{
			Name = "TakeInboxTextItem",
			Type = "Function",

			Arguments =
			{
				{ Name = "mailID", Type = "number", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "MailClosed",
			Type = "Event",
			LiteralName = "MAIL_CLOSED",
		},
		{
			Name = "MailFailed",
			Type = "Event",
			LiteralName = "MAIL_FAILED",
		},
		{
			Name = "MailInboxUpdate",
			Type = "Event",
			LiteralName = "MAIL_INBOX_UPDATE",
		},
		{
			Name = "MailSendInfoUpdate",
			Type = "Event",
			LiteralName = "MAIL_SEND_INFO_UPDATE",
		},
		{
			Name = "MailSendSuccess",
			Type = "Event",
			LiteralName = "MAIL_SEND_SUCCESS",
		},
		{
			Name = "MailShow",
			Type = "Event",
			LiteralName = "MAIL_SHOW",
		},
		{
			Name = "MailSuccess",
			Type = "Event",
			LiteralName = "MAIL_SUCCESS",
		},
		{
			Name = "SendMailCodChanged",
			Type = "Event",
			LiteralName = "SEND_MAIL_COD_CHANGED",
		},
		{
			Name = "UpdatePendingMail",
			Type = "Event",
			LiteralName = "UPDATE_PENDING_MAIL",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Mail);
