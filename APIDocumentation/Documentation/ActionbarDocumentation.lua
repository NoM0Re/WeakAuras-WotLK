local Actionbar =
{
	Name = "ActionBar",
	Type = "System",
	Namespace = "ActionBar",

	Functions =
	{
		{
			Name = "ChangeActionBarPage",
			Type = "Function",

			Arguments =
			{
				{ Name = "page", Type = "number", Nilable = false },
			},

		},
		{
			Name = "GetActionBarPage",
			Type = "Function",

			Returns =
			{
				{ Name = "page", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetActionBarToggles",
			Type = "Function",

			Returns =
			{
				{ Name = "showBar1", Type = "bool", Nilable = false },
				{ Name = "showBar2", Type = "bool", Nilable = false },
				{ Name = "showBar3", Type = "bool", Nilable = false },
				{ Name = "showBar4", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetBonusBarOffset",
			Type = "Function",

			Returns =
			{
				{ Name = "offset", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPossessInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "IsPossessBarVisible",
			Type = "Function",

			Returns =
			{
				{ Name = "isVisible", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetActionBarToggles",
			Type = "Function",

			Arguments =
			{
				{ Name = "bar1", Type = "1nil", Nilable = false },
				{ Name = "bar2", Type = "1nil", Nilable = false },
				{ Name = "bar3", Type = "1nil", Nilable = false },
				{ Name = "bar4", Type = "1nil", Nilable = false },
				{ Name = "alwaysShow", Type = "1nil", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "ActionbarHidegrid",
			Type = "Event",
			LiteralName = "ACTIONBAR_HIDEGRID",
		},
		{
			Name = "ActionbarPageChanged",
			Type = "Event",
			LiteralName = "ACTIONBAR_PAGE_CHANGED",
		},
		{
			Name = "ActionbarShowgrid",
			Type = "Event",
			LiteralName = "ACTIONBAR_SHOWGRID",
		},
		{
			Name = "ActionbarSlotChanged",
			Type = "Event",
			LiteralName = "ACTIONBAR_SLOT_CHANGED",
			Payload =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},
		},
		{
			Name = "ActionbarUpdateCooldown",
			Type = "Event",
			LiteralName = "ACTIONBAR_UPDATE_COOLDOWN",
		},
		{
			Name = "ActionbarUpdateState",
			Type = "Event",
			LiteralName = "ACTIONBAR_UPDATE_STATE",
		},
		{
			Name = "ActionbarUpdateUsable",
			Type = "Event",
			LiteralName = "ACTIONBAR_UPDATE_USABLE",
		},
		{
			Name = "UpdateBonusActionbar",
			Type = "Event",
			LiteralName = "UPDATE_BONUS_ACTIONBAR",
		},
		{
			Name = "UpdateMultiCastActionbar",
			Type = "Event",
			LiteralName = "UPDATE_MULTI_CAST_ACTIONBAR",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Actionbar);
