local RecruitAFriend =
{
	Name = "Recruit-a-friend",
	Type = "System",
	Namespace = "Recruit-a-friend",

	Functions =
	{
		{
			Name = "AcceptLevelGrant",
			Type = "Function",

		},
		{
			Name = "CanGrantLevel",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "canGrant", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CanSummonFriend",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "unit", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "canSummon", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "DeclineLevelGrant",
			Type = "Function",

		},
		{
			Name = "GetSummonFriendCooldown",
			Type = "Function",

			Returns =
			{
				{ Name = "start", Type = "number", Nilable = false },
				{ Name = "duration", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GrantLevel",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "canGrant", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsReferAFriendLinked",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "isLinked", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SummonFriend",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "unit", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "canSummon", Type = "bool", Nilable = false },
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

APIDocumentation:AddDocumentationTable(RecruitAFriend);
