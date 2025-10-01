local Trainer =
{
	Name = "Trainer",
	Type = "System",
	Namespace = "Trainer",

	Functions =
	{
		{
			Name = "BuyTrainerService",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CheckTalentMasterDist",
			Type = "Function",

			Returns =
			{
				{ Name = "inRange", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CloseTrainer",
			Type = "Function",

		},
		{
			Name = "GetNumTrainerServices",
			Type = "Function",

			Returns =
			{
				{ Name = "numServices", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTrainerGreetingText",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTrainerSelectionIndex",
			Type = "Function",

			Returns =
			{
				{ Name = "selectionIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetTrainerServiceAbilityReq",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "abilityIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "ability", Type = "string", Nilable = false },
				{ Name = "hasReq", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetTrainerServiceCost",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "moneyCost", Type = "number", Nilable = false },
				{ Name = "talentCost", Type = "number", Nilable = false },
				{ Name = "skillCost", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTrainerServiceDescription",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTrainerServiceIcon",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "icon", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTrainerServiceInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "serviceName", Type = "string", Nilable = false },
				{ Name = "serviceSubText", Type = "string", Nilable = false },
				{ Name = "serviceType", Type = "string", Nilable = false },
				{ Name = "isExpanded", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetTrainerServiceItemLink",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "link", Type = "hyperlink", Nilable = false },
			},
		},
		{
			Name = "GetTrainerServiceLevelReq",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "reqLevel", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTrainerServiceNumAbilityReq",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "numRequirements", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTrainerServiceSkillLine",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "skillLine", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetTrainerServiceSkillReq",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "skill", Type = "string", Nilable = false },
				{ Name = "rank", Type = "number", Nilable = false },
				{ Name = "hasReq", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetTrainerServiceStepReq",
			Type = "Function",

		},
		{
			Name = "GetTrainerServiceTypeFilter",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "isEnabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsTradeskillTrainer",
			Type = "Function",

			Returns =
			{
				{ Name = "isTradeskill", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "OpenTrainer",
			Type = "Function",

		},
		{
			Name = "SelectTrainerService",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetTrainerServiceTypeFilter",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "enable", Type = "number", Nilable = false },
				{ Name = "exclusive", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "SetTrainerSkillLineFilter",
			Type = "Function",

			Arguments =
			{
				{ Name = "type", Type = "string", Nilable = false },
				{ Name = "enable", Type = "number", Nilable = false },
				{ Name = "exclusive", Type = "bool", Nilable = true },
			},

		},
	},

	Events =
	{
		{
			Name = "TrainerClosed",
			Type = "Event",
			LiteralName = "TRAINER_CLOSED",
		},
		{
			Name = "TrainerDescriptionUpdate",
			Type = "Event",
			LiteralName = "TRAINER_DESCRIPTION_UPDATE",
		},
		{
			Name = "TrainerShow",
			Type = "Event",
			LiteralName = "TRAINER_SHOW",
		},
		{
			Name = "TrainerUpdate",
			Type = "Event",
			LiteralName = "TRAINER_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Trainer);
