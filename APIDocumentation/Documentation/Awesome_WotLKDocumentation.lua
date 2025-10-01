local Awesome_WotLK =
{
	Name = "Awesome WotLK",
	Type = "System",
	Namespace = "Awesome WotLK",

	Functions =
	{
		{
			Name = "C_NamePlate.GetNamePlateForUnit",
			Type = "Function",

			Arguments =
			{
				{ Name = "unitId", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "namePlate", Type = "frame", Nilable = false },
			},
		},
		{
			Name = "C_NamePlate.GetNamePlates",
			Type = "Function",

			Returns =
			{
				{ Name = "namePlateList", Type = "table", Nilable = false },
			},
		},
		{
			Name = "C_NamePlate.GetNamePlateByGUID",
			Type = "Function",

			Arguments =
			{
				{ Name = "GUID", Type = "WOWGUID", Nilable = false },
			},

			Returns =
			{
				{ Name = "namePlateList", Type = "frame", Nilable = false },
			},
		},
		{
			Name = "C_NamePlate.GetNamePlateTokenByGUID",
			Type = "Function",

			Arguments =
			{
				{ Name = "GUID", Type = "WOWGUID", Nilable = false },
			},

			Returns =
			{
				{ Name = "unitId", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "C_VoiceChat.GetTtsVoices",
			Type = "Function",

			Returns =
			{
				{ Name = "voiceList", Type = "table", Nilable = false },
			},
		},
		{
			Name = "C_VoiceChat.GetRemoteTtsVoices",
			Type = "Function",

			Returns =
			{
				{ Name = "voiceList", Type = "table", Nilable = false },
			},
		},
		{
			Name = "C_VoiceChat.SpeakText",
			Type = "Function",

			Arguments =
			{
				{ Name = "voiceID", Type = "number", Nilable = false },
				{ Name = "text", Type = "string", Nilable = false },
				{ Name = "destination", Type = "number", Nilable = true },
				{ Name = "rate", Type = "number", Nilable = true },
				{ Name = "volume", Type = "number", Nilable = true },
			},

			Returns =
			{
				{ Name = "utteranceID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "C_VoiceChat.StopSpeakingText",
			Type = "Function",

		},
		{
			Name = "C_TTSSettings.GetSpeechRate",
			Type = "Function",

			Returns =
			{
				{ Name = "rate", Type = "number", Nilable = false },
			},
		},
		{
			Name = "C_TTSSettings.GetSpeechVolume",
			Type = "Function",

			Returns =
			{
				{ Name = "volume", Type = "number", Nilable = false },
			},
		},
		{
			Name = "C_TTSSettings.GetSpeechVoiceID",
			Type = "Function",

			Returns =
			{
				{ Name = "voiceID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "C_TTSSettings.GetVoiceOptionName",
			Type = "Function",

			Returns =
			{
				{ Name = "voiceName", Type = "string", Nilable = false },
			},
		},
		{
			Name = "C_TTSSettings.SetDefaultSettings",
			Type = "Function",

		},
		{
			Name = "C_TTSSettings.SetSpeechRate",
			Type = "Function",

			Arguments =
			{
				{ Name = "rate", Type = "number", Nilable = false },
			},

		},
		{
			Name = "C_TTSSettings.SetSpeechVolume",
			Type = "Function",

			Arguments =
			{
				{ Name = "volume", Type = "number", Nilable = false },
			},

		},
		{
			Name = "C_TTSSettings.SetVoiceOption",
			Type = "Function",

			Arguments =
			{
				{ Name = "voiceID", Type = "number", Nilable = false },
			},

		},
		{
			Name = "C_TTSSettings.SetVoiceOptionByName",
			Type = "Function",

			Arguments =
			{
				{ Name = "voiceName", Type = "string", Nilable = false },
			},

		},
		{
			Name = "C_TTSSettings.RefreshVoices",
			Type = "Function",

		},
		{
			Name = "UnitIsControlled",
			Type = "Function",

			Arguments =
			{
				{ Name = "unitId", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isControlled", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsDisarmed",
			Type = "Function",

			Arguments =
			{
				{ Name = "unitId", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isDisarmed", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitIsSilenced",
			Type = "Function",

			Arguments =
			{
				{ Name = "unitId", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "isSilenced", Type = "bool", Nilable = false },
			},
		},
		{
			Name = "UnitOccupations",
			Type = "Function",

			Arguments =
			{
				{ Name = "unitId", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "npcFlags", Type = "number", Nilable = false },
			},
		},
		{
			Name = "UnitOwner",
			Type = "Function",

			Arguments =
			{
				{ Name = "unitId", Type = "UnitToken", Nilable = false },
			},

			Returns =
			{
				{ Name = "ownerName", Type = "string", Nilable = false },
				{ Name = "ownerGuid", Type = "WOWGUID", Nilable = false },
			},
		},
		{
			Name = "UnitTokenFromGUID",
			Type = "Function",

			Arguments =
			{
				{ Name = "GUID", Type = "WOWGUID", Nilable = false },
			},

			Returns =
			{
				{ Name = "UnitToken", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "GetInventoryItemTransmog",
			Type = "Function",

			Arguments =
			{
				{ Name = "unitId", Type = "UnitToken", Nilable = false },
				{ Name = "slot", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "itemId", Type = "number", Nilable = false },
				{ Name = "enchantId", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetSpellBaseCooldown",
			Type = "Function",

			Arguments =
			{
				{ Name = "spellId", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "cdMs", Type = "number", Nilable = false },
				{ Name = "gcdMs", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetItemInfoInstant",
			Type = "Function",

			Arguments =
			{
				{ Name = "itemId/itemName/itemHyperlink", Type = "string", Nilable = false },
			},

			Returns =
			{
				{ Name = "itemID", Type = "number", Nilable = false },
				{ Name = "itemType", Type = "string", Nilable = false },
				{ Name = "itemSubType", Type = "string", Nilable = false },
				{ Name = "itemEquipLoc", Type = "string", Nilable = false },
				{ Name = "icon", Type = "string", Nilable = false },
				{ Name = "classID", Type = "number", Nilable = false },
				{ Name = "subclassID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "FlashWindow",
			Type = "Function",

		},
		{
			Name = "IsWindowFocused",
			Type = "Function",

		},
		{
			Name = "FocusWindow",
			Type = "Function",

		},
		{
			Name = "CopyToClipboard",
			Type = "Function",

			Arguments =
			{
				{ Name = "text", Type = "string", Nilable = false },
			},

		},
	},

	Events =
	{
		{
			Name = "NamePlateCreated",
			Type = "Event",
			LiteralName = "NAME_PLATE_CREATED",
			Payload =
			{
				{ Name = "namePlateBase", Type = "frame", Nilable = false },
			},
		},
		{
			Name = "NamePlateUnitAdded",
			Type = "Event",
			LiteralName = "NAME_PLATE_UNIT_ADDED",
			Payload =
			{
				{ Name = "unitId", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "NamePlateUnitRemoved",
			Type = "Event",
			LiteralName = "NAME_PLATE_UNIT_REMOVED",
			Payload =
			{
				{ Name = "unitId", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "NamePlateOwnerChanged",
			Type = "Event",
			LiteralName = "NAME_PLATE_OWNER_CHANGED",
			Payload =
			{
				{ Name = "unitId", Type = "UnitToken", Nilable = false },
			},
		},
		{
			Name = "VoiceChatTtsPlaybackStarted",
			Type = "Event",
			LiteralName = "VOICE_CHAT_TTS_PLAYBACK_STARTED",
			Payload =
			{
				{ Name = "numConsumers", Type = "number", Nilable = false },
				{ Name = "utteranceID", Type = "number", Nilable = false },
				{ Name = "durationMS", Type = "time_t", Nilable = false },
				{ Name = "destination", Type = "number", Nilable = false },
			},
		},
		{
			Name = "VoiceChatTtsPlaybackFinished",
			Type = "Event",
			LiteralName = "VOICE_CHAT_TTS_PLAYBACK_FINISHED",
			Payload =
			{
				{ Name = "numConsumers", Type = "number", Nilable = false },
				{ Name = "utteranceID", Type = "number", Nilable = false },
				{ Name = "destination", Type = "number", Nilable = false },
			},
		},
		{
			Name = "VoiceChatTtsPlaybackFailed",
			Type = "Event",
			LiteralName = "VOICE_CHAT_TTS_PLAYBACK_FAILED",
			Payload =
			{
				{ Name = "status", Type = "string", Nilable = false },
				{ Name = "utteranceID", Type = "number", Nilable = false },
				{ Name = "destination", Type = "number", Nilable = false },
			},
		},
		{
			Name = "VoiceChatTtsSpeakTextUpdate",
			Type = "Event",
			LiteralName = "VOICE_CHAT_TTS_SPEAK_TEXT_UPDATE",
			Payload =
			{
				{ Name = "status", Type = "string", Nilable = false },
				{ Name = "utteranceID", Type = "number", Nilable = false },
			},
		},
		{
			Name = "VoiceChatTtsVoicesUpdate",
			Type = "Event",
			LiteralName = "VOICE_CHAT_TTS_VOICES_UPDATE",
		},
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Awesome_WotLK);
