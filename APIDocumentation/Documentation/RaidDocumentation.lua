local Raid =
{
	Name = "Raid",
	Type = "System",
	Namespace = "Raid",

	Functions =
	{
		{
			Name = "AcceptGroup",
			Type = "Function",

		},
		{
			Name = "ClearPartyAssignment",
			Type = "Function",

			Arguments =
			{
				{ Name = "assignment", Type = "string", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "exactMatch", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "ConfirmReadyCheck",
			Type = "Function",

			Arguments =
			{
				{ Name = "ready", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "ConvertToRaid",
			Type = "Function",

		},
		{
			Name = "DeclineGroup",
			Type = "Function",

		},
		{
			Name = "DemoteAssistant",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "exactMatch", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "DoReadyCheck",
			Type = "Function",

		},
		{
			Name = "GetNumRaidMembers",
			Type = "Function",

			Returns =
			{
				{ Name = "numRaidMembers", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPartyAssignment",
			Type = "Function",

			Arguments =
			{
				{ Name = "assignment", Type = "string", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "exactMatch", Type = "bool", Nilable = true },
			},

			Returns =
			{
				{ Name = "isAssigned", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetRaidRosterInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "rank", Type = "number", Nilable = false },
				{ Name = "subgroup", Type = "number", Nilable = false },
				{ Name = "level", Type = "number", Nilable = false },
				{ Name = "class", Type = "string", Nilable = false },
				{ Name = "fileName", Type = "string", Nilable = false },
				{ Name = "zone", Type = "string", Nilable = false },
				{ Name = "online", Type = "bool", Nilable = false },
				{ Name = "isDead", Type = "bool", Nilable = false },
				{ Name = "role", Type = "string", Nilable = false },
				{ Name = "isML", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetRaidRosterSelection",
			Type = "Function",

			Returns =
			{
				{ Name = "raidIndex", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetRaidTargetIndex",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetReadyCheckStatus",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "status", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetReadyCheckTimeLeft",
			Type = "Function",

			Returns =
			{
				{ Name = "timeLeft", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetRealNumRaidMembers",
			Type = "Function",

			Returns =
			{
				{ Name = "numMembers", Type = "number", Nilable = false },
			},
		},
		{
			Name = "InviteUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "IsRaidLeader",
			Type = "Function",

			Returns =
			{
				{ Name = "isLeader", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsRaidOfficer",
			Type = "Function",

			Returns =
			{
				{ Name = "isRaidOfficer", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsRealRaidLeader",
			Type = "Function",

			Returns =
			{
				{ Name = "isLeader", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "LeaveParty",
			Type = "Function",

		},
		{
			Name = "PromoteToAssistant",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "exactMatch", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "PromoteToLeader",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "exactMatch", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "SetPartyAssignment",
			Type = "Function",

			Arguments =
			{
				{ Name = "assignment", Type = "string", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "exactMatch", Type = "bool", Nilable = true },
			},

		},
		{
			Name = "SetRaidRosterSelection",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetRaidSubgroup",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "subgroup", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetRaidTarget",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "index", Type = "luaIndex", Nilable = true },
			},

		},
		{
			Name = "SwapRaidSubgroup",
			Type = "Function",

			Arguments =
			{
				{ Name = "index1", Type = "luaIndex", Nilable = false },
				{ Name = "index2", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "UninviteUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "UnitInRaid",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "inRaid", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitIsPartyLeader",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "leader", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsRaidOfficer",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "leader", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitPlayerOrPetInRaid",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "inParty", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitTargetsVehicleInRaidUI",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "targetVehicle", Type = "bool", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "DisableLowLevelRaid",
			Type = "Event",
			LiteralName = "DISABLE_LOW_LEVEL_RAID",
		},
		{
			Name = "EnableLowLevelRaid",
			Type = "Event",
			LiteralName = "ENABLE_LOW_LEVEL_RAID",
		},
		{
			Name = "RaidRosterUpdate",
			Type = "Event",
			LiteralName = "RAID_ROSTER_UPDATE",
		},
		{
			Name = "RaidTargetUpdate",
			Type = "Event",
			LiteralName = "RAID_TARGET_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Raid);
