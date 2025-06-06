if not WeakAuras.IsLibsOK() then return end
local AddonName = ...
local Private = select(2, ...)
local L = WeakAuras.L

-- Takes as input a table of display data and attempts to update it to be compatible with the current version
--- Modernizes the aura data
function Private.Modernize(data, oldSnapshot)
  if not data.internalVersion or data.internalVersion < 2 then
    WeakAuras.prettyPrint(string.format("Data for '%s' is too old, can't modernize.", data.id))
    data.internalVersion = 2
  end

  -- Version 3 was introduced April 2018 in Legion
  if data.internalVersion < 3 then
    if data.parent then
      local parentData = WeakAuras.GetData(data.parent)
      if parentData and parentData.regionType == "dynamicgroup" then
        -- Version 3 allowed for offsets for dynamic groups, before that they were ignored
        -- Thus reset them in the V2 to V3 upgrade
        data.xOffset = 0
        data.yOffset = 0
      end
    end
  end

  -- Version 4 was introduced July 2018 in BfA
  if data.internalVersion < 4 then
    if data.conditions then
      for conditionIndex, condition in ipairs(data.conditions) do
        if condition.check then
          local triggernum = condition.check.trigger
          if triggernum then
            local trigger
            if triggernum == 0 then
              trigger = data.trigger
            elseif data.additional_triggers and data.additional_triggers[triggernum] then
              trigger = data.additional_triggers[triggernum].trigger
            end
            if trigger and trigger.event == "Cooldown Progress (Spell)" then
              if condition.check.variable == "stacks" then
                condition.check.variable = "charges"
              end
            end
          end
        end
      end
    end
  end

  -- Version 5 was introduced July 2018 in BfA
  if data.internalVersion < 5 then
    -- this is to fix hybrid sorting
    if data.sortHybridTable then
      if data.controlledChildren then
        local newSortTable = {}
        for index, isHybrid in pairs(data.sortHybridTable) do
          local childID = data.controlledChildren[index]
          if childID then
            newSortTable[childID] = isHybrid
          end
        end
        data.sortHybridTable = newSortTable
      end
    end
  end

  -- Version 6 was introduced July 30 2018 in BfA
  if data.internalVersion < 6 then
    if data.triggers then
      for triggernum, triggerData in ipairs(data.triggers) do
        local trigger = triggerData.trigger
        if trigger and trigger.type == "aura" then
          if trigger.showOn == "showOnMissing" then
            trigger.buffShowOn = "showOnMissing"
          elseif trigger.showOn == "showActiveOrMissing" then
            trigger.buffShowOn = "showAlways"
          else
            trigger.buffShowOn = "showOnActive"
          end
          trigger.showOn = nil
        elseif trigger and trigger.type ~= "aura" then
          trigger.genericShowOn = trigger.showOn or "showOnActive"
          trigger.showOn = nil
          trigger.use_genericShowOn = trigger.use_showOn
        end
      end
    end
  end

  -- Version 7 was introduced September 1 2018 in BfA
  -- Triggers were cleaned up into a 1-indexed array
  if data.internalVersion < 7 then
    -- migrate trigger data
    data.triggers = data.additional_triggers or {}
    tinsert(data.triggers, 1, {
      trigger = data.trigger or {},
      untrigger = data.untrigger or {},
    })
    data.additional_triggers = nil
    data.trigger = nil
    data.untrigger = nil
    data.numTriggers = nil
    data.triggers.customTriggerLogic = data.customTriggerLogic
    data.customTriggerLogic = nil
    local activeTriggerMode = data.activeTriggerMode or Private.trigger_modes.first_active
    if activeTriggerMode ~= Private.trigger_modes.first_active then
      activeTriggerMode = activeTriggerMode + 1
    end
    data.triggers.activeTriggerMode = activeTriggerMode
    data.activeTriggerMode = nil
    data.triggers.disjunctive = data.disjunctive
    data.disjunctive = nil
    -- migrate condition trigger references
    local function recurseRepairChecks(checks)
      if not checks then
        return
      end
      for _, check in pairs(checks) do
        if check.trigger and check.trigger >= 0 then
          check.trigger = check.trigger + 1
        end
        recurseRepairChecks(check.checks)
      end
    end
    for _, condition in pairs(data.conditions) do
      if condition.check.trigger and condition.check.trigger >= 0 then
        condition.check.trigger = condition.check.trigger + 1
      end
      recurseRepairChecks(condition.check.checks)
    end
  end

  -- Version 8 was introduced in September 2018
  -- Changes are in PreAdd

  -- Version 9 was introduced in September 2018
  if data.internalVersion < 9 then
    local function repairCheck(check)
      if check and check.variable == "buffed" then
        local trigger = check.trigger and data.triggers[check.trigger] and data.triggers[check.trigger].trigger
        if trigger then
          if trigger.buffShowOn == "showOnActive" then
            check.variable = "show"
          elseif trigger.buffShowOn == "showOnMissing" then
            check.variable = "show"
            check.value = check.value == 0 and 1 or 0
          end
        end
      end
    end

    local function recurseRepairChecks(checks)
      if not checks then
        return
      end
      for _, check in pairs(checks) do
        repairCheck(check)
        recurseRepairChecks(check.checks)
      end
    end
    for _, condition in pairs(data.conditions) do
      repairCheck(condition.check)
      recurseRepairChecks(condition.check.checks)
    end
  end

  -- Version 10 is skipped, due to a bad migration script (see https://github.com/WeakAuras/WeakAuras2/pull/1091)

  -- Version 11 was introduced in January 2019
  if data.internalVersion < 11 then
    if data.url and data.url ~= "" then
      local slug, version = data.url:match("wago.io/([^/]+)/([0-9]+)")
      if not slug and not version then
        version = 1
      end
      if version and tonumber(version) then
        data.version = tonumber(version)
      end
    end
  end

  -- Version 13 was introduced March 2019 in BfA
  if data.internalVersion < 13 then
    if data.regionType == "dynamicgroup" then
      local selfPoints = {
        default = "CENTER",
        RIGHT = function(data)
          if data.align == "LEFT" then
            return "TOPLEFT"
          elseif data.align == "RIGHT" then
            return "BOTTOMLEFT"
          else
            return "LEFT"
          end
        end,
        LEFT = function(data)
          if data.align == "LEFT" then
            return "TOPRIGHT"
          elseif data.align == "RIGHT" then
            return "BOTTOMRIGHT"
          else
            return "RIGHT"
          end
        end,
        UP = function(data)
          if data.align == "LEFT" then
            return "BOTTOMLEFT"
          elseif data.align == "RIGHT" then
            return "BOTTOMRIGHT"
          else
            return "BOTTOM"
          end
        end,
        DOWN = function(data)
          if data.align == "LEFT" then
            return "TOPLEFT"
          elseif data.align == "RIGHT" then
            return "TOPRIGHT"
          else
            return "TOP"
          end
        end,
        HORIZONTAL = function(data)
          if data.align == "LEFT" then
            return "TOP"
          elseif data.align == "RIGHT" then
            return "BOTTOM"
          else
            return "CENTER"
          end
        end,
        VERTICAL = function(data)
          if data.align == "LEFT" then
            return "LEFT"
          elseif data.align == "RIGHT" then
            return "RIGHT"
          else
            return "CENTER"
          end
        end,
        CIRCLE = "CENTER",
        COUNTERCIRCLE = "CENTER",
      }
      local selfPoint = selfPoints[data.grow or "DOWN"] or selfPoints.DOWN
      if type(selfPoint) == "function" then
        selfPoint = selfPoint(data)
      end
      data.selfPoint = selfPoint
    end
  end

  -- Version 14 was introduced March 2019 in BfA
  if data.internalVersion < 14 then
    if data.triggers then
      for triggerId, triggerData in pairs(data.triggers) do
        if
          type(triggerData) == "table"
          and triggerData.trigger
          and triggerData.trigger.debuffClass
          and type(triggerData.trigger.debuffClass) == "string"
          and triggerData.trigger.debuffClass ~= ""
        then
          local idx = triggerData.trigger.debuffClass
          data.triggers[triggerId].trigger.debuffClass = { [idx] = true }
        end
      end
    end
  end

  -- Version 15 was introduced April 2019 in BfA
  if data.internalVersion < 15 then
    if data.triggers then
      for triggerId, triggerData in ipairs(data.triggers) do
        if triggerData.trigger.type == "status" and triggerData.trigger.event == "Spell Known" then
          triggerData.trigger.use_exact_spellName = true
        end
      end
    end
  end

  -- Version 16 was introduced May 2019 in BfA
  if data.internalVersion < 16 then
    -- second conversion: migrate name/realm conditions to tristate
    if data.load.use_name == false then
      data.load.use_name = nil
    end
    if data.load.use_realm == false then
      data.load.use_realm = nil
    end
  end

  -- Version 18 was a migration for stance/form trigger, but deleted later because of migration issue

  -- Version 19 were introduced in July 2019 in BfA
  if WeakAuras.IsAwesomeEnabled() then
    if data.internalVersion < 19 then
      if data.triggers then
        for triggerId, triggerData in ipairs(data.triggers) do
          if triggerData.trigger.type == "status" and triggerData.trigger.event == "Cast" and triggerData.trigger.unit == "multi" then
            triggerData.trigger.unit = "nameplate"
          end
        end
      end
    end
  end

  -- Version 20 was introduced July 2019 in BfA
  if data.internalVersion < 20 then
    if data.regionType == "icon" then
      local convertPoint = function(containment, point)
        if not point or point == "CENTER" then
          return "CENTER"
        elseif containment == "INSIDE" then
          return "INNER_" .. point
        elseif containment == "OUTSIDE" then
          return "OUTER_" .. point
        end
      end

      local text1 = {
        ["type"] = "subtext",
        text_visible = data.text1Enabled ~= false,
        text_color = data.text1Color,
        text_text = data.text1,
        text_font = data.text1Font,
        text_fontSize = data.text1FontSize,
        text_fontType = data.text1FontFlags,
        text_selfPoint = "AUTO",
        text_anchorPoint = convertPoint(data.text1Containment, data.text1Point),
        anchorXOffset = 0,
        anchorYOffset = 0,
        text_shadowColor = { 0, 0, 0, 1 },
        text_shadowXOffset = 0,
        text_shadowYOffset = 0,
      }

      local usetext2 = data.text2Enabled

      local text2 = {
        ["type"] = "subtext",
        text_visible = data.text2Enabled or false,
        text_color = data.text2Color,
        text_text = data.text2,
        text_font = data.text2Font,
        text_fontSize = data.text2FontSize,
        text_fontType = data.text2FontFlags,
        text_selfPoint = "AUTO",
        text_anchorPoint = convertPoint(data.text2Containment, data.text2Point),
        anchorXOffset = 0,
        anchorYOffset = 0,
        text_shadowColor = { 0, 0, 0, 1 },
        text_shadowXOffset = 0,
        text_shadowYOffset = 0,
      }

      data.text1Enabled = nil
      data.text1Color = nil
      data.text1 = nil
      data.text1Font = nil
      data.text1FontSize = nil
      data.text1FontFlags = nil
      data.text1Containment = nil
      data.text1Point = nil

      data.text2Enabled = nil
      data.text2Color = nil
      data.text2 = nil
      data.text2Font = nil
      data.text2FontSize = nil
      data.text2FontFlags = nil
      data.text2Containment = nil
      data.text2Point = nil

      local propertyRenames = {
        text1Color = "sub.1.text_color",
        text1FontSize = "sub.1.text_fontSize",
        text2Color = "sub.2.text_color",
        text2FontSize = "sub.2.text_fontSize",
      }

      data.subRegions = data.subRegions or {}
      tinsert(data.subRegions, text1)
      if usetext2 then
        tinsert(data.subRegions, text2)
      end

      if data.conditions then
        for conditionIndex, condition in ipairs(data.conditions) do
          for changeIndex, change in ipairs(condition.changes) do
            if propertyRenames[change.property] then
              change.property = propertyRenames[change.property]
            end
          end
        end
      end
    end
  end

  -- Version 20 was introduced May 2019 in BfA
  if data.internalVersion < 20 then
    if data.regionType == "aurabar" then
      local orientationToPostion = {
        HORIZONTAL_INVERSE = { "INNER_LEFT", "INNER_RIGHT" },
        HORIZONTAL = { "INNER_RIGHT", "INNER_LEFT" },
        VERTICAL_INVERSE = { "INNER_BOTTOM", "INNER_TOP" },
        VERTICAL = { "INNER_TOP", "INNER_BOTTOM" },
      }

      local positions = orientationToPostion[data.orientation] or { "INNER_LEFT", "INNER_RIGHT" }

      local text1 = {
        ["type"] = "subtext",
        text_visible = data.timer,
        text_color = data.timerColor,
        text_text = data.displayTextRight,
        text_font = data.timerFont,
        text_fontSize = data.timerSize,
        text_fontType = data.timerFlags,
        text_selfPoint = "AUTO",
        text_anchorPoint = positions[1],
        anchorXOffset = 0,
        anchorYOffset = 0,
        text_shadowColor = { 0, 0, 0, 1 },
        text_shadowXOffset = 1,
        text_shadowYOffset = -1,
        rotateText = data.rotateText,
      }

      local text2 = {
        ["type"] = "subtext",
        text_visible = data.text,
        text_color = data.textColor,
        text_text = data.displayTextLeft,
        text_font = data.textFont,
        text_fontSize = data.textSize,
        text_fontType = data.textFlags,
        text_selfPoint = "AUTO",
        text_anchorPoint = positions[2],
        anchorXOffset = 0,
        anchorYOffset = 0,
        text_shadowColor = { 0, 0, 0, 1 },
        text_shadowXOffset = 1,
        text_shadowYOffset = -1,
        rotateText = data.rotateText,
      }

      local text3 = {
        ["type"] = "subtext",
        text_visible = data.stacks,
        text_color = data.stacksColor,
        text_text = "%s",
        text_font = data.stacksFont,
        text_fontSize = data.stacksSize,
        text_fontType = data.stacksFlags,
        text_selfPoint = "AUTO",
        text_anchorPoint = "ICON_CENTER",
        anchorXOffset = 0,
        anchorYOffset = 0,
        text_shadowColor = { 0, 0, 0, 1 },
        text_shadowXOffset = 1,
        text_shadowYOffset = -1,
        rotateText = data.rotateText,
      }

      data.timer = nil
      data.textColor = nil
      data.displayTextRight = nil
      data.textFont = nil
      data.textSize = nil
      data.textFlags = nil
      data.text = nil
      data.timerColor = nil
      data.displayTextLeft = nil
      data.timerFont = nil
      data.timerSize = nil
      data.timerFlags = nil
      data.stacks = nil
      data.stacksColor = nil
      data.stacksFont = nil
      data.stacksSize = nil
      data.stacksFlags = nil
      data.rotateText = nil

      local propertyRenames = {
        timerColor = "sub.1.text_color",
        timerSize = "sub.1.text_fontSize",
        textColor = "sub.2.text_color",
        textSize = "sub.2.text_fontSize",
        stacksColor = "sub.3.text_color",
        stacksSize = "sub.3.text_fontSize",
      }

      data.subRegions = data.subRegions or {}
      tinsert(data.subRegions, text1)
      tinsert(data.subRegions, text2)
      tinsert(data.subRegions, text3)

      if data.conditions then
        for conditionIndex, condition in ipairs(data.conditions) do
          for changeIndex, change in ipairs(condition.changes) do
            if propertyRenames[change.property] then
              change.property = propertyRenames[change.property]
            end
          end
        end
      end
    end
  end

  if data.internalVersion < 21 then
    if data.regionType == "dynamicgroup" then
      data.border = data.background and data.background ~= "None"
      data.borderEdge = data.border
      data.borderBackdrop = data.background ~= "None" and data.background
      data.borderInset = data.backgroundInset
      data.background = nil
      data.backgroundInset = nil
    end
  end

  if data.internalVersion < 22 then
    if data.regionType == "aurabar" then
      data.subRegions = data.subRegions or {}

      local border = {
        ["type"] = "subborder",
        border_visible = data.border,
        border_color = data.borderColor,
        border_edge = data.borderEdge,
        border_offset = data.borderOffset,
        border_size = data.borderSize,
        border_anchor = "bar",
      }

      data.border = nil
      data.borderColor = nil
      data.borderEdge = nil
      data.borderOffset = nil
      data.borderInset = nil
      data.borderSize = nil
      if data.borderInFront then
        tinsert(data.subRegions, border)
      else
        tinsert(data.subRegions, 1, border)
      end

      local propertyRenames = {
        borderColor = "sub." .. #data.subRegions .. ".border_color",
      }

      if data.conditions then
        for conditionIndex, condition in ipairs(data.conditions) do
          for changeIndex, change in ipairs(condition.changes) do
            if propertyRenames[change.property] then
              change.property = propertyRenames[change.property]
            end
          end
        end
      end
    end
  end

  if data.internalVersion < 23 then
    if data.triggers then
      for triggerId, triggerData in ipairs(data.triggers) do
        local trigger = triggerData.trigger
        -- Stance/Form/Aura form field type changed from type="select" to type="multiselect"
        if trigger and trigger.type == "status" and trigger.event == "Stance/Form/Aura" then
          local value = trigger.form
          if type(value) ~= "table" then
            if trigger.use_form == false then
              if value then
                trigger.form = { multi = { [value] = true } }
              else
                trigger.form = { multi = {} }
              end
            elseif trigger.use_form then
              trigger.form = { single = value }
            end
          end
        end
      end
    end
  end

  if data.internalVersion < 24 then
    if data.triggers then
      for triggerId, triggerData in ipairs(data.triggers) do
        local trigger = triggerData.trigger
        if trigger and trigger.type == "status" and trigger.event == "Weapon Enchant" then
          if trigger.use_inverse then
            trigger.showOn = "showOnMissing"
          else
            trigger.showOn = "showOnActive"
          end
          trigger.use_inverse = nil
          if not trigger.use_weapon then
            trigger.use_weapon = "true"
            trigger.weapon = "main"
          end
        end
      end
    end
  end

  if data.internalVersion < 25 then
    if data.regionType == "icon" then
      data.subRegions = data.subRegions or {}
      -- Need to check if glow is needed

      local prefix = "sub." .. #data.subRegions + 1 .. "."
      -- For Conditions
      local propertyRenames = {
        glow = prefix .. "glow",
        useGlowColor = prefix .. "useGlowColor",
        glowColor = prefix .. "glowColor",
        glowType = prefix .. "glowType",
        glowLines = prefix .. "glowLines",
        glowFrequency = prefix .. "glowFrequency",
        glowLength = prefix .. "glowLength",
        glowThickness = prefix .. "glowThickness",
        glowScale = prefix .. "glowScale",
        glowBorder = prefix .. "glowBorder",
        glowXOffset = prefix .. "glowXOffset",
        glowYOffset = prefix .. "glowYOffset",
      }

      local needsGlow = data.glow
      if not needsGlow and data.conditions then
        for conditionIndex, condition in ipairs(data.conditions) do
          for changeIndex, change in ipairs(condition.changes) do
            if propertyRenames[change.property] then
              needsGlow = true
              break
            end
          end
        end
      end

      if needsGlow then
        local glow = {
          ["type"] = "subglow",
          glow = data.glow,
          useGlowColor = data.useGlowColor,
          glowColor = data.glowColor,
          glowType = data.glowType,
          glowLines = data.glowLines,
          glowFrequency = data.glowFrequency,
          glowLength = data.glowLength,
          glowThickness = data.glowThickness,
          glowScale = data.glowScale,
          glowBorder = data.glowBorder,
          glowXOffset = data.glowXOffset,
          glowYOffset = data.glowYOffset,
        }
        tinsert(data.subRegions, glow)
      end

      data.glow = nil
      data.useglowColor = nil
      data.useGlowColor = nil
      data.glowColor = nil
      data.glowType = nil
      data.glowLines = nil
      data.glowFrequency = nil
      data.glowLength = nil
      data.glowThickness = nil
      data.glowScale = nil
      data.glowBorder = nil
      data.glowXOffset = nil
      data.glowYOffset = nil

      if data.conditions then
        for conditionIndex, condition in ipairs(data.conditions) do
          for changeIndex, change in ipairs(condition.changes) do
            if propertyRenames[change.property] then
              change.property = propertyRenames[change.property]
            end
          end
        end
      end
    end
  end

  if data.internalVersion < 26 then
    if data.conditions then
      for conditionIndex, condition in ipairs(data.conditions) do
        for changeIndex, change in ipairs(condition.changes) do
          if change.property == "xOffset" or change.property == "yOffset" then
            change.value = (change.value or 0) - (data[change.property] or 0)
            change.property = change.property .. "Relative"
          end
        end
      end
    end
  end

  if data.internalVersion < 28 then
    if data.actions then
      if data.actions.start and data.actions.start.do_glow then
        data.actions.start.glow_frame_type = "FRAMESELECTOR"
      end
      if data.actions.finish and data.actions.finish.do_glow then
        data.actions.finish.glow_frame_type = "FRAMESELECTOR"
      end
    end
  end

  if data.internalVersion < 29 then
    if data.actions then
      if data.actions.start and data.actions.start.do_glow and data.actions.start.glow_type == nil then
        data.actions.start.glow_type = "buttonOverlay"
      end
      if data.actions.finish and data.actions.finish.do_glow and data.actions.finish.glow_type == nil then
        data.actions.finish.glow_type = "buttonOverlay"
      end
    end
  end

  if data.internalVersion < 30 then
    local convertLegacyPrecision = function(precision)
      if not precision then
        return 1
      end
      if precision < 4 then
        return precision, false
      else
        return precision - 3, true
      end
    end

    local progressPrecision = data.progressPrecision
    local totalPrecision = data.totalPrecision
    if data.regionType == "text" then
      local seenSymbols = {}
      Private.ParseTextStr(data.displayText, function(symbol)
        if not seenSymbols[symbol] then
          local triggerNum, sym = string.match(symbol, "(.+)%.(.+)")
          sym = sym or symbol
          if sym == "p" or sym == "t" then
            data["displayText_format_" .. symbol .. "_format"] = "timed"
            data["displayText_format_" .. symbol .. "_time_precision"], data["displayText_format_" .. symbol .. "_time_dynamic"] =
              convertLegacyPrecision(sym == "p" and progressPrecision or totalPrecision)
          end
        end
        seenSymbols[symbol] = symbol
      end)
    end

    if data.subRegions then
      for index, subRegionData in ipairs(data.subRegions) do
        if subRegionData.type == "subtext" then
          local seenSymbols = {}
          Private.ParseTextStr(subRegionData.text_text, function(symbol)
            if not seenSymbols[symbol] then
              local triggerNum, sym = string.match(symbol, "(.+)%.(.+)")
              sym = sym or symbol
              if sym == "p" or sym == "t" then
                subRegionData["text_text_format_" .. symbol .. "_format"] = "timed"
                subRegionData["text_text_format_" .. symbol .. "_time_precision"], subRegionData["text_text_format_" .. symbol .. "_time_dynamic"] =
                  convertLegacyPrecision(sym == "p" and progressPrecision or totalPrecision)
              end
            end
            seenSymbols[symbol] = symbol
          end)
        end
      end
    end

    if data.actions then
      for _, when in ipairs({ "start", "finish" }) do
        if data.actions[when] then
          local seenSymbols = {}
          Private.ParseTextStr(data.actions[when].message, function(symbol)
            if not seenSymbols[symbol] then
              local triggerNum, sym = string.match(symbol, "(.+)%.(.+)")
              sym = sym or symbol
              if sym == "p" or sym == "t" then
                data.actions[when]["message_format_" .. symbol .. "_format"] = "timed"
                data.actions[when]["message_format_" .. symbol .. "_time_precision"], data.actions[when]["message_format_" .. symbol .. "_time_dynamic"] =
                  convertLegacyPrecision(sym == "p" and progressPrecision or totalPrecision)
              end
            end
            seenSymbols[symbol] = symbol
          end)
        end
      end
    end

    if data.conditions then
      for conditionIndex, condition in ipairs(data.conditions) do
        for changeIndex, change in ipairs(condition.changes) do
          if change.property == "chat" and change.value then
            local seenSymbols = {}
            Private.ParseTextStr(change.value.message, function(symbol)
              if not seenSymbols[symbol] then
                local triggerNum, sym = string.match(symbol, "(.+)%.(.+)")
                sym = sym or symbol
                if sym == "p" or sym == "t" then
                  change.value["message_format_" .. symbol .. "_format"] = "timed"
                  change.value["message_format_" .. symbol .. "_time_precision"], change.value["message_format_" .. symbol .. "_time_dynamic"] =
                    convertLegacyPrecision(sym == "p" and progressPrecision or totalPrecision)
                end
              end
              seenSymbols[symbol] = symbol
            end)
          end
        end
      end
    end

    data.progressPrecision = nil
    data.totalPrecision = nil
  end

  -- Introduced in June 2020 in BfA
  if data.internalVersion < 31 then
    local allowedNames
    local ignoredNames
    if data.load.use_name == true and data.load.name then
      allowedNames = data.load.name
    elseif data.load.use_name == false and data.load.name then
      ignoredNames = data.load.name
    end

    if data.load.use_realm == true and data.load.realm then
      allowedNames = (allowedNames or "") .. "-" .. data.load.realm
    elseif data.load.use_realm == false and data.load.realm then
      ignoredNames = (ignoredNames or "") .. "-" .. data.load.realm
    end

    if allowedNames then
      data.load.use_namerealm = true
      data.load.namerealm = allowedNames
    end

    if ignoredNames then
      data.load.use_namerealmblack = true
      data.load.namerealmblack = ignoredNames
    end

    data.load.use_name = nil
    data.load.name = nil
    data.load.use_realm = nil
    data.load.realm = nil
  end

  -- Introduced in June 2020 in BfA
  if data.internalVersion < 32 then
    local replacements = {}
    local function repairCheck(replacements, check)
      if check and check.trigger then
        if replacements[check.trigger] then
          if replacements[check.trigger][check.variable] then
            check.variable = replacements[check.trigger][check.variable]
          end
        end
      end
    end

    if data.triggers then
      for triggerId, triggerData in ipairs(data.triggers) do
        if triggerData.trigger.type == "status" then
          local event = triggerData.trigger.event
          if event == "Unit Characteristics" or event == "Health" or event == "Power" then
            replacements[triggerId] = {}
            replacements[triggerId]["use_name"] = "use_namerealm"
            replacements[triggerId]["name"] = "namerealm"
          elseif event == "Cast" then
            replacements[triggerId] = {}
            replacements[triggerId]["use_sourceName"] = "use_sourceNameRealm"
            replacements[triggerId]["sourceName"] = "sourceNameRealm"
            replacements[triggerId]["use_destName"] = "use_destNameRealm"
            replacements[triggerId]["destName"] = "destNameRealm"
          end

          if replacements[triggerId] then
            for old, new in pairs(replacements[triggerId]) do
              triggerData.trigger[new] = triggerData.trigger[old]
              triggerData.trigger[old] = nil
            end

            local function recurseRepairChecks(replacements, checks)
              if not checks then
                return
              end
              for _, check in pairs(checks) do
                repairCheck(replacements, check)
                recurseRepairChecks(replacements, check.checks)
              end
            end
            for _, condition in pairs(data.conditions) do
              repairCheck(replacements, condition.check)
              recurseRepairChecks(replacements, condition.check.checks)
            end
          end
        end
      end
    end
  end

  -- Introduced in July 2020 in BfA
  if data.internalVersion < 33 then
    data.load.use_ignoreNameRealm = data.load.use_namerealmblack
    data.load.ignoreNameRealm = data.load.namerealmblack
    data.load.use_namerealmblack = nil
    data.load.namerealmblack = nil

    -- trigger.useBlackExactSpellId and trigger.blackauraspellids
    if data.triggers then
      for triggerId, triggerData in ipairs(data.triggers) do
        triggerData.trigger.useIgnoreName = triggerData.trigger.useBlackName
        triggerData.trigger.ignoreAuraNames = triggerData.trigger.blackauranames
        triggerData.trigger.useIgnoreExactSpellId = triggerData.trigger.useBlackExactSpellId
        triggerData.trigger.ignoreAuraSpellids = triggerData.trigger.blackauraspellids

        triggerData.trigger.useBlackName = nil
        triggerData.trigger.blackauranames = nil
        triggerData.trigger.useBlackExactSpellId = nil
        triggerData.trigger.blackauraspellids = nil
      end
    end
  end

  -- Introduced in July 2020 in Shadowlands
  if data.internalVersion < 34 then
    if data.regionType == "dynamicgroup" and (data.grow == "CIRCLE" or data.grow == "COUNTERCIRCLE") then
      if data.arcLength == 360 then
        data.fullCircle = true
      else
        data.fullCircle = false
      end
    end
  end

  if data.internalVersion < 36 then
    data.ignoreOptionsEventErrors = true
  end

  if data.internalVersion < 39 then
    if data.regionType == "icon" or data.regionType == "aurabar" then
      if data.auto then
        data.iconSource = -1
      else
        data.iconSource = 0
      end
    end
  end

  if data.internalVersion < 40 then
    data.information = data.information or {}
    if data.regionType == "group" then
      data.information.groupOffset = true
    end
    data.information.ignoreOptionsEventErrors = data.ignoreOptionsEventErrors
    data.ignoreOptionsEventErrors = nil
  end

  if data.internalVersion < 41 then
    local newTypes = {
      ["Cooldown Ready (Spell)"] = "spell",
      ["Queued Action"] = "spell",
      ["Charges Changed"] = "spell",
      ["Action Usable"] = "spell",
      ["Chat Message"] = "event",
      ["Unit Characteristics"] = "unit",
      ["Cooldown Progress (Spell)"] = "spell",
      ["Power"] = "unit",
      ["Combat Log"] = "combatlog",
      ["Health"] = "unit",
      ["Cooldown Progress (Item)"] = "item",
      ["Conditions"] = "unit",
      ["Spell Known"] = "spell",
      ["Cooldown Ready (Item)"] = "item",
      ["Faction Reputation"] = "unit",
      ["Pet Behavior"] = "unit",
      ["Range Check"] = "unit",
      ["Character Stats"] = "unit",
      ["Talent Known"] = "unit",
      ["Threat Situation"] = "unit",
      ["Equipment Set"] = "item",
      ["Death Knight Rune"] = "unit",
      ["Cast"] = "unit",
      ["Item Count"] = "item",
      ["BigWigs Timer"] = "addons",
      ["DBM Timer"] = "addons",
      ["Item Equipped"] = "item",
      ["DBM Announce"] = "addons",
      ["Swing Timer"] = "unit",
      ["Totem"] = "spell",
      ["Ready Check"] = "event",
      ["BigWigs Message"] = "addons",
      ["Class/Spec"] = "unit",
      ["Stance/Form/Aura"] = "unit",
      ["Weapon Enchant"] = "item",
      ["Global Cooldown"] = "spell",
      ["Experience"] = "unit",
      ["GTFO"] = "addons",
      ["Cooldown Ready (Equipment Slot)"] = "item",
      ["Crowd Controlled"] = "unit",
      ["Cooldown Progress (Equipment Slot)"] = "item",
      ["Combat Events"] = "event",
      ["Combo Points"] = "unit",
    }

    for triggerId, triggerData in ipairs(data.triggers) do
      if triggerData.trigger.type == "status" or triggerData.trigger.type == "event" then
        local newType = newTypes[triggerData.trigger.event]
        if newType then
          triggerData.trigger.type = newType
        else
          WeakAuras.prettyPrint("Unknown trigger type found in, please report: ", data.id, triggerData.trigger.event)
        end
      end
    end
  end

  if data.internalVersion < 44 then
    local function fixUp(data, prefix)
      local pattern = prefix .. "(.*)_format"

      local found = false
      for property in pairs(data) do
        local symbol = property:match(pattern)
        if symbol then
          found = true
          break
        end
      end

      if not found then
        return
      end

      local old = CopyTable(data)
      for property in pairs(old) do
        local symbol = property:match(pattern)
        if symbol then
          if data[property] == "timed" then
            data[prefix .. symbol .. "_time_format"] = 0

            local oldDynamic = data[prefix .. symbol .. "_time_dynamic"]
            data[prefix .. symbol .. "_time_dynamic_threshold"] = oldDynamic and 3 or 60
          end
          data[prefix .. symbol .. "_time_dynamic"] = nil
          if data[prefix .. symbol .. "_time_precision"] == 0 then
            data[prefix .. symbol .. "_time_precision"] = 1
            data[prefix .. symbol .. "_time_dynamic_threshold"] = 0
          end
        end
      end
    end

    if data.regionType == "text" then
      fixUp(data, "displayText_format_")
    end

    if data.subRegions then
      for index, subRegionData in ipairs(data.subRegions) do
        if subRegionData.type == "subtext" then
          fixUp(subRegionData, "text_text_format_")
        end
      end
    end

    if data.actions then
      for _, when in ipairs({ "start", "finish" }) do
        if data.actions[when] then
          fixUp(data.actions[when], "message_format_")
        end
      end
    end

    if data.conditions then
      for conditionIndex, condition in ipairs(data.conditions) do
        for changeIndex, change in ipairs(condition.changes) do
          if change.property == "chat" and change.value then
            fixUp(change.value, "message_format_")
          end
        end
      end
    end
  end

  if data.internalVersion < 49 then
    if not data.regionType:match("group") then
      data.subRegions = data.subRegions or {}
      -- rename aurabar_bar into subforeground, and subbarmodel into submodel
      for index, subRegionData in ipairs(data.subRegions) do
        if subRegionData.type == "aurabar_bar" then
          subRegionData.type = "subforeground"
        elseif subRegionData.type == "subbarmodel" then
          subRegionData.type = "submodel"
        end
        if subRegionData.bar_model_visible ~= nil then
          subRegionData.model_visible = subRegionData.bar_model_visible
          subRegionData.bar_model_visible = nil
        end
        if subRegionData.bar_model_alpha ~= nil then
          subRegionData.model_alpha = subRegionData.bar_model_alpha
          subRegionData.bar_model_alpha = nil
        end
      end
      -- rename conditions for bar_model_visible and bar_model_alpha
      if data.conditions then
        for conditionIndex, condition in ipairs(data.conditions) do
          if type(condition.changes) == "table" then
            for changeIndex, change in ipairs(condition.changes) do
              if change.property then
                local prefix, property = change.property:match("(sub%.%d+%.)(.*)")
                if prefix and property then
                  if property == "bar_model_visible" then
                    change.property = prefix .. "model_visible"
                  elseif property == "bar_model_alpha" then
                    change.property = prefix .. "model_alpha"
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  if data.internalVersion == 49 then
    -- Version 49 was a dud and contained a broken validation. Try to salvage the data, as
    -- best as we can.
    local broken = false
    local properties = {}
    Private.GetSubRegionProperties(data, properties)
    if data.conditions then
      for conditionIndex, condition in ipairs(data.conditions) do
        if type(condition.changes) == "table" then
          for changeIndex, change in ipairs(condition.changes) do
            if change.property then
              if not properties[change.property] then
                -- The property does not exist, so maybe it's one that was accidentally not moved
                local subRegionIndex, property = change.property:match("^sub%.(%d+)%.(.*)")
                if subRegionIndex and property then
                  broken = true
                  for _, offset in ipairs({ -1, 1 }) do
                    local newProperty = "sub." .. subRegionIndex + offset .. "." .. property
                    if properties[newProperty] then
                      change.property = newProperty
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if broken then
      WeakAuras.prettyPrint(L["Trying to repair broken conditions in %s likely caused by a WeakAuras bug."]:format(data.id))
    end
  end

  if data.internalVersion < 51 then
    for _, triggerData in ipairs(data.triggers) do
      if triggerData.trigger.event == "Threat Situation" then
        triggerData.trigger.unit = triggerData.trigger.threatUnit
        triggerData.trigger.use_unit = triggerData.trigger.use_threatUnit
        triggerData.trigger.threatUnit = nil
        triggerData.trigger.use_threatUnit = nil
      end
    end
  end

  if data.internalVersion < 52 then
    local function matchTarget(input)
      return input == "target" or input == "'target'" or input == '"target"' or input == "%t" or input == "'%t'" or input == '"%t"'
    end

    if data.conditions then
      for _, condition in ipairs(data.conditions) do
        for changeIndex, change in ipairs(condition.changes) do
          if change.property == "chat" and change.value then
            if matchTarget(change.value.message_dest) then
              change.value.message_dest = "target"
              change.value.message_dest_isunit = true
            end
          end
        end
      end
    end

    if data.actions.start.do_message and data.actions.start.message_type == "WHISPER" and matchTarget(data.actions.start.message_dest) then
      data.actions.start.message_dest = "target"
      data.actions.start.message_dest_isunit = true
    end

    if data.actions.finish.do_message and data.actions.finish.message_type == "WHISPER" and matchTarget(data.actions.finish.message_dest) then
      data.actions.finish.message_dest = "target"
      data.actions.finish.message_dest_isunit = true
    end
  end

  if data.internalVersion < 53 then
    local function ReplaceIn(text, table, prefix)
      local seenSymbols = {}
      Private.ParseTextStr(text, function(symbol)
        if not seenSymbols[symbol] then
          if table[prefix .. symbol .. "_format"] == "timed" and table[prefix .. symbol .. "_time_format"] == 0 then
            table[prefix .. symbol .. "_time_legacy_floor"] = true
          end
        end
        seenSymbols[symbol] = symbol
      end)
    end

    if data.regionType == "text" then
      ReplaceIn(data.displayText, data, "displayText_format_")
    end

    if data.subRegions then
      for index, subRegionData in ipairs(data.subRegions) do
        if subRegionData.type == "subtext" then
          ReplaceIn(subRegionData.text_text, subRegionData, "text_text_format_")
        end
      end
    end

    if data.actions then
      if data.actions.start then
        ReplaceIn(data.actions.start.message, data.actions.start, "message_format_")
      end
      if data.actions.finish then
        ReplaceIn(data.actions.finish.message, data.actions.finish, "message_format_")
      end
    end

    if data.conditions then
      for conditionIndex, condition in ipairs(data.conditions) do
        for changeIndex, change in ipairs(condition.changes) do
          if change.property == "chat" and change.value then
            ReplaceIn(change.value.message, change.value, "message_format_")
          end
        end
      end
    end
  end

  if data.internalVersion < 54 then
    for _, triggerData in ipairs(data.triggers) do
      if triggerData.trigger.type == "aura" then
        triggerData.trigger.type = "unit"
        triggerData.trigger.event = "Conditions"
        triggerData.trigger.use_alwaystrue = false
      end
    end
  end

  -- Internal version 55 contained a incorrect Modernize (data.forceEvents = nil) reused to
  -- migrate deathRune to isDeathRune & migrate use_inverse to use_genericShowOn
  if data.internalVersion < 55 then
    for _, triggerData in ipairs(data.triggers) do
        if triggerData.trigger.event == "Death Knight Rune" then
            -- migrate deathRune to isDeathRune
            if triggerData.trigger.use_deathRune then
                triggerData.trigger.use_isDeathRune = triggerData.trigger.use_deathRune
            end
            triggerData.trigger.use_deathRune = nil
            -- migrate use_inverse to use_genericShowOn
            if not (triggerData.trigger.use_genericShowOn or triggerData.trigger.genericShowOn) then
                triggerData.trigger.use_genericShowOn = true
                triggerData.trigger.genericShowOn = triggerData.trigger.use_inverse and "showOnCooldown"
                                                    or "showAlways"
            end
            triggerData.trigger.use_inverse = nil
        end
    end
  end

  if data.internalVersion < 55 then
    data.forceEvents = true
  end

  -- Internal version 55 contained a incorrect Modernize
  if data.internalVersion < 56 then
    data.information.forceEvents = data.forceEvents
    data.forceEvents = nil
  end

  -- version 62 became 64 to fix a broken modernize
  if data.internalVersion < 64 then
    if data.regionType == "dynamicgroup" then
      if data.sort == "custom" and type(data.sortOn) ~= "string" or data.sortOn == "" then
        data.sortOn = "changed"
      end
      if data.grow == "CUSTOM" and type(data.growOn) ~= "string" then
        data.growOn = "changed"
      end
    end
  end

  if data.internalVersion < 65 then
    for triggerId, triggerData in ipairs(data.triggers) do
      if triggerData.trigger.type == "item"
      and triggerData.trigger.event == "Item Count"
      and type(triggerData.trigger.itemName) == "number"
      then
        triggerData.trigger.use_exact_itemName = true
      end
    end
  end

  local function migrateToTable(tab, field)
    local value = tab[field]
    if value ~= nil and type(value) ~= "table" then
      tab[field] = { value }
    end
  end

  -- used to migrate Character Stats tables again, but not for cast trigger and used one down below for reverse migration between Version 49 to Version 65
  local isFromFork = data.internalVersion == 67

  if isFromFork or data.internalVersion < 67 or data.internalVersion > WeakAuras.InternalVersion() then
    local castMigrationNeeded = (not isFromFork) or data.internalVersion < 67

    do
      local trigger_migration = {
        ["Cast"] = {
          "stage",
          "stage_operator",
        },
        ["Experience"] = {
          "level",
          "level_operator",
          "currentXP",
          "currentXP_operator",
          "totalXP",
          "totalXP_operator",
          "percentXP",
          "percentXP_operator",
          "restedXP",
          "restedXP_operator",
          "percentrested",
          "percentrested_operator",
        },
        ["Health"] = {
          "health",
          "health_operator",
          "percenthealth",
          "percenthealth_operator",
          "deficit",
          "deficit_operator",
          "maxhealth",
          "maxhealth_operator",
        },
        ["Power"] = {
          "power",
          "power_operator",
          "percentpower",
          "percentpower_operator",
          "deficit",
          "deficit_operator",
          "maxpower",
          "maxpower_operator",
        },
        ["Character Stats"] = {
          "strength",
          "strength_operator",
          "agility",
          "agility_operator",
          "stamina",
          "stamina_operator",
          "intellect",
          "intellect_operator",
          "spirit",
          "spirit_operator",
          "attackpower",
          "attackpower_operator",
          "spellpower",
          "spellpower_operator",
          "rangedattackpower",
          "rangedattackpower_operator",
          "criticalrating",
          "criticalrating_operator",
          "criticalpercent",
          "criticalpercent_operator",
          "hitrating",
          "hitrating_operator",
          "hitpercent",
          "hitpercent_operator",
          "hasterating",
          "hasterating_operator",
          "hastepercent",
          "hastepercent_operator",
          "expertiserating",
          "expertiserating_operator",
          "expertisebonus",
          "expertisebonus_operator",
          "armorpenrating",
          "armorpenrating_operator",
          "armorpenpercent",
          "armorpenpercent_operator",
          "spellpenpercent",
          "spellpenpercent_operator",
          "resiliencerating",
          "resiliencerating_operator",
          "resiliencepercent",
          "resiliencepercent_operator",
          "expertisebonus",
          "expertisebonus_operator",
          "expertiserating",
          "expertiserating_operator",
          "resistancefire",
          "resistancefire_operator",
          "resistancenature",
          "resistancenature_operator",
          "resistancefrost",
          "resistancefrost_operator",
          "resistanceshadow",
          "resistanceshadow_operator",
          "resistancearcane",
          "resistancearcane_operator",
          "movespeedpercent",
          "movespeedpercent_operator",
          "dodgerating",
          "dodgerating_operator",
          "dodgepercent",
          "dodgepercent_operator",
          "parryrating",
          "parryrating_operator",
          "parrypercent",
          "parrypercent_operator",
          "blockpercent",
          "blockpercent_operator",
          "blockvalue",
          "blockvalue_operator",
          "armorrating",
          "armorrating_operator",
          "armorpercent",
          "armorpercent_operator",
        },
        ["Threat Situation"] = {
          "threatpct",
          "threatpct_operator",
          "rawthreatpct",
          "rawthreatpct_operator",
          "threatvalue",
          "threatvalue_operator",
        },
        ["Unit Characteristics"] = {
          "level",
          "level_operator",
        },
        ["Combat Log"] = {
          "spellId",
          "spellName",
        },
        ["Spell Cast Succeeded"] = {
          "spellId"
        },
        ["Location"] = {
          "zone",
          "subzone",
        },
      }
      for _, triggerData in ipairs(data.triggers) do
        local t = triggerData.trigger
        local fieldsToMigrate = trigger_migration[t.event]
        if fieldsToMigrate then
          for _, field in ipairs(fieldsToMigrate) do
            migrateToTable(t, field)
          end
        end
        -- cast trigger move data from 'spell' & 'spellId' to 'spellIds' & 'spellNames'
        if castMigrationNeeded then -- Newer imports do not require cast migration
          if t.event == "Cast" and t.type == "unit" then
            if t.spellId then
              if t.useExactSpellId then
                t.use_spellIds = t.use_spellId
                t.spellIds = t.spellIds or {}
                tinsert(t.spellIds, t.spellId)
              else
                t.use_spellNames = t.use_spellId
                t.spellNames = t.spellNames or {}
                tinsert(t.spellNames, t.spellId)
              end
            end
            if t.use_spell and t.spell then
              t.use_spellNames = true
              t.spellNames = t.spellNames or {}
              tinsert(t.spellNames, t.spell)
            end
            t.use_spellId = nil
            t.spellId = nil
            t.use_spell = nil
            t.spell = nil
          end
        end
      end
    end
    do
      local loadFields = {
        "level", "itemequiped"
      }

      for _, field in ipairs(loadFields) do
        migrateToTable(data.load, field)
        migrateToTable(data.load, field .. "_operator")
      end
    end
  end

  if isFromFork and data.internalVersion < 67.1 then -- WA 4.1.2 Fork reverse modernizer, applies modernizations between Version 49 to Version 65
    -- Version < 49
    if not data.regionType:match("group") then
      data.subRegions = data.subRegions or {}
      -- rename aurabar_bar into subforeground, and subbarmodel into submodel
      for index, subRegionData in ipairs(data.subRegions) do
        if subRegionData.type == "aurabar_bar" then
          subRegionData.type = "subforeground"
        elseif subRegionData.type == "subbarmodel" then
          subRegionData.type = "submodel"
        end
        if subRegionData.bar_model_visible ~= nil then
          subRegionData.model_visible = subRegionData.bar_model_visible
          subRegionData.bar_model_visible = nil
        end
        if subRegionData.bar_model_alpha ~= nil then
          subRegionData.model_alpha = subRegionData.bar_model_alpha
          subRegionData.bar_model_alpha = nil
        end
      end
      -- rename conditions for bar_model_visible and bar_model_alpha
      if data.conditions then
        for conditionIndex, condition in ipairs(data.conditions) do
          if type(condition.changes) == "table" then
            for changeIndex, change in ipairs(condition.changes) do
              if change.property then
                local prefix, property = change.property:match("(sub%.%d+%.)(.*)")
                if prefix and property then
                  if property == "bar_model_visible" then
                    change.property = prefix .. "model_visible"
                  elseif property == "bar_model_alpha" then
                    change.property = prefix .. "model_alpha"
                  end
                end
              end
            end
          end
        end
      end
    end

    -- Version == 49
    -- Version 49 was a dud and contained a broken validation. Try to salvage the data, as
    -- best as we can.
    local broken = false
    local properties = {}
    Private.GetSubRegionProperties(data, properties)
    if data.conditions then
      for conditionIndex, condition in ipairs(data.conditions) do
        if type(condition.changes) == "table" then
          for changeIndex, change in ipairs(condition.changes) do
            if change.property then
              if not properties[change.property] then
                -- The property does not exist, so maybe it's one that was accidentally not moved
                local subRegionIndex, property = change.property:match("^sub%.(%d+)%.(.*)")
                if subRegionIndex and property then
                  broken = true
                  for _, offset in ipairs({ -1, 1 }) do
                    local newProperty = "sub." .. subRegionIndex + offset .. "." .. property
                    if properties[newProperty] then
                      change.property = newProperty
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if broken then
      WeakAuras.prettyPrint(L["Trying to repair broken conditions in %s likely caused by a WeakAuras bug."]:format(data.id))
    end

    -- Version < 49
    for _, triggerData in ipairs(data.triggers) do
      if triggerData.trigger.event == "Threat Situation" then
        triggerData.trigger.unit = triggerData.trigger.threatUnit
        triggerData.trigger.use_unit = triggerData.trigger.use_threatUnit
        triggerData.trigger.threatUnit = nil
        triggerData.trigger.use_threatUnit = nil
      end
    end

    -- Version < 52
    local function matchTarget(input)
      return input == "target" or input == "'target'" or input == "\"target\"" or input == "%t" or input == "'%t'" or input == "\"%t\""
    end

    if data.conditions then
      for _, condition in ipairs(data.conditions) do
        for changeIndex, change in ipairs(condition.changes) do
          if change.property == "chat" and change.value then
            if matchTarget(change.value.message_dest) then
              change.value.message_dest = "target"
              change.value.message_dest_isunit = true
            end
          end
        end
      end
    end

    if data.actions.start.do_message and data.actions.start.message_type == "WHISPER" and matchTarget(data.actions.start.message_dest) then
      data.actions.start.message_dest = "target"
      data.actions.start.message_dest_isunit = true
    end

    if data.actions.finish.do_message and data.actions.finish.message_type == "WHISPER" and matchTarget(data.actions.finish.message_dest) then
      data.actions.finish.message_dest = "target"
      data.actions.finish.message_dest_isunit = true
    end

    -- Version < 53
    local function ReplaceIn(text, table, prefix)
      local seenSymbols = {}
      Private.ParseTextStr(text, function(symbol)
        if not seenSymbols[symbol] then
          if table[prefix .. symbol .. "_format"] == "timed"
              and table[prefix .. symbol .. "_time_format"] == 0
          then
            table[prefix .. symbol .. "_time_legacy_floor"] = true
          end
        end
        seenSymbols[symbol] = symbol
      end)
    end

    if data.regionType == "text" then
      ReplaceIn(data.displayText, data, "displayText_format_")
    end

    if data.subRegions then
      for index, subRegionData in ipairs(data.subRegions) do
        if subRegionData.type == "subtext" then
          ReplaceIn(subRegionData.text_text, subRegionData, "text_text_format_")
        end
      end
    end

    if data.actions then
      if data.actions.start then
        ReplaceIn(data.actions.start.message, data.actions.start, "message_format_")
      end
      if data.actions.finish then
        ReplaceIn(data.actions.finish.message, data.actions.finish, "message_format_")
      end
    end

    if data.conditions then
      for conditionIndex, condition in ipairs(data.conditions) do
        for changeIndex, change in ipairs(condition.changes) do
          if change.property == "chat" and change.value then
            ReplaceIn(change.value.message, change.value, "message_format_")
          end
        end
      end
    end

    -- Version < 54
    for _, triggerData in ipairs(data.triggers) do
      if triggerData.trigger.type == "aura" then
        triggerData.trigger.type = "unit"
        triggerData.trigger.event = "Conditions"
        triggerData.trigger.use_alwaystrue = false
      end
    end

    -- Internal version 55 contained a incorrect Modernize (data.forceEvents = nil) reused to
    -- migrate deathRune to isDeathRune & migrate use_inverse to use_genericShowOn
    -- Version < 55
    for _, triggerData in ipairs(data.triggers) do
        if triggerData.trigger.event == "Death Knight Rune" then
            -- migrate deathRune to isDeathRune
            if triggerData.trigger.use_deathRune then
                triggerData.trigger.use_isDeathRune = triggerData.trigger.use_deathRune
            end
            triggerData.trigger.use_deathRune = nil
            -- migrate use_inverse to use_genericShowOn
            if not (triggerData.trigger.use_genericShowOn or triggerData.trigger.genericShowOn) then
                triggerData.trigger.use_genericShowOn = true
                triggerData.trigger.genericShowOn = triggerData.trigger.use_inverse and "showOnCooldown"
                                                    or "showAlways"
            end
            triggerData.trigger.use_inverse = nil
        end
    end

    -- Internal version 55 contained a incorrect Modernize
    -- Version < 56
    data.information.forceEvents = data.forceEvents
    data.forceEvents = nil

    -- Version < 64
    if data.regionType == "dynamicgroup" then
      if data.sort == "custom" and type(data.sortOn) ~= "string" or data.sortOn == "" then
        data.sortOn = "changed"
      end
      if data.grow == "CUSTOM" and type(data.growOn) ~= "string" then
        data.growOn = "changed"
      end
    end

    -- Version < 65
    for triggerId, triggerData in ipairs(data.triggers) do
      if triggerData.trigger.type == "item"
      and triggerData.trigger.event == "Item Count"
      and type(triggerData.trigger.itemName) == "number"
      then
        triggerData.trigger.use_exact_itemName = true
      end
    end
  end

  if data.internalVersion < 68 then
    if data.parent then
      local parentData = WeakAuras.GetData(data.parent)
      if parentData and parentData.regionType == "dynamicgroup" then
        if data.anchorFrameParent == nil then
          data.anchorFrameParent = false
        end
      end
    end
  end

  if data.internalVersion < 69 then
    migrateToTable(data.load, "itemequiped")
  end

  if data.internalVersion < 70 then
    local trigger_migration = {
      Power = {
        "power",
        "power_operator"
      }
    }
    for _, triggerData in ipairs(data.triggers) do
      local t = triggerData.trigger
      local fieldsToMigrate = trigger_migration[t.event]
      if fieldsToMigrate then
        for _, field in ipairs(fieldsToMigrate) do
          migrateToTable(t, field)
        end
      end
    end
  end

  if data.internalVersion < 71 then
    if data.regionType == 'icon' or data.regionType == 'aurabar'
       or data.regionType == 'progresstexture'
       or data.regionType == 'stopmotion'
    then
      data.progressSource = {-1, ""}
    else
      data.progressSource = nil
    end
    if data.subRegions then
      for index, subRegionData in ipairs(data.subRegions) do
        if subRegionData.type == "subtick" then
          local tick_placement = subRegionData.tick_placement
          subRegionData.tick_placements = {}
          subRegionData.tick_placements[1] = tick_placement
          subRegionData.progressSources = {{-2, ""}}
          subRegionData.tick_placement = nil
        end
      end
    end

  end

  if data.internalVersion < 73 then
    if data.conditions then
      for conditionIndex, condition in ipairs(data.conditions) do
        for changeIndex, change in ipairs(condition.changes) do
          if type(change.property) == "string" then
            change.property = string.gsub(change.property, "(sub.%d.tick_placement)(%d)", "%1s.%2")
          end
        end
      end
    end
  end

  if data.internalVersion < 75 then
    -- this commit from nov 2019 https://github.com/WeakAuras/WeakAuras2/commit/6d8f11c17422aeffdb82a0aa05181edfdd137896
    -- changed adjustedMin & adjustedMax type from number to string (range => input)
    -- but didn't include a migration
    if type(data.adjustedMin) == "number" then
      data.adjustedMin = tostring(data.adjustedMin)
    end
    if type(data.adjustedMax) == "number" then
      data.adjustedMax = tostring(data.adjustedMax)
    end
    -- this commit https://github.com/WeakAuras/WeakAuras2/commit/dbcb70b1e4df262af82f63620b3b0d80741e6df2
    -- set a default for adjustedMin & adjustedMax with an empty string
    -- in Private.validate if type of value is different from type of default, value is set to default
    -- which had effect to lose data if aura was made before nov 2019 ~ 2020
    -- try detect data loss and restore from Archivist
    if data.internalVersion == 74 and oldSnapshot then
      local restoreMin = data.useAdjustededMin and data.adjustedMin == ""
      local restoreMax = data.useAdjustededMax and data.adjustedMax == ""
      if restoreMin or restoreMax then
        if restoreMin and type(oldSnapshot.adjustedMin) == "number" then
          data.adjustedMin = tostring(oldSnapshot.adjustedMin)
        end
        if restoreMax and type(oldSnapshot.adjustedMax) == "number" then
          data.adjustedMax = tostring(oldSnapshot.adjustedMax)
        end
      end
    end
  end

  if data.internalVersion < 76 then
    local function removeHoles(t)
      local keys = {}
      for key in pairs(t) do
        table.insert(keys, key)
      end
      if #keys ~= #t then
        table.sort(keys)
        local newTable = {}
        for i, key in ipairs(keys) do
          newTable[i] = t[key]
        end
        return newTable
      else
        return t
      end
    end
    local trigger_migration = {
      ["Spell Cast Succeeded"] = {
        "spellId",
      },
      ["Unit Characteristics"] = {
        "level",
      },
      ["Power"] = {
        "power",
        "percentpower",
        "deficit",
        "maxpower",
      },
      ["Combat Log"] = {
        "spellId",
        "spellName",
      },
      ["Health"] = {
        "health",
        "percenthealth",
        "deficit",
        "maxhealth",
      },
      ["Faction Reputation"] = {
        "value",
        "total",
        "percentRep",
      },
      ["Location"] = {
        "zone",
        "subzone",
      },
      ["Threat Situation"] = {
        "threatpct",
        "rawthreatpct",
        "threatvalue",
      },
      ["Character Stats"] = {
        "strength",
        "agility",
        "stamina",
        "intellect",
        "spirit",
        "attackpower",
        "spellpower",
        "rangedattackpower",
        "criticalrating",
        "criticalpercent",
        "hitrating",
        "hitpercent",
        "hasterating",
        "hastepercent",
        "expertiserating",
        "expertisebonus",
        "armorpenrating",
        "armorpenpercent",
        "spellpenpercent",
        "resiliencerating",
        "resiliencepercent",
        "expertisebonus",
        "expertiserating",
        "resistancefire",
        "resistancenature",
        "resistancefrost",
        "resistanceshadow",
        "resistancearcane",
        "movespeedpercent",
        "dodgerating",
        "dodgepercent",
        "parryrating",
        "parrypercent",
        "blockpercent",
        "blockvalue",
        "armorrating",
        "armorpercent",
      },
      ["Cast"] = {
        "spellNames",
        "spellIds",
      },
    }
    for _, triggerData in ipairs(data.triggers) do
      local trigger = triggerData.trigger
      local fieldsToMigrate = trigger_migration[trigger.event]
      if fieldsToMigrate then
        for _, field in ipairs(fieldsToMigrate) do
          if type(trigger[field]) == "table" then
            trigger[field] = removeHoles(trigger[field])
          end
        end
      end
    end
  end

  if data.internalVersion < 77 then
    -- fix data broken by wago export
    local triggerFix = {
      talent = {
        multi = true
      },
      herotalent = {
        multi = true
      },
      form = {
        multi = true
      },
      specId = {
        multi = true
      },
      actualSpec = true,
      arena_spec = true
    }
    local loadFix = {
      talent = {
        multi = true
      },
      talent2 = {
        multi = true
      },
      talent3 = {
        multi = true
      },
      herotalent = {
        multi = true
      },
      class_and_spec = {
        multi = true
      }
    }

    local function fixData(data, fields)
      for k, v in pairs(fields) do
        if v == true and type(data[k]) == "table" then
          -- fix field k
          local tofix = {}
          for key in pairs(data[k]) do
              if type(key) == "string" then
                table.insert(tofix, key)
              end
          end
          for _, oldkey in ipairs(tofix) do
              local newkey = tonumber(oldkey)
              if newkey then
                data[k][newkey] = data[k][oldkey]
              end
              data[k][oldkey] = nil
          end
        elseif type(v) == "table" and type(data[k]) == "table" then
          -- recurse
          fixData(data[k], fields[k])
        end
      end
    end

    for _, triggerData in ipairs(data.triggers) do
      fixData(triggerData.trigger, triggerFix)
    end
    fixData(data.load, loadFix)
  end

  if data.internalVersion < 79 then
    if data.triggers then
      for _, triggerData in ipairs(data.triggers) do
        local trigger = triggerData.trigger
        if trigger and trigger.type == "unit" and trigger.event == "Unit Characteristics" then
          if trigger.use_ignoreDead then
            if trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party" then
              trigger.use_dead = false
            else
              -- since this option was previously only available for group units,
              -- nil it out if the unit isn't group to avoid surprises from vestigial data
              trigger.use_dead = nil
            end
          end
          trigger.use_ignoreDead = nil
        end
      end
    end
  end


  if data.internalVersion < 80 then
    -- Use common names for anchor areas/points so
    -- that up/down of sub regions can adapt that

    local conversions = {
      subborder = {
        border_anchor = "anchor_area",
      },
      subglow = {
        glow_anchor = "anchor_area"
      },
      subtext = {
        text_anchorPoint = "anchor_point"
      }
    }

    if data.subRegions then
      for index, subRegionData in ipairs(data.subRegions) do
        if conversions[subRegionData.type] then
          for oldKey, newKey in pairs(conversions[subRegionData.type]) do
            subRegionData[newKey] = subRegionData[oldKey]
            subRegionData[oldKey] = nil
          end
        end
      end
    end
  end

  if data.internalVersion < 81 then
    -- Rename 'progressSources' to 'progressSource' for Linear/CircularProgressTexture/StopMotion sub elements
    local conversions = {
      sublineartexture = {
        progressSources = "progressSource",
      },
      subcirculartexture = {
        progressSources = "progressSource",
      },
      substopmotion = {
        progressSources = "progressSource",
      }
    }
    if data.subRegions then
      for index, subRegionData in ipairs(data.subRegions) do
        if conversions[subRegionData.type] then
          for oldKey, newKey in pairs(conversions[subRegionData.type]) do
            subRegionData[newKey] = subRegionData[oldKey]
            subRegionData[oldKey] = nil
          end
        end
      end
    end
  end

  if data.internalVersion < 82 then
    -- noMerge for separator custom option doesn't make sense,
    -- and groups achieve the desired effect better,
    -- so drop the feature
    if data.authorOptions then
      for _, optionData in ipairs(data.authorOptions) do
        if optionData.type == "header" then
          optionData.noMerge = nil
        end
      end
    end
  end

  if data.internalVersion < 83.25 then
    -- Due to a Localisation issue and a bad implementation clear out all class/spec triggers that contain strings
    local function replaceSpecData(data, field, bt2)
      if data[field] then
        if bt2 then
          for specKey in pairs(data[field]) do
            if type(specKey) == "string" then
              data[field] = nil
              data[bt2] = nil
            end
          end
          return
        end
        if data[field].multi then
          for specKey in pairs(data[field].multi) do
            if type(specKey) == "string" then
              data[field] = { multi = {} }
              data["use_" .. field] = nil
              return
            end
          end
        end
        if type(data[field].single) == "string" then
          data[field] = { multi = {} }
          data["use_" .. field] = nil
        end
      end
    end

    if data.load then
      replaceSpecData(data.load, "class_and_spec")
    end
    if data.triggers then
      for _, triggerData in ipairs(data.triggers) do
        local trigger = triggerData.trigger
        if trigger and (trigger.event == "Unit Characteristics" or trigger.event == "Power" or
                        trigger.event == "Health" or trigger.event == "Class/Spec") then
          replaceSpecData(trigger, "specId")
        elseif trigger and trigger.type == "aura2" then
          replaceSpecData(trigger, "actualSpec", "useActualSpec")
        end
      end
    end
  end

  if data.internalVersion < 84 then
    if data.triggers then
      for _, triggerData in ipairs(data.triggers) do
        local trigger = triggerData.trigger
        if trigger and trigger.type == "addons" then
          if trigger.event == "Boss Mod Timer" or trigger.event == "BigWigs Timer" or trigger.event == "DBM Timer" then
            -- if trigger don't filter bars, show only those active in the addon config for triggers made before this option was added
            -- show disabled bars when looking for specific ids/name
            if not (trigger.use_message or trigger.use_spellId) then
              trigger.use_isBarEnabled = true
            end
          end
        end
      end
    end
  end

  if data.internalVersion < 85 then
    -- Migrate raidMarkIndex and old Combo Points triggers and Happiness
    if data.triggers then
      local eventTypes = {
        ["Unit Characteristics"] = true,
        ["Health"] = true,
        ["Power"] = true,
        ["Alternate Power"] = true,
        ["Cast"] = true
      }
      for triggerNum, triggerData in ipairs(data.triggers) do
        local trigger = triggerData.trigger
        if trigger and trigger.type == "unit" then
          -- Migrate raidMarkIndex
          if eventTypes[trigger.event] then
            local rt = trigger.raidMarkIndex
            if type(rt) == "number" then
              trigger.raidMarkIndex = {
                single = rt
              }
            end
            if trigger.use_raidMarkIndex == false then
              trigger.use_raidMarkIndex = nil
            end
          end
          -- Modernize Happiness
          if trigger.event == "Power" and trigger.powertype == 4 then
            trigger.powertype = 27
          end
          -- Migrate old Combo Points triggers
          if trigger.event == "Combo Points" then
            -- Conditions
            if data.conditions then
              for conditionIndex, condition in ipairs(data.conditions) do
                if condition.check then
                  if condition.check.trigger == triggerNum then
                    if condition.check.variable == "stacks" then
                      condition.check.variable = "power"
                    end
                  end
                end
              end
            end
            -- Trigger
            local newTrigger = {
              type = "unit",
              use_unit = true,
              unit = "player",
              use_powertype = true,
              powertype = 4,
              event = "Power"
            }
            if trigger.combopoints and trigger.combopoints_operator then
              newTrigger.use_power = true
              newTrigger.power = { trigger.combopoints }
              newTrigger.power_operator = { trigger.combopoints_operator }
            end
            triggerData.trigger = newTrigger
          end
        end
      end
    end
    -- Migrates the "power" and "power_operator" fields for the Power trigger again,
    -- from internalVersion < 70. Previously missed the migration.
    local trigger_migration = {
      Power = {
        "power",
        "power_operator"
      }
    }
    for _, triggerData in ipairs(data.triggers) do
      local t = triggerData.trigger
      local fieldsToMigrate = trigger_migration[t.event]
      if fieldsToMigrate then
        for _, field in ipairs(fieldsToMigrate) do
          migrateToTable(t, field)
        end
      end
    end
  end

  data.internalVersion = max(data.internalVersion or 0, WeakAuras.InternalVersion())
end

--- Returns true if Modernize will use data from last snapshot before a new one is done
function Private.ModernizeNeedsOldSnapshot(data)
  if data.internalVersion == 74 then
    local restoreMin = data.useAdjustededMin and data.adjustedMin == ""
    local restoreMax = data.useAdjustededMax and data.adjustedMax == ""
    if restoreMin or restoreMax then
      return true
    end
  end
end
