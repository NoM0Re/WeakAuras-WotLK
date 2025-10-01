local Petition =
{
	Name = "Petition",
	Type = "System",
	Namespace = "Petition",

	Functions =
	{
		{
			Name = "BuyGuildCharter",
			Type = "Function",

			Arguments =
			{
				{ Name = "guildName", Type = "string", Nilable = false },
			},

		},
		{
			Name = "CanSignPetition",
			Type = "Function",

			Returns =
			{
				{ Name = "canSign", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ClickPetitionButton",
			Type = "Function",

		},
		{
			Name = "ClosePetition",
			Type = "Function",

		},
		{
			Name = "GetGuildCharterCost",
			Type = "Function",

			Returns =
			{
				{ Name = "cost", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumPetitionItems",
			Type = "Function",

		},
		{
			Name = "GetNumPetitionNames",
			Type = "Function",

			Returns =
			{
				{ Name = "numNames", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPetitionInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "petitionType", Type = "string", Nilable = false },
				{ Name = "title", Type = "string", Nilable = false },
				{ Name = "bodyText", Type = "string", Nilable = false },
				{ Name = "maxSignatures", Type = "number", Nilable = false },
				{ Name = "originatorName", Type = "string", Nilable = false },
				{ Name = "isOriginator", Type = "bool", Nilable = false },
				{ Name = "minSignatures", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPetitionNameInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "OfferPetition",
			Type = "Function",

		},
		{
			Name = "RenamePetition",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SignPetition",
			Type = "Function",

			Returns =
			{
				{ Name = "canSign", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "TurnInGuildCharter",
			Type = "Function",

		},
		{
			Name = "TurnInPetition",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "PetitionClosed",
			Type = "Event",
			LiteralName = "PETITION_CLOSED",
		},
		{
			Name = "PetitionShow",
			Type = "Event",
			LiteralName = "PETITION_SHOW",
		},
		{
			Name = "PetitionVendorClosed",
			Type = "Event",
			LiteralName = "PETITION_VENDOR_CLOSED",
		},
		{
			Name = "PetitionVendorShow",
			Type = "Event",
			LiteralName = "PETITION_VENDOR_SHOW",
		},
		{
			Name = "PetitionVendorUpdate",
			Type = "Event",
			LiteralName = "PETITION_VENDOR_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Petition);
