local PetStable =
{
	Name = "Pet Stable",
	Type = "System",
	Namespace = "Pet Stable",

	Functions =
	{
		{
			Name = "BuyStableSlot",
			Type = "Function",

		},
		{
			Name = "ClickStablePet",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "selected", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "ClosePetStables",
			Type = "Function",

		},
		{
			Name = "GetNumStablePets",
			Type = "Function",

			Returns =
			{
				{ Name = "numPets", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSelectedStablePet",
			Type = "Function",

			Returns =
			{
				{ Name = "selectedPet", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetStablePetFoodTypes",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetStablePetInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "level", Type = "number", Nilable = false },
				{ Name = "family", Type = "string", Nilable = false },
				{ Name = "talent", Type = "string", Nilable = false },
			},
		},
		{
			Name = "IsAtStableMaster",
			Type = "Function",

			Returns =
			{
				{ Name = "isAtNPC", Type = "bool", Nilable = false },
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
			Name = "SetPetStablePaperdoll",
			Type = "Function",

			Arguments =
			{
				{ Name = "model", Type = "table", Nilable = false },
			},

		},
		{
			Name = "StablePet",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "selected", Type = "bool", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "PetStableClosed",
			Type = "Event",
			LiteralName = "PET_STABLE_CLOSED",
		},
		{
			Name = "PetStableShow",
			Type = "Event",
			LiteralName = "PET_STABLE_SHOW",
		},
		{
			Name = "PetStableUpdate",
			Type = "Event",
			LiteralName = "PET_STABLE_UPDATE",
		},
		{
			Name = "PetStableUpdatePaperdoll",
			Type = "Event",
			LiteralName = "PET_STABLE_UPDATE_PAPERDOLL",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(PetStable);
