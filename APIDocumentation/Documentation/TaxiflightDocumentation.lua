local Taxiflight =
{
	Name = "TaxiFlight",
	Type = "System",
	Namespace = "TaxiFlight",

	Functions =
	{
		{
			Name = "CloseTaxiMap",
			Type = "Function",

		},
		{
			Name = "GetNumRoutes",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "numHops", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetTaxiBenchmarkMode",
			Type = "Function",

			Returns =
			{
				{ Name = "isBenchmark", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "NumTaxiNodes",
			Type = "Function",

			Returns =
			{
				{ Name = "numNodes", Type = "number", Nilable = false },
			},
		},
		{
			Name = "SetTaxiBenchmarkMode",
			Type = "Function",

			Arguments =
			{
				{ Name = "arg", Type = "string", Nilable = false },
			},

		},
		{
			Name = "SetTaxiMap",
			Type = "Function",

			Arguments =
			{
				{ Name = "texture", Type = "table", Nilable = false },
			},

		},
		{
			Name = "TakeTaxiNode",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "TaxiGetDestX",
			Type = "Function",

			Arguments =
			{
				{ Name = "source", Type = "number", Nilable = false },
				{ Name = "dest", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "dX", Type = "number", Nilable = false },
			},
		},
		{
			Name = "TaxiGetDestY",
			Type = "Function",

			Arguments =
			{
				{ Name = "source", Type = "number", Nilable = false },
				{ Name = "dest", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "dY", Type = "number", Nilable = false },
			},
		},
		{
			Name = "TaxiGetSrcX",
			Type = "Function",

			Arguments =
			{
				{ Name = "source", Type = "number", Nilable = false },
				{ Name = "dest", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "sX", Type = "number", Nilable = false },
			},
		},
		{
			Name = "TaxiGetSrcY",
			Type = "Function",

			Arguments =
			{
				{ Name = "source", Type = "number", Nilable = false },
				{ Name = "dest", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "sY", Type = "number", Nilable = false },
			},
		},
		{
			Name = "TaxiNodeCost",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "cost", Type = "number", Nilable = false },
			},
		},
		{
			Name = "TaxiNodeGetType",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "type", Type = "number", Nilable = false },
			},
		},
		{
			Name = "TaxiNodeName",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "TaxiNodePosition",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "x", Type = "number", Nilable = false },
				{ Name = "y", Type = "number", Nilable = false },
			},
		},
		{
			Name = "TaxiNodeSetCurrent",
			Type = "Function",

			Arguments =
			{
				{ Name = "slot", Type = "number", Nilable = false },
			},

		},
		{
			Name = "UnitOnTaxi",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "onTaxi", Type = "bool", Nilable = false },
			},
		},
	},

	Events =
	{
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Taxiflight);
