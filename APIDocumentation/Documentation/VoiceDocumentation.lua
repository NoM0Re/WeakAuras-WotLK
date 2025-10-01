local Voice =
{
	Name = "Voice",
	Type = "System",
	Namespace = "Voice",

	Functions =
	{
		{
			Name = "AddMute",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
			},

		},
		{
			Name = "AddOrDelMute",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ChannelSilenceAll",
			Type = "Function",

			Arguments =
			{
				{ Name = "channelName", Type = "string", Nilable = true },
				{ Name = "channelId", Type = "number", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ChannelSilenceVoice",
			Type = "Function",

			Arguments =
			{
				{ Name = "channelName", Type = "string", Nilable = true },
				{ Name = "channelId", Type = "number", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ChannelUnSilenceAll",
			Type = "Function",

			Arguments =
			{
				{ Name = "channelName", Type = "string", Nilable = true },
				{ Name = "channelId", Type = "number", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ChannelUnSilenceVoice",
			Type = "Function",

			Arguments =
			{
				{ Name = "channelName", Type = "string", Nilable = true },
				{ Name = "channelId", Type = "number", Nilable = true },
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "ChannelVoiceOff",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = true },
				{ Name = "channelIndex", Type = "luaIndex", Nilable = true },
			},

		},
		{
			Name = "ChannelVoiceOn",
			Type = "Function",

			Arguments =
			{
				{ Name = "channel", Type = "string", Nilable = true },
				{ Name = "channelIndex", Type = "luaIndex", Nilable = true },
			},

		},
		{
			Name = "DelMute",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

		},
		{
			Name = "DisplayChannelVoiceOff",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "DisplayChannelVoiceOn",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "GetActiveVoiceChannel",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "GetMuteName",
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
			Name = "GetMuteStatus",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "channel", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "muteStatus", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetNumMutes",
			Type = "Function",

			Returns =
			{
				{ Name = "numMuted", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumVoiceSessionMembersBySessionID",
			Type = "Function",

			Arguments =
			{
				{ Name = "sessionId", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "numMembers", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetNumVoiceSessions",
			Type = "Function",

			Returns =
			{
				{ Name = "count", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSelectedMute",
			Type = "Function",

			Returns =
			{
				{ Name = "selectedMute", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetVoiceCurrentSessionID",
			Type = "Function",

			Returns =
			{
				{ Name = "id", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetVoiceSessionInfo",
			Type = "Function",

			Arguments =
			{
				{ Name = "session", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "active", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetVoiceSessionMemberInfoBySessionID",
			Type = "Function",

			Arguments =
			{
				{ Name = "session", Type = "number", Nilable = false },
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "voiceActive", Type = "bool", Nilable = false },
				{ Name = "sessionActive", Type = "bool", Nilable = false },
				{ Name = "muted", Type = "bool", Nilable = false },
				{ Name = "squelched", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "GetVoiceStatus",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
				{ Name = "channel", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "status", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsIgnoredOrMuted",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isIgnoredOrMuted", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsMuted",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = true },
				{ Name = "name", Type = "string", Nilable = true },
			},

			Returns =
			{
				{ Name = "muted", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsSilenced",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "channel", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "isSilenced", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsVoiceChatAllowed",
			Type = "Function",

			Returns =
			{
				{ Name = "isAllowed", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "IsVoiceChatAllowedByServer",
			Type = "Function",

		},
		{
			Name = "IsVoiceChatEnabled",
			Type = "Function",

			Returns =
			{
				{ Name = "isEnabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "SetActiveVoiceChannel",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SetActiveVoiceChannelBySessionID",
			Type = "Function",

			Arguments =
			{
				{ Name = "session", Type = "number", Nilable = false },
			},

		},
		{
			Name = "SetSelectedMute",
			Type = "Function",

			Arguments =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},

		},
		{
			Name = "SilenceMember",
			Type = "Function",

		},
		{
			Name = "UnSilenceMember",
			Type = "Function",

		},
		{
			Name = "UnitIsSilenced",
			Type = "Function",

			Arguments =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "channel", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "silenced", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsTalking",
			Type = "Function",

			Arguments =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "state", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "VoiceChat_ActivatePrimaryCaptureCallback",
			Type = "Function",

		},
		{
			Name = "VoiceChat_GetCurrentMicrophoneSignalLevel",
			Type = "Function",

			Returns =
			{
				{ Name = "volume", Type = "number", Nilable = false },
			},
		},
		{
			Name = "VoiceChat_IsPlayingLoopbackSound",
			Type = "Function",

			Arguments =
			{
				{ Name = "isPlaying", Type = "number", Nilable = false },
			},

		},
		{
			Name = "VoiceChat_IsRecordingLoopbackSound",
			Type = "Function",

			Returns =
			{
				{ Name = "isRecording", Type = "number", Nilable = false },
			},
		},
		{
			Name = "VoiceChat_PlayLoopbackSound",
			Type = "Function",

		},
		{
			Name = "VoiceChat_RecordLoopbackSound",
			Type = "Function",

			Arguments =
			{
				{ Name = "seconds", Type = "number", Nilable = false },
			},

		},
		{
			Name = "VoiceChat_StartCapture",
			Type = "Function",

		},
		{
			Name = "VoiceChat_StopCapture",
			Type = "Function",

		},
		{
			Name = "VoiceChat_StopPlayingLoopbackSound",
			Type = "Function",

		},
		{
			Name = "VoiceChat_StopRecordingLoopbackSound",
			Type = "Function",

		},
		{
			Name = "VoiceEnumerateCaptureDevices",
			Type = "Function",

			Arguments =
			{
				{ Name = "deviceIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "deviceName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "VoiceEnumerateOutputDevices",
			Type = "Function",

			Arguments =
			{
				{ Name = "deviceIndex", Type = "luaIndex", Nilable = false },
			},

			Returns =
			{
				{ Name = "device", Type = "string", Nilable = false },
			},
		},
		{
			Name = "VoiceGetCurrentCaptureDevice",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "VoiceGetCurrentOutputDevice",
			Type = "Function",

			Returns =
			{
				{ Name = "index", Type = "luaIndex", Nilable = false },
			},
		},
		{
			Name = "VoiceIsDisabledByClient",
			Type = "Function",

			Returns =
			{
				{ Name = "isDisabled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "VoicePushToTalkStart",
			Type = "Function",

		},
		{
			Name = "VoicePushToTalkStop",
			Type = "Function",

		},
		{
			Name = "VoiceSelectCaptureDevice",
			Type = "Function",

			Arguments =
			{
				{ Name = "deviceName", Type = "string", Nilable = false },
			},

		},
		{
			Name = "VoiceSelectOutputDevice",
			Type = "Function",

			Arguments =
			{
				{ Name = "deviceName", Type = "string", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "VoiceChatEnabledUpdate",
			Type = "Event",
			LiteralName = "VOICE_CHAT_ENABLED_UPDATE",
		},
		{
			Name = "VoiceLeftSession",
			Type = "Event",
			LiteralName = "VOICE_LEFT_SESSION",
		},
		{
			Name = "VoicePlateStart",
			Type = "Event",
			LiteralName = "VOICE_PLATE_START",
			Payload =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "VoicePlateStop",
			Type = "Event",
			LiteralName = "VOICE_PLATE_STOP",
			Payload =
			{
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "VoicePushToTalkStart",
			Type = "Event",
			LiteralName = "VOICE_PUSH_TO_TALK_START",
		},
		{
			Name = "VoicePushToTalkStop",
			Type = "Event",
			LiteralName = "VOICE_PUSH_TO_TALK_STOP",
		},
		{
			Name = "VoiceSelfMute",
			Type = "Event",
			LiteralName = "VOICE_SELF_MUTE",
		},
		{
			Name = "VoiceSessionsUpdate",
			Type = "Event",
			LiteralName = "VOICE_SESSIONS_UPDATE",
		},
		{
			Name = "VoiceStart",
			Type = "Event",
			LiteralName = "VOICE_START",
			Payload =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "VoiceStatusUpdate",
			Type = "Event",
			LiteralName = "VOICE_STATUS_UPDATE",
		},
		{
			Name = "VoiceStop",
			Type = "Event",
			LiteralName = "VOICE_STOP",
			Payload =
			{
				{ Name = "unit", Type = "UnitToken", Nilable = false },
			},
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Voice);
