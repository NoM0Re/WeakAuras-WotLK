local CharacterCustomizationShared =
{
	Tables =
	{
		{
			Name = "CharCustomizationType",
			Type = "Enumeration",
			NumValues = 12,
			MinValue = 0,
			MaxValue = 11,
			Fields =
			{
				{ Name = "Skin", Type = "CharCustomizationType", EnumValue = 0 },
				{ Name = "Face", Type = "CharCustomizationType", EnumValue = 1 },
				{ Name = "Hair", Type = "CharCustomizationType", EnumValue = 2 },
				{ Name = "HairColor", Type = "CharCustomizationType", EnumValue = 3 },
				{ Name = "FacialHair", Type = "CharCustomizationType", EnumValue = 4 },
				{ Name = "CustomOptionTattoo", Type = "CharCustomizationType", EnumValue = 5 },
				{ Name = "CustomOptionHorn", Type = "CharCustomizationType", EnumValue = 6 },
				{ Name = "CustomOptionFacewear", Type = "CharCustomizationType", EnumValue = 7 },
				{ Name = "CustomOptionTattooColor", Type = "CharCustomizationType", EnumValue = 8 },
				{ Name = "Outfit", Type = "CharCustomizationType", EnumValue = 9 },
				{ Name = "Facepaint", Type = "CharCustomizationType", EnumValue = 10 },
				{ Name = "FacepaintColor", Type = "CharCustomizationType", EnumValue = 11 },
			},
		},
		{
			Name = "ChrCustomizationCategoryFlag",
			Type = "Enumeration",
			NumValues = 1,
			MinValue = 1,
			MaxValue = 1,
			Fields =
			{
				{ Name = "UndressModel", Type = "ChrCustomizationCategoryFlag", EnumValue = 1 },
			},
		},
		{
			Name = "ChrCustomizationOptionType",
			Type = "Enumeration",
			NumValues = 3,
			MinValue = 0,
			MaxValue = 2,
			Fields =
			{
				{ Name = "SelectionPopout", Type = "ChrCustomizationOptionType", EnumValue = 0 },
				{ Name = "Checkbox", Type = "ChrCustomizationOptionType", EnumValue = 1 },
				{ Name = "Slider", Type = "ChrCustomizationOptionType", EnumValue = 2 },
			},
		},
		{
			Name = "CustomizationScope",
			Type = "Enumeration",
			NumValues = 2,
			MinValue = 0,
			MaxValue = 1,
			Fields =
			{
				{ Name = "Player", Type = "CustomizationScope", EnumValue = 0 },
				{ Name = "DragonCompanion", Type = "CustomizationScope", EnumValue = 1 },
			},
		},
		{
			Name = "CharCustomizationCategory",
			Type = "Structure",
			Fields =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "orderIndex", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "icon", Type = "textureAtlas", Nilable = false },
				{ Name = "selectedIcon", Type = "textureAtlas", Nilable = false },
				{ Name = "undressModel", Type = "bool", Nilable = false },
				{ Name = "cameraZoomLevel", Type = "number", Nilable = false },
				{ Name = "cameraDistanceOffset", Type = "number", Nilable = false },
				{ Name = "spellShapeshiftFormID", Type = "number", Nilable = true },
				{ Name = "chrModelID", Type = "number", Nilable = true },
				{ Name = "options", Type = "table", InnerType = "CharCustomizationOption", Nilable = false },
				{ Name = "hasNewChoices", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CharCustomizationChoice",
			Type = "Structure",
			Fields =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "ineligibleChoice", Type = "bool", Nilable = false },
				{ Name = "isNew", Type = "bool", Nilable = false },
				{ Name = "swatchColor1", Type = "colorRGB", Mixin = "ColorMixin", Nilable = true },
				{ Name = "swatchColor2", Type = "colorRGB", Mixin = "ColorMixin", Nilable = true },
				{ Name = "soundKit", Type = "number", Nilable = true },
				{ Name = "isLocked", Type = "bool", Nilable = false },
				{ Name = "lockedText", Type = "string", Nilable = true },
			},
		},
		{
			Name = "CharCustomizationOption",
			Type = "Structure",
			Fields =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "orderIndex", Type = "number", Nilable = false },
				{ Name = "optionType", Type = "ChrCustomizationOptionType", Nilable = false },
				{ Name = "choices", Type = "table", InnerType = "CharCustomizationChoice", Nilable = false },
				{ Name = "currentChoiceIndex", Type = "luaIndex", Nilable = true },
				{ Name = "hasNewChoices", Type = "bool", Nilable = false },
				{ Name = "isSound", Type = "bool", Nilable = false },
			},
		},
	},
};

APIDocumentation:AddDocumentationTable(CharacterCustomizationShared);