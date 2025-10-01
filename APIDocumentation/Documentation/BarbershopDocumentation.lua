local Barbershop =
{
	Name = "Barbershop",
	Type = "System",
	Namespace = "Barbershop",

	Functions =
	{
		{
			Name = "ApplyBarberShopStyle",
			Type = "Function",

		},
		{
			Name = "BarberShopReset",
			Type = "Function",

		},
		{
			Name = "CanAlterSkin",
			Type = "Function",

			Returns =
			{
				{ Name = "canAlter", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CancelBarberShop",
			Type = "Function",

		},
		{
			Name = "GetBarberShopStyleInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "styleIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "unused", Type = "string", Nilable = false },
				{ Name = "cost", Type = "number", Nilable = false },
				{ Name = "isCurrent", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetBarberShopTotalCost",
			Type = "Function",

			Returns =
			{
				{ Name = "cost", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetFacialHairCustomization",
			Type = "Function",

			Returns =
			{
				{ Name = "token", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetHairCustomization",
			Type = "Function",

			Returns =
			{
				{ Name = "token", Type = "string", Nilable = false },
			},
		},
		{
			Name = "SetNextBarberShopStyle",
			Type = "Function",

			Arguments =
			{
				{ Name = "styleIndex", Type = "luaIndex", Nilable = false },
				{ Name = "reverse", Type = "bool", Nilable = true },
			},

		},
	},

	Events =
	{
		{
			Name = "BarberShopAppearanceApplied",
			Type = "Event",
			LiteralName = "BARBER_SHOP_APPEARANCE_APPLIED",
		},
		{
			Name = "BarberShopClose",
			Type = "Event",
			LiteralName = "BARBER_SHOP_CLOSE",
		},
		{
			Name = "BarberShopOpen",
			Type = "Event",
			LiteralName = "BARBER_SHOP_OPEN",
		},
		{
			Name = "BarberShopSuccess",
			Type = "Event",
			LiteralName = "BARBER_SHOP_SUCCESS",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Barbershop);
