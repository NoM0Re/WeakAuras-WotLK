local Camera =
{
	Name = "Camera",
	Type = "System",
	Namespace = "Camera",

	Functions =
	{
		{
			Name = "CameraOrSelectOrMoveStart",
			Type = "Function",

		},
		{
			Name = "CameraOrSelectOrMoveStop",
			Type = "Function",

			Arguments =
			{
				{ Name = "isSticky", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "CameraZoomIn",
			Type = "Function",

			Arguments =
			{
				{ Name = "distance", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CameraZoomOut",
			Type = "Function",

			Arguments =
			{
				{ Name = "distance", Type = "number", Nilable = false },
			},

		},
		{
			Name = "FlipCameraYaw",
			Type = "Function",

			Arguments =
			{
				{ Name = "degrees", Type = "number", Nilable = false },
			},

		},
		{
			Name = "IsMouselooking",
			Type = "Function",

			Returns =
			{
				{ Name = "isLooking", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "MouselookStart",
			Type = "Function",

		},
		{
			Name = "MouselookStop",
			Type = "Function",

		},
		{
			Name = "MoveViewDownStart",
			Type = "Function",

		},
		{
			Name = "MoveViewDownStop",
			Type = "Function",

		},
		{
			Name = "MoveViewInStart",
			Type = "Function",

		},
		{
			Name = "MoveViewInStop",
			Type = "Function",

		},
		{
			Name = "MoveViewLeftStart",
			Type = "Function",

		},
		{
			Name = "MoveViewLeftStop",
			Type = "Function",

		},
		{
			Name = "MoveViewOutStart",
			Type = "Function",

		},
		{
			Name = "MoveViewOutStop",
			Type = "Function",

		},
		{
			Name = "MoveViewRightStart",
			Type = "Function",

		},
		{
			Name = "MoveViewRightStop",
			Type = "Function",

		},
		{
			Name = "MoveViewUpStart",
			Type = "Function",

		},
		{
			Name = "MoveViewUpStop",
			Type = "Function",

		},
		{
			Name = "NextView",
			Type = "Function",

		},
		{
			Name = "PrevView",
			Type = "Function",

		},
		{
			Name = "ResetView",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SaveView",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetView",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
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

APIDocumentation:AddDocumentationTable(Camera);
