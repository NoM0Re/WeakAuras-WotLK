local Vehicle =
{
	Name = "Vehicle",
	Type = "System",
	Namespace = "Vehicle",

	Functions =
	{
		{
			Name = "CanEjectPassengerFromSeat",
			Type = "Function",

			Arguments =
			{
				{ Name = "seat", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "canEject", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanExitVehicle",
			Type = "Function",

			Returns =
			{
				{ Name = "canExit", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanSwitchVehicleSeat",
			Type = "Function",

			Returns =
			{
				{ Name = "canSwitch", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanSwitchVehicleSeats",
			Type = "Function",

			Returns =
			{
				{ Name = "canSwitch", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CombatTextSetActiveUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

		},
		{
			Name = "EjectPassengerFromSeat",
			Type = "Function",

			Arguments =
			{
				{ Name = "seat", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "canEject", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsUsingVehicleControls",
			Type = "Function",

		},
		{
			Name = "IsVehicleAimAngleAdjustable",
			Type = "Function",

			Returns =
			{
				{ Name = "hasAngleControl", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsVehicleAimPowerAdjustable",
			Type = "Function",

		},
		{
			Name = "UnitControllingVehicle",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "isControlling", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitHasVehicleUI",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "hasVehicle", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitInVehicle",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "inVehicle", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitInVehicleControlSeat",
			Type = "Function",

			Returns =
			{
				{ Name = "isInControl", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsControlling",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isControlling", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitSwitchToVehicleSeat",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "seat", Type = "number", Nilable = false },
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
		{
			Name = "UnitUsingVehicle",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "usingVehicle", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitVehicleSeatCount",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "numSeats", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitVehicleSeatInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "seat", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "controlType", Type = "string", Nilable = false },
				{ Name = "occupantName", Type = "string", Nilable = false },
				{ Name = "occupantRealm", Type = "string", Nilable = false },
				{ Name = "canEject", Type = "bool", Nilable = false },
				{ Name = "canSwitchSeats", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitVehicleSkin",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "skin", Type = "string", Nilable = false },
			},
		},
		{
			Name = "VehicleAimDecrement",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},

		},
		{
			Name = "VehicleAimDownStart",
			Type = "Function",

		},
		{
			Name = "VehicleAimDownStop",
			Type = "Function",

		},
		{
			Name = "VehicleAimGetAngle",
			Type = "Function",

			Returns =
			{
				{ Name = "angle", Type = "number", Nilable = false },
			},
		},
		{
			Name = "VehicleAimGetNormAngle",
			Type = "Function",

		},
		{
			Name = "VehicleAimGetNormPower",
			Type = "Function",

		},
		{
			Name = "VehicleAimIncrement",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},

		},
		{
			Name = "VehicleAimRequestAngle",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},

		},
		{
			Name = "VehicleAimRequestNormAngle",
			Type = "Function",

			Arguments =
			{
				{ Name = "amount", Type = "number", Nilable = false },
			},

		},
		{
			Name = "VehicleAimSetNormPower",
			Type = "Function",

		},
		{
			Name = "VehicleAimUpStart",
			Type = "Function",

		},
		{
			Name = "VehicleAimUpStop",
			Type = "Function",

		},
		{
			Name = "VehicleCameraZoomIn",
			Type = "Function",

		},
		{
			Name = "VehicleCameraZoomOut",
			Type = "Function",

		},
		{
			Name = "VehicleExit",
			Type = "Function",

		},
		{
			Name = "VehicleNextSeat",
			Type = "Function",

		},
		{
			Name = "VehiclePrevSeat",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "PlayerGainsVehicleData",
			Type = "Event",
			LiteralName = "PLAYER_GAINS_VEHICLE_DATA",
		},
		{
			Name = "PlayerLosesVehicleData",
			Type = "Event",
			LiteralName = "PLAYER_LOSES_VEHICLE_DATA",
		},
		{
			Name = "UnitEnteredVehicle",
			Type = "Event",
			LiteralName = "UNIT_ENTERED_VEHICLE",
		},
		{
			Name = "UnitEnteringVehicle",
			Type = "Event",
			LiteralName = "UNIT_ENTERING_VEHICLE",
		},
		{
			Name = "UnitExitingVehicle",
			Type = "Event",
			LiteralName = "UNIT_EXITING_VEHICLE",
		},
		{
			Name = "VehicleAngleShow",
			Type = "Event",
			LiteralName = "VEHICLE_ANGLE_SHOW",
		},
		{
			Name = "VehicleAngleUpdate",
			Type = "Event",
			LiteralName = "VEHICLE_ANGLE_UPDATE",
		},
		{
			Name = "VehiclePassengersChanged",
			Type = "Event",
			LiteralName = "VEHICLE_PASSENGERS_CHANGED",
		},
		{
			Name = "VehiclePowerShow",
			Type = "Event",
			LiteralName = "VEHICLE_POWER_SHOW",
		},
		{
			Name = "VehicleUpdate",
			Type = "Event",
			LiteralName = "VEHICLE_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Vehicle);
