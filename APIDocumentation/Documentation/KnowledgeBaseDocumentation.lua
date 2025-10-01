local KnowledgeBase =
{
	Name = "KnowledgeBase",
	Type = "System",
	Namespace = "KnowledgeBase",

	Functions =
	{
		{
			Name = "KBArticle_BeginLoading",
			Type = "Function",

			Arguments =
			{
				{ Name = "articleId", Type = "number", Nilable = false },
				{ Name = "searchType", Type = "number", Nilable = false },
			},

		},
		{
			Name = "KBArticle_GetData",
			Type = "Function",

			Returns =
			{
				{ Name = "id", Type = "number", Nilable = false },
				{ Name = "subject", Type = "string", Nilable = false },
				{ Name = "subjectAlt", Type = "string", Nilable = false },
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "keywords", Type = "string", Nilable = false },
				{ Name = "languageId", Type = "number", Nilable = false },
				{ Name = "isHot", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "KBArticle_IsLoaded",
			Type = "Function",

			Returns =
			{
				{ Name = "isLoaded", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "KBQuery_BeginLoading",
			Type = "Function",

			Arguments =
			{
				{ Name = "searchText", Type = "string", Nilable = false },
				{ Name = "categoryIndex", Type = "luaIndex", Nilable = false },
				{ Name = "subcategoryIndex", Type = "luaIndex", Nilable = false },
				{ Name = "numArticles", Type = "number", Nilable = false },
				{ Name = "page", Type = "number", Nilable = false },
			},

		},
		{
			Name = "KBQuery_GetArticleHeaderCount",
			Type = "Function",

			Returns =
			{
				{ Name = "articleHeaderCount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "KBQuery_GetArticleHeaderData",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "articleId", Type = "number", Nilable = false },
				{ Name = "title", Type = "string", Nilable = false },
				{ Name = "isHotIssue", Type = "bool", Nilable = false },
				{ Name = "isRecentlyUpdated", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "KBQuery_GetTotalArticleCount",
			Type = "Function",

			Returns =
			{
				{ Name = "totalArticleHeaderCount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "KBQuery_IsLoaded",
			Type = "Function",

			Returns =
			{
				{ Name = "isLoaded", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "KBSetup_BeginLoading",
			Type = "Function",

			Arguments =
			{
				{ Name = "numArticles", Type = "number", Nilable = false },
				{ Name = "currentPage", Type = "number", Nilable = false },
			},

		},
		{
			Name = "KBSetup_GetArticleHeaderCount",
			Type = "Function",

			Returns =
			{
				{ Name = "articleHeaderCount", Type = "number", Nilable = false },
			},
		},
		{
			Name = "KBSetup_GetArticleHeaderData",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "articleId", Type = "number", Nilable = false },
				{ Name = "title", Type = "string", Nilable = false },
				{ Name = "isHotIssue", Type = "bool", Nilable = false },
				{ Name = "isRecentlyUpdated", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "KBSetup_GetCategoryCount",
			Type = "Function",

			Returns =
			{
				{ Name = "numCategories", Type = "number", Nilable = false },
			},
		},
		{
			Name = "KBSetup_GetCategoryData",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "categoryId", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "KBSetup_GetLanguageCount",
			Type = "Function",

			Returns =
			{
				{ Name = "numLanguages", Type = "number", Nilable = false },
			},
		},
		{
			Name = "KBSetup_GetLanguageData",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "languageId", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "KBSetup_GetSubCategoryCount",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "numSubCategories", Type = "number", Nilable = false },
			},
		},
		{
			Name = "KBSetup_GetSubCategoryData",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "subindex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "categoryId", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
			},
		},
		{
			Name = "KBSetup_GetTotalArticleCount",
			Type = "Function",

			Returns =
			{
				{ Name = "numArticles", Type = "number", Nilable = false },
			},
		},
		{
			Name = "KBSetup_IsLoaded",
			Type = "Function",

			Returns =
			{
				{ Name = "isLoaded", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "KBSystem_GetMOTD",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "KBSystem_GetServerNotice",
			Type = "Function",

			Returns =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},
		},
		{
			Name = "KBSystem_GetServerStatus",
			Type = "Function",

			Returns =
			{
				{ Name = "statusMessage", Type = "string", Nilable = false },
			},
		},
	},

	Events =
	{
		{
			Name = "KnowledgeBaseArticleLoadFailure",
			Type = "Event",
			LiteralName = "KNOWLEDGE_BASE_ARTICLE_LOAD_FAILURE",
		},
		{
			Name = "KnowledgeBaseArticleLoadSuccess",
			Type = "Event",
			LiteralName = "KNOWLEDGE_BASE_ARTICLE_LOAD_SUCCESS",
		},
		{
			Name = "KnowledgeBaseQueryLoadFailure",
			Type = "Event",
			LiteralName = "KNOWLEDGE_BASE_QUERY_LOAD_FAILURE",
		},
		{
			Name = "KnowledgeBaseQueryLoadSuccess",
			Type = "Event",
			LiteralName = "KNOWLEDGE_BASE_QUERY_LOAD_SUCCESS",
		},
		{
			Name = "KnowledgeBaseServerMessage",
			Type = "Event",
			LiteralName = "KNOWLEDGE_BASE_SERVER_MESSAGE",
		},
		{
			Name = "KnowledgeBaseSetupLoadFailure",
			Type = "Event",
			LiteralName = "KNOWLEDGE_BASE_SETUP_LOAD_FAILURE",
		},
		{
			Name = "KnowledgeBaseSetupLoadSuccess",
			Type = "Event",
			LiteralName = "KNOWLEDGE_BASE_SETUP_LOAD_SUCCESS",
		},
		{
			Name = "KnowledgeBaseSystemMotdUpdated",
			Type = "Event",
			LiteralName = "KNOWLEDGE_BASE_SYSTEM_MOTD_UPDATED",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(KnowledgeBase);
