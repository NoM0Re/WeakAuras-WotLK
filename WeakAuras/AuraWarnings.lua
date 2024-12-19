if not WeakAuras.IsCorrectVersion() then return end
local AddonName, Private = ...

local WeakAuras = WeakAuras
local L = WeakAuras.L

-- keyed on uid, key, { severity, message }
local warnings = {}
local printedWarnings = {}

local function OnDelete(event, uid)
  warnings[uid] = nil
end

Private.callbacks:RegisterCallback("Delete", OnDelete)

local function UpdateWarning(uid, key, severity, message, printOnConsole)
  if not uid then
    WeakAuras.prettyPrint(L["Warning for unknown aura:"], message)
    return
  end
  if printOnConsole then
    printedWarnings[uid] = printedWarnings[uid] or {}
    if printedWarnings[uid][key] == nil then
      WeakAuras.prettyPrint(string.format(L["Aura '%s': %s"], Private.UIDtoID(uid), message))
      printedWarnings[uid][key] = true
    end
  end

  warnings[uid] = warnings[uid] or {}
  if severity and message then
    warnings[uid][key] = {
      severity = severity,
      message = message
    }
    Private.callbacks:Fire("AuraWarningsUpdated", uid)
  else
    if warnings[uid][key] then
      warnings[uid][key] = nil
      Private.callbacks:Fire("AuraWarningsUpdated", uid)
    end
  end
end

local severityLevel = {
  info = 0,
  sound = 1,
  warning = 2,
  error = 3
}

local icons = {
  info = { path = [[Interface\friendsframe\informationicon]] },
  sound = { path = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\ChatFrame", texCoords = {0.757812, 0.871094, 0.0078125, 0.234375} },
  warning = { path = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\ServicesAtlas", texCoords = {0.000976562, 0.0419922, 0.961914, 0.998047} },
  error = { path = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\HelpIcon-Bug" },
}

local titles = {
  info = L["Information"],
  sound = L["Sound"],
  warning = L["Warning"],
  error = L["Error"]
}

local function AddMessages(result, messages, icon, mixedSeverity)
  if not messages then
    return result
  end
  for index, message in ipairs(messages) do
    if result ~= "" then
      result = result .. "\n\n"
    end
    if mixedSeverity then
      local iconPath = icon.path
      local texCoords = icon.texCoords
      if texCoords then
      result = result .. string.format("|T%s:12:12:0:0:64:64:%d:%d:%d:%d|t", iconPath, texCoords[1] * 64, texCoords[2] * 64, texCoords[3] * 64, texCoords[4] * 64)
      else
      result = result .. string.format("|T%s:12:12:0:0:64:64:4:60:4:60|t", iconPath)
      end
    end
    result = result .. message
  end
  return result
end

local function FormatWarnings(uid)
  if not warnings[uid] then
    return
  end

  local maxSeverity
  local mixedSeverity = false

  local messagePerSeverity = {}

  for key, warning in pairs(warnings[uid]) do
    if not maxSeverity then
      maxSeverity = warning.severity
    elseif severityLevel[warning.severity] > severityLevel[maxSeverity] then
      maxSeverity = warning.severity
    elseif severityLevel[warning.severity] < severityLevel[maxSeverity] then
      mixedSeverity = true
    end
    messagePerSeverity[warning.severity] = messagePerSeverity[warning.severity] or {}
    tinsert(messagePerSeverity[warning.severity], warning.message)
  end

  if not maxSeverity then
    return
  end

  local result = ""
  result = AddMessages(result, messagePerSeverity["error"], icons["error"], mixedSeverity)
  result = AddMessages(result, messagePerSeverity["warning"], icons["warning"], mixedSeverity)
  result = AddMessages(result, messagePerSeverity["sound"], icons["sound"], mixedSeverity)
  result = AddMessages(result, messagePerSeverity["info"], icons["info"], mixedSeverity)
  return icons[maxSeverity], titles[maxSeverity], result
end

local function GetAllWarnings(uid)
  local results = {}
  local thisWarnings
  local data = Private.GetDataByUID(uid)
  if data.regionType == "group" or data.regionType == "dynamicgroup" then
    thisWarnings = {}
    for child in Private.TraverseLeafs(data) do
      local childWarnings = warnings[child.uid]
      if childWarnings then
        for key, warning in pairs(childWarnings) do
          if not thisWarnings[key] then
            thisWarnings[key] = {
              severity = warning.severity,
              message = warning.message,
              auraId = child.id
            }
          end
        end
      end
    end
  else
    thisWarnings = CopyTable(warnings[uid])
    local auraId = Private.UIDtoID(uid)
    for key in pairs(thisWarnings) do
      thisWarnings[key].auraId = auraId
    end
  end
  -- Order them by severity, keeping just one per severity
  for key, warning in pairs(thisWarnings) do
    results[warning.severity] = {
      icon = icons[warning.severity],
      prio = 5 + severityLevel[warning.severity],
      title = titles[warning.severity] or warning.severity,
      message = warning.message,
      auraId = warning.auraId,
      key = key
    }
  end
  return results
end

Private.AuraWarnings = {}
Private.AuraWarnings.UpdateWarning = UpdateWarning
Private.AuraWarnings.FormatWarnings = FormatWarnings
Private.AuraWarnings.GetAllWarnings = GetAllWarnings
