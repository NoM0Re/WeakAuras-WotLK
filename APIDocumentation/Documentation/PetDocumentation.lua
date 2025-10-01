local Pet =
{
	Name = "Pet",
	Type = "System",
	Namespace = "Pet",

	Functions =
	{
		{
			Name = "CastPetAction",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
			},

		},
		{
			Name = "DestroyTotem",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "DisableSpellAutocast",
			Type = "Function",

			Arguments =
			{
				{ Name = "spell", Type = "string", Nilable = false },
			},

		},
		{
			Name = "EnableSpellAutocast",
			Type = "Function",

			Arguments =
			{
				{ Name = "spell", Type = "string", Nilable = false },
			},

		},
		{
			Name = "GetPetActionCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "start", Type = "number", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "enable", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPetActionInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "subtext", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "isToken", Type = "bool", Nilable = false },
				{ Name = "isActive", Type = "bool", Nilable = false },
				{ Name = "autoCastAllowed", Type = "bool", Nilable = false },
				{ Name = "autoCastEnabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetPetActionSlotUsable",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "usable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetPetActionsUsable",
			Type = "Function",

			Returns =
			{
				{ Name = "petActionsUsable", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetPetExperience",
			Type = "Function",

			Returns =
			{
				{ Name = "currXP", Type = "number", Nilable = false },
				{ Name = "nextXP", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPetFoodTypes",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetPetIcon",
			Type = "Function",

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetPetTalentTree",
			Type = "Function",

			Returns =
			{
				{ Name = "talent", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetPetTimeRemaining",
			Type = "Function",

			Returns =
			{
				{ Name = "petTimeRemaining", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTotemInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "haveTotem", Type = "bool", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "startTime", Type = "time_t", Nilable = false },
				{ Name = "duration", Type = "time_t", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTotemTimeLeft",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "seconds", Type = "number", Nilable = false },
			},
		},
		{
			Name = "HasPetSpells",
			Type = "Function",

			Returns =
			{
				{ Name = "hasPetSpells", Type = "bool", Nilable = false },
				{ Name = "petType", Type = "string", Nilable = false },
			},
		},
		{
			Name = "HasPetUI",
			Type = "Function",

			Returns =
			{
				{ Name = "hasPetUI", Type = "bool", Nilable = false },
				{ Name = "isHunterPet", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsPetAttackActive",
			Type = "Function",

			Returns =
			{
				{ Name = "isActive", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PetAbandon",
			Type = "Function",

		},
		{
			Name = "PetAggressiveMode",
			Type = "Function",

		},
		{
			Name = "PetAttack",
			Type = "Function",

		},
		{
			Name = "PetCanBeAbandoned",
			Type = "Function",

			Returns =
			{
				{ Name = "canAbandon", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PetCanBeDismissed",
			Type = "Function",

			Returns =
			{
				{ Name = "canDismiss", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PetCanBeRenamed",
			Type = "Function",

			Returns =
			{
				{ Name = "canRename", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PetDefensiveMode",
			Type = "Function",

		},
		{
			Name = "PetDismiss",
			Type = "Function",

		},
		{
			Name = "PetFollow",
			Type = "Function",

		},
		{
			Name = "PetHasActionBar",
			Type = "Function",

			Returns =
			{
				{ Name = "hasActionBar", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "PetPassiveMode",
			Type = "Function",

		},
		{
			Name = "PetRename",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "genitive", Type = "string", Nilable = false },
				{ Name = "dative", Type = "string", Nilable = false },
				{ Name = "accusative", Type = "string", Nilable = false },
				{ Name = "instrumental", Type = "string", Nilable = false },
				{ Name = "prepositional", Type = "string", Nilable = true },
			},

		},
		{
			Name = "PetStopAttack",
			Type = "Function",

		},
		{
			Name = "PetWait",
			Type = "Function",

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
			Name = "TargetTotem",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "TogglePetAutocast",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "LocalplayerPetRenamed",
			Type = "Event",
			LiteralName = "LOCALPLAYER_PET_RENAMED",
		},
		{
			Name = "PetAttackStart",
			Type = "Event",
			LiteralName = "PET_ATTACK_START",
		},
		{
			Name = "PetAttackStop",
			Type = "Event",
			LiteralName = "PET_ATTACK_STOP",
		},
		{
			Name = "PetBarHide",
			Type = "Event",
			LiteralName = "PET_BAR_HIDE",
		},
		{
			Name = "PetBarHidegrid",
			Type = "Event",
			LiteralName = "PET_BAR_HIDEGRID",
		},
		{
			Name = "PetBarShowgrid",
			Type = "Event",
			LiteralName = "PET_BAR_SHOWGRID",
		},
		{
			Name = "PetBarUpdate",
			Type = "Event",
			LiteralName = "PET_BAR_UPDATE",
		},
		{
			Name = "PetBarUpdateCooldown",
			Type = "Event",
			LiteralName = "PET_BAR_UPDATE_COOLDOWN",
		},
		{
			Name = "PetBarUpdateUsable",
			Type = "Event",
			LiteralName = "PET_BAR_UPDATE_USABLE",
		},
		{
			Name = "PetDismissStart",
			Type = "Event",
			LiteralName = "PET_DISMISS_START",
		},
		{
			Name = "PetForceNameDeclension",
			Type = "Event",
			LiteralName = "PET_FORCE_NAME_DECLENSION",
		},
		{
			Name = "PetRenameable",
			Type = "Event",
			LiteralName = "PET_RENAMEABLE",
		},
		{
			Name = "PetUiClose",
			Type = "Event",
			LiteralName = "PET_UI_CLOSE",
		},
		{
			Name = "PetUiUpdate",
			Type = "Event",
			LiteralName = "PET_UI_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Pet);
