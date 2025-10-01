local Map =
{
	Name = "Map",
	Type = "System",
	Namespace = "Map",

	Functions =
	{
		{
			Name = "ClickLandmark",
			Type = "Function",

			Arguments =
			{
				{ Name = "mapLinkID", Type = "number", Nilable = false },
			},

		},
		{
			Name = "GetCorpseMapPosition",
			Type = "Function",

			Returns =
			{
				{ Name = "corpseX", Type = "number", Nilable = false },
				{ Name = "corpseY", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCurrentMapAreaID",
			Type = "Function",

			Returns =
			{
				{ Name = "areaID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCurrentMapContinent",
			Type = "Function",

			Returns =
			{
				{ Name = "continent", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCurrentMapDungeonLevel",
			Type = "Function",

			Returns =
			{
				{ Name = "level", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCurrentMapZone",
			Type = "Function",

			Returns =
			{
				{ Name = "zone", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetDeathReleasePosition",
			Type = "Function",

			Returns =
			{
				{ Name = "graveyardX", Type = "number", Nilable = false },
				{ Name = "graveyardY", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetMapContinents",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetMapInfo",
			Type = "Function",

		},
		{
			Name = "GetMapLandmarkInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "description", Type = "string", Nilable = false },
				{ Name = "textureIndex", Type = "luaIndex", Nilable = false },
				{ Name = "x", Type = "number", Nilable = false },
				{ Name = "y", Type = "number", Nilable = false },
				{ Name = "mapLinkID", Type = "number", Nilable = false },
				{ Name = "showInBattleMap", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetMapOverlayInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "textureName", Type = "string", Nilable = false },
				{ Name = "textureWidth", Type = "number", Nilable = false },
				{ Name = "textureHeight", Type = "number", Nilable = false },
				{ Name = "offsetX", Type = "number", Nilable = false },
				{ Name = "offsetY", Type = "number", Nilable = false },
				{ Name = "mapPointX", Type = "number", Nilable = false },
				{ Name = "mapPointY", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetMapZones",
			Type = "Function",

			Arguments =
			{
				{ Name = "continentIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "GetNumBattlefieldVehicles",
			Type = "Function",

			Returns =
			{
				{ Name = "numVehicles", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumDungeonMapLevels",
			Type = "Function",

			Returns =
			{
				{ Name = "numLevels", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumMapLandmarks",
			Type = "Function",

			Returns =
			{
				{ Name = "numLandmarks", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumMapOverlays",
			Type = "Function",

			Returns =
			{
				{ Name = "numOverlays", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPlayerFacing",
			Type = "Function",

			Returns =
			{
				{ Name = "facing", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetPlayerMapPosition",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "unitX", Type = "UnitToken", Nilable = false },
				{ Name = "unitY", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "InitWorldMapPing",
			Type = "Function",

		},
		{
			Name = "ProcessMapClick",
			Type = "Function",

			Arguments =
			{
				{ Name = "clickX", Type = "number", Nilable = false },
				{ Name = "clickY", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetDungeonMapLevel",
			Type = "Function",

			Arguments =
			{
				{ Name = "level", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetMapToCurrentZone",
			Type = "Function",

		},
		{
			Name = "SetMapZoom",
			Type = "Function",

			Arguments =
			{
				{ Name = "continentIndex", Type = "luaIndex", Nilable = false },
				{ Name = "zoneIndex", Type = "luaIndex", Nilable = true },
			},

		},
		{
			Name = "UpdateMapHighlight",
			Type = "Function",

			Arguments =
			{
				{ Name = "cursorX", Type = "number", Nilable = false },
				{ Name = "cursorY", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "fileName", Type = "string", Nilable = false },
				{ Name = "texCoordX", Type = "number", Nilable = false },
				{ Name = "texCoordY", Type = "number", Nilable = false },
				{ Name = "textureX", Type = "number", Nilable = false },
				{ Name = "textureY", Type = "number", Nilable = false },
				{ Name = "scrollChildX", Type = "number", Nilable = false },
				{ Name = "scrollChildY", Type = "number", Nilable = false },
			},
		},
		{
			Name = "ZoomOut",
			Type = "Function",

			Arguments =
			{
				{ Name = "distance", Type = "number", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "CloseWorldMap",
			Type = "Event",
			LiteralName = "CLOSE_WORLD_MAP",
		},
		{
			Name = "MinimapPing",
			Type = "Event",
			LiteralName = "MINIMAP_PING",
			Payload =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
				{ Name = "x", Type = "number", Nilable = false },
				{ Name = "y", Type = "number", Nilable = false },
			},
		},
		{
			Name = "MinimapUpdateZoom",
			Type = "Event",
			LiteralName = "MINIMAP_UPDATE_ZOOM",
		},
		{
			Name = "TaximapClosed",
			Type = "Event",
			LiteralName = "TAXIMAP_CLOSED",
		},
		{
			Name = "TaximapOpened",
			Type = "Event",
			LiteralName = "TAXIMAP_OPENED",
		},
		{
			Name = "WorldMapNameUpdate",
			Type = "Event",
			LiteralName = "WORLD_MAP_NAME_UPDATE",
		},
		{
			Name = "WorldMapUpdate",
			Type = "Event",
			LiteralName = "WORLD_MAP_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Map);
