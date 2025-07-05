local CurrencyConstants =
{
	Tables =
	{
		{
			Name = "CurrencyFlags",
			Type = "Enumeration",
			NumValues = 32,
			MinValue = 1,
			MaxValue = 2147483648,
			Fields =
			{
				{ Name = "CurrencyTradable", Type = "CurrencyFlags", EnumValue = 1 },
				{ Name = "CurrencyAppearsInLootWindow", Type = "CurrencyFlags", EnumValue = 2 },
				{ Name = "CurrencyComputedWeeklyMaximum", Type = "CurrencyFlags", EnumValue = 4 },
				{ Name = "Currency_100_Scaler", Type = "CurrencyFlags", EnumValue = 8 },
				{ Name = "CurrencyNoLowLevelDrop", Type = "CurrencyFlags", EnumValue = 16 },
				{ Name = "CurrencyIgnoreMaxQtyOnLoad", Type = "CurrencyFlags", EnumValue = 32 },
				{ Name = "CurrencyLogOnWorldChange", Type = "CurrencyFlags", EnumValue = 64 },
				{ Name = "CurrencyTrackQuantity", Type = "CurrencyFlags", EnumValue = 128 },
				{ Name = "CurrencyResetTrackedQuantity", Type = "CurrencyFlags", EnumValue = 256 },
				{ Name = "CurrencyUpdateVersionIgnoreMax", Type = "CurrencyFlags", EnumValue = 512 },
				{ Name = "CurrencySuppressChatMessageOnVersionChange", Type = "CurrencyFlags", EnumValue = 1024 },
				{ Name = "CurrencySingleDropInLoot", Type = "CurrencyFlags", EnumValue = 2048 },
				{ Name = "CurrencyHasWeeklyCatchup", Type = "CurrencyFlags", EnumValue = 4096 },
				{ Name = "CurrencyDoNotCompressChat", Type = "CurrencyFlags", EnumValue = 8192 },
				{ Name = "CurrencyDoNotLogAcquisitionToBi", Type = "CurrencyFlags", EnumValue = 16384 },
				{ Name = "CurrencyNoRaidDrop", Type = "CurrencyFlags", EnumValue = 32768 },
				{ Name = "CurrencyNotPersistent", Type = "CurrencyFlags", EnumValue = 65536 },
				{ Name = "CurrencyDeprecated", Type = "CurrencyFlags", EnumValue = 131072 },
				{ Name = "CurrencyDynamicMaximum", Type = "CurrencyFlags", EnumValue = 262144 },
				{ Name = "CurrencySuppressChatMessages", Type = "CurrencyFlags", EnumValue = 524288 },
				{ Name = "CurrencyDoNotToast", Type = "CurrencyFlags", EnumValue = 1048576 },
				{ Name = "CurrencyDestroyExtraOnLoot", Type = "CurrencyFlags", EnumValue = 2097152 },
				{ Name = "CurrencyDontShowTotalInTooltip", Type = "CurrencyFlags", EnumValue = 4194304 },
				{ Name = "CurrencyDontCoalesceInLootWindow", Type = "CurrencyFlags", EnumValue = 8388608 },
				{ Name = "CurrencyAccountWide", Type = "CurrencyFlags", EnumValue = 16777216 },
				{ Name = "CurrencyAllowOverflowMailer", Type = "CurrencyFlags", EnumValue = 33554432 },
				{ Name = "CurrencyHideAsReward", Type = "CurrencyFlags", EnumValue = 67108864 },
				{ Name = "CurrencyHasWarmodeBonus", Type = "CurrencyFlags", EnumValue = 134217728 },
				{ Name = "CurrencyIsAllianceOnly", Type = "CurrencyFlags", EnumValue = 268435456 },
				{ Name = "CurrencyIsHordeOnly", Type = "CurrencyFlags", EnumValue = 536870912 },
				{ Name = "CurrencyLimitWarmodeBonusOncePerTooltip", Type = "CurrencyFlags", EnumValue = 1073741824 },
				{ Name = "DeprecatedCurrencyFlag", Type = "CurrencyFlags", EnumValue = 2147483648 },
			},
		},
		{
			Name = "CurrencyFlagsB",
			Type = "Enumeration",
			NumValues = 4,
			MinValue = 1,
			MaxValue = 8,
			Fields =
			{
				{ Name = "CurrencyBUseTotalEarnedForEarned", Type = "CurrencyFlagsB", EnumValue = 1 },
				{ Name = "CurrencyBShowQuestXPGainInTooltip", Type = "CurrencyFlagsB", EnumValue = 2 },
				{ Name = "CurrencyBNoNotificationMailOnOfflineProgress", Type = "CurrencyFlagsB", EnumValue = 4 },
				{ Name = "CurrencyBBattlenetVirtualCurrency", Type = "CurrencyFlagsB", EnumValue = 8 },
			},
		},
		{
			Name = "CurrencyGainFlags",
			Type = "Enumeration",
			NumValues = 3,
			MinValue = 1,
			MaxValue = 4,
			Fields =
			{
				{ Name = "BonusAward", Type = "CurrencyGainFlags", EnumValue = 1 },
				{ Name = "DroppedFromDeath", Type = "CurrencyGainFlags", EnumValue = 2 },
				{ Name = "FromAccountServer", Type = "CurrencyGainFlags", EnumValue = 4 },
			},
		},
		{
			Name = "CurrencyTokenCategoryFlags",
			Type = "Enumeration",
			NumValues = 4,
			MinValue = 1,
			MaxValue = 8,
			Fields =
			{
				{ Name = "FlagSortLast", Type = "CurrencyTokenCategoryFlags", EnumValue = 1 },
				{ Name = "FlagPlayerItemAssignment", Type = "CurrencyTokenCategoryFlags", EnumValue = 2 },
				{ Name = "Hidden", Type = "CurrencyTokenCategoryFlags", EnumValue = 4 },
				{ Name = "Virtual", Type = "CurrencyTokenCategoryFlags", EnumValue = 8 },
			},
		},
		{
			Name = "LinkedCurrencyFlags",
			Type = "Enumeration",
			NumValues = 3,
			MinValue = 1,
			MaxValue = 4,
			Fields =
			{
				{ Name = "IgnoreAdd", Type = "LinkedCurrencyFlags", EnumValue = 1 },
				{ Name = "IgnoreSubtract", Type = "LinkedCurrencyFlags", EnumValue = 2 },
				{ Name = "SuppressChatLog", Type = "LinkedCurrencyFlags", EnumValue = 4 },
			},
		},
		{
			Name = "PlayerCurrencyFlags",
			Type = "Enumeration",
			NumValues = 2,
			MinValue = 1,
			MaxValue = 2,
			Fields =
			{
				{ Name = "Incremented", Type = "PlayerCurrencyFlags", EnumValue = 1 },
				{ Name = "Loading", Type = "PlayerCurrencyFlags", EnumValue = 2 },
			},
		},
		{
			Name = "PlayerCurrencyFlagsDbFlags",
			Type = "Enumeration",
			NumValues = 5,
			MinValue = 1,
			MaxValue = 16,
			Fields =
			{
				{ Name = "IgnoreMaxQtyOnload", Type = "PlayerCurrencyFlagsDbFlags", EnumValue = 1 },
				{ Name = "Reuse1", Type = "PlayerCurrencyFlagsDbFlags", EnumValue = 2 },
				{ Name = "InBackpack", Type = "PlayerCurrencyFlagsDbFlags", EnumValue = 4 },
				{ Name = "UnusedInUI", Type = "PlayerCurrencyFlagsDbFlags", EnumValue = 8 },
				{ Name = "Reuse2", Type = "PlayerCurrencyFlagsDbFlags", EnumValue = 16 },
			},
		},
	},
};

APIDocumentation:AddDocumentationTable(CurrencyConstants);