local Instance =
{
	Name = "Instance",
	Type = "System",
	Namespace = "Instance",

	Functions =
	{
		{
			Name = "CanShowResetInstances",
			Type = "Function",

			Returns =
			{
				{ Name = "canResetInstances", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetDungeonDifficulty",
			Type = "Function",

			Returns =
			{
				{ Name = "difficulty", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetInstanceBootTimeRemaining",
			Type = "Function",

			Returns =
			{
				{ Name = "timeleft", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetInstanceDifficulty",
			Type = "Function",

			Returns =
			{
				{ Name = "difficulty", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetInstanceInfo",
			Type = "Function",

		},
		{
			Name = "GetInstanceLockTimeRemaining",
			Type = "Function",

			Returns =
			{
				{ Name = "seconds", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumSavedInstances",
			Type = "Function",

			Returns =
			{
				{ Name = "savedInstances", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumWorldStateUI",
			Type = "Function",

			Returns =
			{
				{ Name = "numUI", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSavedInstanceInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "instanceName", Type = "string", Nilable = false },
				{ Name = "instanceID", Type = "number", Nilable = false },
				{ Name = "instanceReset", Type = "number", Nilable = false },
				{ Name = "instanceDifficulty", Type = "number", Nilable = false },
				{ Name = "locked", Type = "bool", Nilable = false },
				{ Name = "extended", Type = "bool", Nilable = false },
				{ Name = "instanceIDMostSig", Type = "number", Nilable = false },
				{ Name = "isRaid", Type = "bool", Nilable = false },
				{ Name = "maxPlayers", Type = "number", Nilable = false },
				{ Name = "difficultyName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetWorldStateUIInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "uiType", Type = "number", Nilable = false },
				{ Name = "state", Type = "number", Nilable = false },
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "dynamicIcon", Type = "string", Nilable = false },
				{ Name = "tooltip", Type = "string", Nilable = false },
				{ Name = "dynamicTooltip", Type = "string", Nilable = false },
				{ Name = "extendedUI", Type = "string", Nilable = false },
				{ Name = "extendedUIState1", Type = "number", Nilable = false },
				{ Name = "extendedUIState2", Type = "number", Nilable = false },
				{ Name = "extendedUIState3", Type = "number", Nilable = false },
			},
		},
		{
			Name = "IsInInstance",
			Type = "Function",

			Returns =
			{
				{ Name = "isInstance", Type = "bool", Nilable = false },
				{ Name = "instanceType", Type = "string", Nilable = false },
			},
		},
		{
			Name = "LFGTeleport",
			Type = "Function",

			Arguments =
			{
				{ Name = "portOut", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "RequestRaidInfo",
			Type = "Function",

		},
		{
			Name = "ResetInstances",
			Type = "Function",

			Returns =
			{
				{ Name = "canResetInstances", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "RespondInstanceLock",
			Type = "Function",

			Arguments =
			{
				{ Name = "response", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "SetDungeonDifficulty",
			Type = "Function",

			Arguments =
			{
				{ Name = "difficulty", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetRaidDifficulty",
			Type = "Function",

			Arguments =
			{
				{ Name = "difficulty", Type = "number", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "CorpseInInstance",
			Type = "Event",
			LiteralName = "CORPSE_IN_INSTANCE",
		},
		{
			Name = "InstanceBootStart",
			Type = "Event",
			LiteralName = "INSTANCE_BOOT_START",
		},
		{
			Name = "InstanceBootStop",
			Type = "Event",
			LiteralName = "INSTANCE_BOOT_STOP",
		},
		{
			Name = "InstanceEncounterEngageUnit",
			Type = "Event",
			LiteralName = "INSTANCE_ENCOUNTER_ENGAGE_UNIT",
		},
		{
			Name = "InstanceLockStart",
			Type = "Event",
			LiteralName = "INSTANCE_LOCK_START",
		},
		{
			Name = "InstanceLockStop",
			Type = "Event",
			LiteralName = "INSTANCE_LOCK_STOP",
		},
		{
			Name = "RaidInstanceWelcome",
			Type = "Event",
			LiteralName = "RAID_INSTANCE_WELCOME",
			Payload =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "ttl", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UpdateInstanceInfo",
			Type = "Event",
			LiteralName = "UPDATE_INSTANCE_INFO",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Instance);
