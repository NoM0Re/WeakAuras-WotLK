local ZoneInformation =
{
	Name = "Zone Information",
	Type = "System",
	Namespace = "Zone Information",

	Functions =
	{
		{
			Name = "GetMinimapZoneText",
			Type = "Function",

			Returns =
			{
				{ Name = "zoneText", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetRealZoneText",
			Type = "Function",

			Returns =
			{
				{ Name = "zoneName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetSubZoneText",
			Type = "Function",

			Returns =
			{
				{ Name = "subzoneText", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetZonePVPInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "pvpType", Type = "string", Nilable = false },
				{ Name = "isSubZonePVP", Type = "bool", Nilable = false },
				{ Name = "factionName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "GetZoneText",
			Type = "Function",

			Returns =
			{
				{ Name = "zone", Type = "string", Nilable = false },
			},
		},
		{
			Name = "IsSubZonePVPPOI",
			Type = "Function",

			Returns =
			{
				{ Name = "isPVPPOI", Type = "bool", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "AreaSpiritHealerInRange",
			Type = "Event",
			LiteralName = "AREA_SPIRIT_HEALER_IN_RANGE",
		},
		{
			Name = "AreaSpiritHealerOutOfRange",
			Type = "Event",
			LiteralName = "AREA_SPIRIT_HEALER_OUT_OF_RANGE",
		},
		{
			Name = "ZoneChanged",
			Type = "Event",
			LiteralName = "ZONE_CHANGED",
		},
		{
			Name = "ZoneChangedIndoors",
			Type = "Event",
			LiteralName = "ZONE_CHANGED_INDOORS",
		},
		{
			Name = "ZoneChangedNewArea",
			Type = "Event",
			LiteralName = "ZONE_CHANGED_NEW_AREA",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(ZoneInformation);
