local Calendar =
{
	Name = "Calendar",
	Type = "System",
	Namespace = "Calendar",

	Functions =
	{
		{
			Name = "CalendarAddEvent",
			Type = "Function",

		},
		{
			Name = "CalendarCanAddEvent",
			Type = "Function",

			Returns =
			{
				{ Name = "canAdd", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarCanSendInvite",
			Type = "Function",

			Returns =
			{
				{ Name = "canInvite", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarCloseEvent",
			Type = "Function",

		},
		{
			Name = "CalendarContextDeselectEvent",
			Type = "Function",

		},
		{
			Name = "CalendarContextEventCanComplain",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "canReport", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarContextEventCanEdit",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "canEdit", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarContextEventClipboard",
			Type = "Function",

			Returns =
			{
				{ Name = "canPaste", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarContextEventComplain",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarContextEventCopy",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarContextEventGetCalendarType",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "calendarType", Type = "string", Nilable = false },
			},
		},
		{
			Name = "CalendarContextEventPaste",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CalendarContextEventRemove",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarContextEventSignUp",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarContextGetEventIndex",
			Type = "Function",

			Returns =
			{
				{ Name = "monthOffset", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "CalendarContextInviteAvailable",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarContextInviteDecline",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarContextInviteIsPending",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "pendingInvite", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarContextInviteModeratorStatus",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "modStatus", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarContextInviteRemove",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarContextInviteStatus",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "inviteStatus", Type = "string", Nilable = false },
			},
		},
		{
			Name = "CalendarContextInviteType",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "inviteType", Type = "string", Nilable = false },
			},
		},
		{
			Name = "CalendarContextSelectEvent",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarDefaultGuildFilter",
			Type = "Function",

			Returns =
			{
				{ Name = "minLevel", Type = "number", Nilable = false },
				{ Name = "maxLevel", Type = "number", Nilable = false },
				{ Name = "rank", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarEventAvailable",
			Type = "Function",

		},
		{
			Name = "CalendarEventCanEdit",
			Type = "Function",

			Returns =
			{
				{ Name = "canEdit", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarEventCanModerate",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "canModerate", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarEventClearAutoApprove",
			Type = "Function",

		},
		{
			Name = "CalendarEventClearLocked",
			Type = "Function",

		},
		{
			Name = "CalendarEventClearModerator",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarEventDecline",
			Type = "Function",

		},
		{
			Name = "CalendarEventGetCalendarType",
			Type = "Function",

			Returns =
			{
				{ Name = "calendarType", Type = "string", Nilable = false },
			},
		},
		{
			Name = "CalendarEventGetInvite",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "level", Type = "number", Nilable = false },
				{ Name = "className", Type = "string", Nilable = false },
				{ Name = "classFileName", Type = "string", Nilable = false },
				{ Name = "inviteStatus", Type = "number", Nilable = false },
				{ Name = "modStatus", Type = "number", Nilable = false },
				{ Name = "inviteIsMine", Type = "bool", Nilable = false },
				{ Name = "inviteType", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarEventGetInviteResponseTime",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "weekday", Type = "number", Nilable = false },
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
				{ Name = "hour", Type = "number", Nilable = false },
				{ Name = "minute", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarEventGetInviteSortCriterion",
			Type = "Function",

			Returns =
			{
				{ Name = "criterion", Type = "string", Nilable = false },
				{ Name = "reverse", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarEventGetNumInvites",
			Type = "Function",

			Returns =
			{
				{ Name = "numInvites", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarEventGetRepeatOptions",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "CalendarEventGetSelectedInvite",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "CalendarEventGetStatusOptions",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "CalendarEventGetTextures",
			Type = "Function",

			Arguments =
			{
				{ Name = "eventType", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "expansion", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarEventGetTypes",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "CalendarEventHasPendingInvite",
			Type = "Function",

			Returns =
			{
				{ Name = "pendingInvite", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarEventHaveSettingsChanged",
			Type = "Function",

			Returns =
			{
				{ Name = "settingsChanged", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarEventInvite",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "CalendarEventIsModerator",
			Type = "Function",

			Returns =
			{
				{ Name = "isModerator", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarEventRemoveInvite",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarEventSelectInvite",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarEventSetAutoApprove",
			Type = "Function",

		},
		{
			Name = "CalendarEventSetDate",
			Type = "Function",

			Arguments =
			{
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CalendarEventSetDescription",
			Type = "Function",

		},
		{
			Name = "CalendarEventSetLocked",
			Type = "Function",

		},
		{
			Name = "CalendarEventSetLockoutDate",
			Type = "Function",

			Arguments =
			{
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CalendarEventSetLockoutTime",
			Type = "Function",

			Arguments =
			{
				{ Name = "hour", Type = "number", Nilable = false },
				{ Name = "minute", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CalendarEventSetModerator",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarEventSetRepeatOption",
			Type = "Function",

			Arguments =
			{
				{ Name = "title", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CalendarEventSetSize",
			Type = "Function",

			Arguments =
			{
				{ Name = "size", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CalendarEventSetStatus",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
				{ Name = "inviteStatus", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CalendarEventSetTextureID",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarEventSetTime",
			Type = "Function",

			Arguments =
			{
				{ Name = "hour", Type = "number", Nilable = false },
				{ Name = "minute", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CalendarEventSetTitle",
			Type = "Function",

			Arguments =
			{
				{ Name = "title", Type = "string", Nilable = false },
			},

		},
		{
			Name = "CalendarEventSetType",
			Type = "Function",

			Arguments =
			{
				{ Name = "eventType", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CalendarEventSignUp",
			Type = "Function",

		},
		{
			Name = "CalendarEventSortInvites",
			Type = "Function",

			Arguments =
			{
				{ Name = "criterion", Type = "string", Nilable = false },
				{ Name = "reverse", Type = "bool", Nilable = false },
			},

		},
		{
			Name = "CalendarGetAbsMonth",
			Type = "Function",

			Arguments =
			{
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
				{ Name = "numDays", Type = "number", Nilable = false },
				{ Name = "firstWeekday", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarGetDate",
			Type = "Function",

			Returns =
			{
				{ Name = "weekday", Type = "number", Nilable = false },
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarGetDayEvent",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "title", Type = "string", Nilable = false },
				{ Name = "hour", Type = "number", Nilable = false },
				{ Name = "minute", Type = "number", Nilable = false },
				{ Name = "calendarType", Type = "string", Nilable = false },
				{ Name = "sequenceType", Type = "string", Nilable = false },
				{ Name = "eventType", Type = "number", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
				{ Name = "modStatus", Type = "number", Nilable = false },
				{ Name = "inviteStatus", Type = "string", Nilable = false },
				{ Name = "invitedBy", Type = "string", Nilable = false },
				{ Name = "difficulty", Type = "number", Nilable = false },
				{ Name = "inviteType", Type = "string", Nilable = false },
			},
		},
		{
			Name = "CalendarGetEventIndex",
			Type = "Function",

			Returns =
			{
				{ Name = "monthOffset", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "CalendarGetEventInfo",
			Type = "Function",

			Returns =
			{
				{ Name = "title", Type = "string", Nilable = false },
				{ Name = "description", Type = "string", Nilable = false },
				{ Name = "creator", Type = "string", Nilable = false },
				{ Name = "eventType", Type = "number", Nilable = false },
				{ Name = "repeatOption", Type = "number", Nilable = false },
				{ Name = "maxSize", Type = "number", Nilable = false },
				{ Name = "textureIndex", Type = "luaIndex", Nilable = false },
				{ Name = "weekday", Type = "number", Nilable = false },
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
				{ Name = "hour", Type = "number", Nilable = false },
				{ Name = "minute", Type = "number", Nilable = false },
				{ Name = "lockoutWeekday", Type = "number", Nilable = false },
				{ Name = "lockoutMonth", Type = "number", Nilable = false },
				{ Name = "lockoutDay", Type = "number", Nilable = false },
				{ Name = "lockoutYear", Type = "number", Nilable = false },
				{ Name = "lockoutHour", Type = "number", Nilable = false },
				{ Name = "lockoutMinute", Type = "number", Nilable = false },
				{ Name = "locked", Type = "bool", Nilable = false },
				{ Name = "autoApprove", Type = "bool", Nilable = false },
				{ Name = "pendingInvite", Type = "bool", Nilable = false },
				{ Name = "inviteStatus", Type = "number", Nilable = false },
				{ Name = "inviteType", Type = "number", Nilable = false },
				{ Name = "calendarType", Type = "string", Nilable = false },
			},
		},
		{
			Name = "CalendarGetFirstPendingInvite",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "CalendarGetHolidayInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "description", Type = "string", Nilable = false },
				{ Name = "texture", Type = "string", Nilable = false },
			},
		},
		{
			Name = "CalendarGetMaxCreateDate",
			Type = "Function",

			Returns =
			{
				{ Name = "weekday", Type = "number", Nilable = false },
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarGetMaxDate",
			Type = "Function",

			Returns =
			{
				{ Name = "weekday", Type = "number", Nilable = false },
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarGetMinDate",
			Type = "Function",

			Returns =
			{
				{ Name = "weekday", Type = "number", Nilable = false },
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarGetMinHistoryDate",
			Type = "Function",

			Returns =
			{
				{ Name = "weekday", Type = "number", Nilable = false },
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarGetMonth",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = false },
				{ Name = "numDays", Type = "number", Nilable = false },
				{ Name = "firstWeekday", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarGetMonthNames",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "CalendarGetNumDayEvents",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "numEvents", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarGetNumPendingInvites",
			Type = "Function",

			Returns =
			{
				{ Name = "numInvites", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarGetRaidInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "title", Type = "number", Nilable = false },
				{ Name = "calendarType", Type = "string", Nilable = false },
				{ Name = "raidID", Type = "number", Nilable = false },
				{ Name = "hour", Type = "number", Nilable = false },
				{ Name = "minute", Type = "number", Nilable = false },
				{ Name = "difficulty", Type = "number", Nilable = false },
			},
		},
		{
			Name = "CalendarGetWeekdayNames",
			Type = "Function",

			Returns =
			{
				{ Name = "...", Type = "list", Nilable = false },
			},
		},
		{
			Name = "CalendarIsActionPending",
			Type = "Function",

			Returns =
			{
				{ Name = "isPending", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "CalendarMassInviteArenaTeam",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarMassInviteGuild",
			Type = "Function",

			Arguments =
			{
				{ Name = "minLevel", Type = "number", Nilable = false },
				{ Name = "maxLevel", Type = "number", Nilable = false },
				{ Name = "rank", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CalendarNewEvent",
			Type = "Function",

		},
		{
			Name = "CalendarNewGuildAnnouncement",
			Type = "Function",

		},
		{
			Name = "CalendarNewGuildEvent",
			Type = "Function",

		},
		{
			Name = "CalendarOpenEvent",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = false },
				{ Name = "day", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "CalendarRemoveEvent",
			Type = "Function",

		},
		{
			Name = "CalendarSetAbsMonth",
			Type = "Function",

			Arguments =
			{
				{ Name = "month", Type = "number", Nilable = false },
				{ Name = "year", Type = "number", Nilable = true },
			},

		},
		{
			Name = "CalendarSetMonth",
			Type = "Function",

			Arguments =
			{
				{ Name = "monthOffset", Type = "number", Nilable = false },
			},

		},
		{
			Name = "CalendarUpdateEvent",
			Type = "Function",

		},
		{
			Name = "CanEditGuildEvent",
			Type = "Function",

			Returns =
			{
				{ Name = "canEdit", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "OpenCalendar",
			Type = "Function",

		},
	},

	Events =
	{
		{
			Name = "CalendarActionPending",
			Type = "Event",
			LiteralName = "CALENDAR_ACTION_PENDING",
		},
		{
			Name = "CalendarCloseEvent",
			Type = "Event",
			LiteralName = "CALENDAR_CLOSE_EVENT",
		},
		{
			Name = "CalendarEventAlarm",
			Type = "Event",
			LiteralName = "CALENDAR_EVENT_ALARM",
		},
		{
			Name = "CalendarNewEvent",
			Type = "Event",
			LiteralName = "CALENDAR_NEW_EVENT",
		},
		{
			Name = "CalendarOpenEvent",
			Type = "Event",
			LiteralName = "CALENDAR_OPEN_EVENT",
		},
		{
			Name = "CalendarUpdateError",
			Type = "Event",
			LiteralName = "CALENDAR_UPDATE_ERROR",
		},
		{
			Name = "CalendarUpdateEvent",
			Type = "Event",
			LiteralName = "CALENDAR_UPDATE_EVENT",
		},
		{
			Name = "CalendarUpdateEventList",
			Type = "Event",
			LiteralName = "CALENDAR_UPDATE_EVENT_LIST",
		},
		{
			Name = "CalendarUpdateInviteList",
			Type = "Event",
			LiteralName = "CALENDAR_UPDATE_INVITE_LIST",
		},
		{
			Name = "CalendarUpdatePendingInvites",
			Type = "Event",
			LiteralName = "CALENDAR_UPDATE_PENDING_INVITES",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Calendar);
