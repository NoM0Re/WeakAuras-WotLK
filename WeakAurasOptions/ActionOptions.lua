if not WeakAuras.IsLibsOK() then return end
local AddonName = ...
local OptionsPrivate = select(2, ...)

local L = WeakAuras.L

local removeFuncs = OptionsPrivate.commonOptions.removeFuncs
local replaceNameDescFuncs = OptionsPrivate.commonOptions.replaceNameDescFuncs
local replaceImageFuncs = OptionsPrivate.commonOptions.replaceImageFuncs
local replaceValuesFuncs = OptionsPrivate.commonOptions.replaceValuesFuncs
local disabledAll = OptionsPrivate.commonOptions.CreateDisabledAll("action")
local hiddenAll = OptionsPrivate.commonOptions.CreateHiddenAll("action")
local getAll = OptionsPrivate.commonOptions.CreateGetAll("action")
local setAll = OptionsPrivate.commonOptions.CreateSetAll("action", getAll)
local dynamicTextInputs = {}

local RestrictedChannelCheck = function(data)
  return data.message_type == "SAY" or data.message_type == "YELL" or data.message_type == "SMARTRAID"
end

---  a sound from each setter
local lastPlayedSoundFromSet

function OptionsPrivate.GetActionOptions(data)
  local action = {
    type = "group",
    name = L["Actions"],
    order = 50,
    get = function(info)
      local split = info[#info]:find("_");
      if(split) then
        local field, value = info[#info]:sub(1, split-1), info[#info]:sub(split+1);
        if(data.actions and data.actions[field]) then
          if (info.type == "color") then
            if type(data.actions[field][value]) == "table" then
              local c = data.actions[field][value]
              return c[1], c[2], c[3], c[4];
            else
              return 1, 1, 1, 1
            end
          else
            return data.actions[field][value];
          end
        else
          return nil;
        end
      end
    end,
    set = function(info, v, g, b, a)
      local split = info[#info]:find("_");
      local field, value = info[#info]:sub(1, split-1), info[#info]:sub(split+1);
      data.actions = data.actions or {};
      data.actions[field] = data.actions[field] or {};
      if (info.type == "color") then
        if not data.actions[field][value] or type(data.actions[field][value]) ~= "table" then
          data.actions[field][value] = {}
        end
        local c = data.actions[field][value]
        c[1], c[2], c[3], c[4] = v, g, b, a;
      else
        data.actions[field][value] = v;
      end
      if(value == "sound" or value == "sound_path") then
        if lastPlayedSoundFromSet ~= GetTime() then
          pcall(PlaySoundFile, v, "Master")
          lastPlayedSoundFromSet = GetTime()
        end
      elseif(value == "sound_kit_id") then
        if lastPlayedSoundFromSet ~= GetTime() then
          pcall(PlaySound, v, "Master")
          lastPlayedSoundFromSet = GetTime()
        end
      end
      WeakAuras.Add(data);
      if(value == "message") then
        WeakAuras.ClearAndUpdateOptions(data.id)
      end
    end,
    args = {
      init_header = {
        type = "header",
        name = L["Custom Functions"],
        order = 0.1
      },
      init_do_custom = {
        type = "toggle",
        name = L["Custom Init"],
        order = 0.2,
        width = WeakAuras.doubleWidth
      },
      init_do_custom_load = {
        type = "toggle",
        name = L["Custom Load"],
        order = 0.3,
        width = WeakAuras.doubleWidth
      },
      init_do_custom_unload = {
        type = "toggle",
        name = L["Custom Unload"],
        order = 0.4,
        width = WeakAuras.doubleWidth
      },
      -- texteditor added here by AddCodeOption
      start_header = {
        type = "header",
        name = L["On Show"],
        order = 0.5
      },
      start_do_message = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Chat Message"],
        order = 1
      },
      start_message_type = {
        type = "select",
        width = WeakAuras.normalWidth,
        name = L["Message Type"],
        order = 2,
        values = OptionsPrivate.Private.send_chat_message_types,
        sorting = OptionsPrivate.Private.SortOrderForValues(OptionsPrivate.Private.send_chat_message_types),
        disabled = function() return not data.actions.start.do_message end,
      },
      start_message_warning = {
        type = "description",
        width = WeakAuras.doubleWidth,
        name = L["Note: Automated Messages to SAY and YELL are blocked outside of Instances."],
        order = 2.5,
        hidden = function() return not RestrictedChannelCheck(data.actions.start) end
      },
      start_message_space = {
        type = "execute",
        width = WeakAuras.normalWidth,
        name = "",
        order = 3,
        image = function() return "", 0, 0 end,
        hidden = function()
          return not(data.actions.start.message_type == "COMBAT"
                     or data.actions.start.message_type == "PRINT" or data.actions.start.message_type == "ERROR")
        end
      },
      start_message_color = {
        type = "color",
        width = WeakAuras.normalWidth,
        name = L["Color"],
        order = 3,
        hasAlpha = false,
        hidden = function()
          return not(data.actions.start.message_type == "COMBAT"
                     or data.actions.start.message_type == "PRINT"
                     or data.actions.start.message_type == "ERROR")
        end,
        get = function() return data.actions.start.r or 1, data.actions.start.g or 1, data.actions.start.b or 1 end,
        set = function(info, r, g, b)
          data.actions.start.r = r;
          data.actions.start.g = g;
          data.actions.start.b = b;
          WeakAuras.Add(data);
        end
      },
      start_message_dest = {
        type = "input",
        width = WeakAuras.normalWidth - 0.15,
        name = L["Send To"],
        order = 3.1,
        disabled = function() return not data.actions.start.do_message end,
        hidden = function() return data.actions.start.message_type ~= "WHISPER" end,
        control = "WeakAurasInput",
        callbacks = {
          OnEditFocusGained = function(self)
            local widget = dynamicTextInputs["start_message_dest"]
            OptionsPrivate.ToggleTextReplacements(data, widget, "OnEditFocusGained")
          end,
          OnEditFocusLost = function(self)
            OptionsPrivate.ToggleTextReplacements(nil, nil, "OnEditFocusLost")
          end,
          OnEnterPressed = function(self)
            OptionsPrivate.ToggleTextReplacements(nil, nil, "OnEnterPressed")
          end,
          OnShow = function(self)
            dynamicTextInputs["start_message_dest"] = self
          end,
        }
      },
      start_message_dest_text_replacements_button = {
        type = "execute",
        width = 0.15,
        name = L["Dynamic Text Replacements"],
        desc = L["There are several special codes available to make this text dynamic. Click to view a list with all dynamic text codes."],
        order = 3.11,
        disabled = function() return not data.actions.start.do_message end,
        hidden = function() return data.actions.start.message_type ~= "WHISPER" end,
        func = function()
          local widget = dynamicTextInputs["start_message_dest"]
          OptionsPrivate.ToggleTextReplacements(data, widget, "ToggleButton")
        end,
        imageWidth = 24,
        imageHeight = 24,
        control = "WeakAurasIcon",
        image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\sidebar",
      },
      start_message_dest_isunit = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Is Unit"],
        order = 3.15,
        hidden = function()
          return data.actions.start.message_type ~= "WHISPER"
        end
      },
      start_message = {
        type = "input",
        width = WeakAuras.doubleWidth - 0.15,
        name = L["Message"],
        order = 4,
        disabled = function() return not data.actions.start.do_message end,
        control = "WeakAurasInput",
        callbacks = {
          OnEditFocusGained = function(self)
            local widget = dynamicTextInputs["start_message"]
            OptionsPrivate.ToggleTextReplacements(data, widget, "OnEditFocusGained")
          end,
          OnEditFocusLost = function(self)
            OptionsPrivate.ToggleTextReplacements(nil, nil, "OnEditFocusLost")
          end,
          OnEnterPressed = function(self)
            OptionsPrivate.ToggleTextReplacements(nil, nil, "OnEnterPressed")
          end,
          OnShow = function(self)
            dynamicTextInputs["start_message"] = self
          end,
        }
      },
      start_message_text_replacements_button = {
        type = "execute",
        width = 0.15,
        name = L["Dynamic Text Replacements"],
        desc = L["There are several special codes available to make this text dynamic. Click to view a list with all dynamic text codes."],
        order = 4.1,
        disabled = function() return not data.actions.start.do_message end,
        func = function()
          local widget = dynamicTextInputs["start_message"]
          OptionsPrivate.ToggleTextReplacements(data, widget, "ToggleButton")
        end,
        imageWidth = 24,
        imageHeight = 24,
        control = "WeakAurasIcon",
        image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\sidebar",
      },
      -- texteditor added later
      start_do_sound = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Play Sound"],
        order = 8
      },
      start_do_loop = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Loop"],
        order = 8.1,
        disabled = function() return not data.actions.start.do_sound end,
      },
      start_sound_repeat = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Repeat After"],
        order = 8.2,
        hidden = function() return not data.actions.start.do_loop end,
        disabled = function() return not data.actions.start.do_sound end,
        min = 0,
        softMax = 100,
      },
      start_sound_repeat_space = {
        type = "description",
        width = WeakAuras.normalWidth,
        order = 8.3,
        name = "",
        hidden = function() return not data.actions.start.do_loop end,
      },
      start_sound = {
        type = "select",
        width = WeakAuras.normalWidth,
        name = L["Sound"],
        order = 8.4,
        itemControl = "WeakAurasMediaSound",
        values = OptionsPrivate.Private.sound_types,
        sorting = OptionsPrivate.Private.SortOrderForValues(OptionsPrivate.Private.sound_types),
        disabled = function() return not data.actions.start.do_sound end,
      },
      start_sound_channel = {
        type = "select",
        width = WeakAuras.normalWidth,
        name = L["Sound Channel"],
        order = 8.5,
        values = OptionsPrivate.Private.sound_channel_types,
        disabled = function() return not data.actions.start.do_sound end,
        get = function() return data.actions.start.sound_channel or "Master" end
      },
      start_sound_path = {
        type = "input",
        width = WeakAuras.doubleWidth,
        name = L["Sound File Path"],
        order = 9,
        hidden = function() return data.actions.start.sound ~= " custom" end,
        disabled = function() return not data.actions.start.do_sound end
      },
      start_sound_kit_id = {
        type = "input",
        width = WeakAuras.doubleWidth,
        name = L["Sound Kit ID"],
        order = 9,
        hidden = function() return data.actions.start.sound ~= " KitID" end,
        disabled = function() return not data.actions.start.do_sound end
      },
      start_do_glow = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Glow External Element"],
        order = 10.1
      },
      start_glow_action = {
        type = "select",
        width = WeakAuras.normalWidth,
        name = L["Glow Action"],
        order = 10.2,
        values = OptionsPrivate.Private.glow_action_types,
        disabled = function() return not data.actions.start.do_glow end
      },
      start_glow_frame_type = {
        type = "select",
        width = WeakAuras.normalWidth,
        desc = function()
          return (
            data.actions.start.glow_frame_type == "UNITFRAME"
            or data.actions.start.glow_frame_type == "NAMEPLATE"
          )
          and L["Require unit from trigger"] or nil
        end,
        name = L["Glow Frame Type"],
        order = 10.3,
        values = OptionsPrivate.Private.glow_frame_types,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action == nil
        end
      },
      start_glow_type_spacer = {
        type = "description",
        width = WeakAuras.normalWidth,
        name = "",
        order = 10.35,
        hidden = function()
          return not data.actions.start.do_glow
          or not (data.actions.start.glow_action == "hide" and data.actions.start.glow_frame_type == "FRAMESELECTOR")
        end,
      },
      start_glow_type = {
        type = "select",
        width = WeakAuras.normalWidth,
        name = L["Glow Type"],
        order = 10.4,
        values = OptionsPrivate.Private.glow_types,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action ~= "show"
          or data.actions.start.glow_frame_type == nil
        end,
      },
      start_glow_frame = {
        type = "input",
        width = WeakAuras.normalWidth,
        name = L["Frame"],
        order = 10.5,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_frame_type ~= "FRAMESELECTOR"
        end
      },
      start_choose_glow_frame = {
        type = "execute",
        width = WeakAuras.normalWidth,
        name = L["Choose"],
        order = 10.55,
        hidden = function() return not data.actions.start.do_glow or data.actions.start.glow_frame_type ~= "FRAMESELECTOR" end,
        func = function()
          if(data.controlledChildren and data.controlledChildren[1]) then
            WeakAuras.PickDisplay(data.controlledChildren[1]);
            OptionsPrivate.StartFrameChooser(WeakAuras.GetData(data.controlledChildren[1]), {"actions", "start", "glow_frame"});
          else
            OptionsPrivate.StartFrameChooser(data, {"actions", "start", "glow_frame"});
          end
        end
      },
      start_use_glow_color = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Glow Color"],
        order = 10.7,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action ~= "show"
          or data.actions.start.glow_frame_type == nil
          or data.actions.start.glow_type == nil
        end,
      },
      start_glow_color = {
        type = "color",
        hasAlpha = true,
        width = WeakAuras.normalWidth,
        name = L["Glow Color"],
        order = 10.8,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action ~= "show"
          or data.actions.start.glow_frame_type == nil
          or data.actions.start.glow_type == nil
        end,
        disabled = function() return not data.actions.start.use_glow_color end,
      },
      start_glow_startAnim = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Start Animation"],
        order = 10.801,
        get = function()
          return data.actions.start.glow_startAnim and true or false
        end,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action ~= "show"
          or data.actions.start.glow_frame_type == nil
          or data.actions.start.glow_type ~= "Proc"
        end,
      },
      start_glow_duration = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Duration"],
        order = 10.802,
        softMin = 0.01,
        softMax = 3,
        step = 0.05,
        get = function()
          return data.actions.start.glow_duration or 1
        end,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action ~= "show"
          or data.actions.start.glow_frame_type == nil
          or data.actions.start.glow_type ~= "Proc"
        end,
      },
      start_glow_lines = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Lines & Particles"],
        order = 10.81,
        min = 1,
        softMax = 30,
        step = 1,
        get = function()
          return data.actions.start.glow_lines or 8
        end,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action ~= "show"
          or not data.actions.start.glow_type
          or data.actions.start.glow_type == "buttonOverlay"
          or data.actions.start.glow_type == "Proc"
          or data.actions.start.glow_frame_type == nil
        end,
      },
      start_glow_frequency = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Frequency"],
        order = 10.82,
        softMin = -2,
        softMax = 2,
        step = 0.05,
        get = function()
          return data.actions.start.glow_frequency or 0.25
        end,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action ~= "show"
          or not data.actions.start.glow_type
          or data.actions.start.glow_type == "buttonOverlay"
          or data.actions.start.glow_type == "Proc"
          or data.actions.start.glow_frame_type == nil
        end,
      },
      start_glow_length = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Length"],
        order = 10.83,
        min = 0.05,
        softMax = 20,
        step = 0.05,
        get = function()
          return data.actions.start.glow_length or 10
        end,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action ~= "show"
          or data.actions.start.glow_type ~= "Pixel"
          or data.actions.start.glow_frame_type == nil
        end,
      },
      start_glow_thickness = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Thickness"],
        order = 10.84,
        min = 0.05,
        softMax = 20,
        step = 0.05,
        get = function()
          return data.actions.start.glow_thickness or 1
        end,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action ~= "show"
          or data.actions.start.glow_type ~= "Pixel"
          or data.actions.start.glow_frame_type == nil
        end,
      },
      start_glow_XOffset = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["X-Offset"],
        order = 10.85,
        softMin = -100,
        softMax = 100,
        step = 0.5,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action ~= "show"
          or not data.actions.start.glow_type
          or data.actions.start.glow_type == "buttonOverlay"
          or data.actions.start.glow_frame_type == nil
        end,
      },
      start_glow_YOffset = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Y-Offset"],
        order = 10.86,
        softMin = -100,
        softMax = 100,
        step = 0.5,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action ~= "show"
          or not data.actions.start.glow_type
          or data.actions.start.glow_type == "buttonOverlay"
          or data.actions.start.glow_frame_type == nil
        end,
      },
      start_glow_scale = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Scale"],
        order = 10.87,
        min = 0.05,
        softMax = 10,
        step = 0.05,
        isPercent = true,
        get = function()
          return data.actions.start.glow_scale or 1
        end,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action ~= "show"
          or data.actions.start.glow_type ~= "ACShine"
          or data.actions.start.glow_frame_type == nil
        end,
      },
      start_glow_border = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Border"],
        order = 10.88,
        hidden = function()
          return not data.actions.start.do_glow
          or data.actions.start.glow_action ~= "show"
          or data.actions.start.glow_type ~= "Pixel"
          or data.actions.start.glow_frame_type == nil
        end,
      },
      start_do_custom = {
        type = "toggle",
        width = WeakAuras.doubleWidth,
        name = L["Custom"],
        order = 11,
      },
      -- texteditor added laters
      finish_header = {
        type = "header",
        name = L["On Hide"],
        order = 20.5
      },
      finish_do_message = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Chat Message"],
        order = 21
      },
      finish_message_type = {
        type = "select",
        width = WeakAuras.normalWidth,
        name = L["Message Type"],
        order = 22,
        values = OptionsPrivate.Private.send_chat_message_types,
        sorting = OptionsPrivate.Private.SortOrderForValues(OptionsPrivate.Private.send_chat_message_types),
        disabled = function() return not data.actions.finish.do_message end,
      },
      finish_message_warning = {
        type = "description",
        width = WeakAuras.doubleWidth,
        name = L["Note: Automated Messages to SAY and YELL are blocked outside of Instances."],
        order = 22.5,
        hidden = function() return not RestrictedChannelCheck(data.actions.finish) end
      },
      finish_message_space = {
        type = "execute",
        width = WeakAuras.normalWidth,
        name = "",
        order = 23,
        image = function() return "", 0, 0 end,
        hidden = function()
          return not(data.actions.finish.message_type == "COMBAT"
                     or data.actions.finish.message_type == "PRINT" or data.actions.finish.message_type == "ERROR")
        end
      },
      finish_message_color = {
        type = "color",
        width = WeakAuras.normalWidth - 0.15,
        name = L["Color"],
        order = 23,
        hasAlpha = false,
        hidden = function() return
          not(data.actions.finish.message_type == "COMBAT"
              or data.actions.finish.message_type == "PRINT"
              or data.actions.finish.message_type == "ERROR")
            end,
        get = function() return data.actions.finish.r or 1, data.actions.finish.g or 1, data.actions.finish.b or 1 end,
        set = function(info, r, g, b)
          data.actions.finish.r = r;
          data.actions.finish.g = g;
          data.actions.finish.b = b;
          WeakAuras.Add(data);
        end
      },
      finish_message_dest = {
        type = "input",
        width = WeakAuras.normalWidth - 0.15,
        name = L["Send To"],
        order = 23.1,
        disabled = function() return not data.actions.finish.do_message end,
        hidden = function() return data.actions.finish.message_type ~= "WHISPER" end,
        control = "WeakAurasInput",
        callbacks = {
          OnEditFocusGained = function(self)
            local widget = dynamicTextInputs["finish_message_dest"]
            OptionsPrivate.ToggleTextReplacements(data, widget, "OnEditFocusGained")
          end,
          OnEditFocusLost = function(self)
            OptionsPrivate.ToggleTextReplacements(nil, nil, "OnEditFocusLost")
          end,
          OnEnterPressed = function(self)
            OptionsPrivate.ToggleTextReplacements(nil, nil, "OnEnterPressed")
          end,
          OnShow = function(self)
            dynamicTextInputs["finish_message_dest"] = self
          end,
        }
      },
      finish_message_dest_text_replacements_button = {
        type = "execute",
        width = 0.15,
        name = L["Dynamic Text Replacements"],
        desc = L["There are several special codes available to make this text dynamic. Click to view a list with all dynamic text codes."],
        order = 23.11,
        disabled = function() return not data.actions.finish.do_message end,
        hidden = function() return data.actions.finish.message_type ~= "WHISPER" end,
        func = function()
          local widget = dynamicTextInputs["finish_message_dest"]
          OptionsPrivate.ToggleTextReplacements(data, widget, "ToggleButton")
        end,
        imageWidth = 24,
        imageHeight = 24,
        control = "WeakAurasIcon",
        image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\sidebar",
      },
      finish_message_dest_isunit = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Is Unit"],
        order = 23.15,
        hidden = function()
          return data.actions.finish.message_type ~= "WHISPER"
        end
      },
      finish_message = {
        type = "input",
        width = WeakAuras.doubleWidth - 0.15,
        name = L["Message"],
        order = 24,
        disabled = function() return not data.actions.finish.do_message end,
        control = "WeakAurasInput",
        callbacks = {
          OnEditFocusGained = function(self)
            local widget = dynamicTextInputs["finish_message"]
            OptionsPrivate.ToggleTextReplacements(data, widget, "OnEditFocusGained")
          end,
          OnEditFocusLost = function(self)
            OptionsPrivate.ToggleTextReplacements(nil, nil, "OnEditFocusLost")
          end,
          OnEnterPressed = function(self)
            OptionsPrivate.ToggleTextReplacements(nil, nil, "OnEnterPressed")
          end,
          OnShow = function(self)
            dynamicTextInputs["finish_message"] = self
          end,
        }
      },
      finish_message_text_replacements_button = {
        type = "execute",
        width = 0.15,
        name = L["Dynamic Text Replacements"],
        desc = L["There are several special codes available to make this text dynamic. Click to view a list with all dynamic text codes."],
        order = 24.1,
        disabled = function() return not data.actions.finish.do_message end,
        func = function()
          local widget = dynamicTextInputs["finish_message"]
          OptionsPrivate.ToggleTextReplacements(data, widget, "ToggleButton")
        end,
        imageWidth = 24,
        imageHeight = 24,
        control = "WeakAurasIcon",
        image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\sidebar",
      },
      -- texteditor added below
      finish_do_sound = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Play Sound"],
        order = 28
      },
      finish_sound = {
        type = "select",
        width = WeakAuras.normalWidth,
        name = L["Sound"],
        order = 28.1,
        itemControl = "WeakAurasMediaSound",
        values = OptionsPrivate.Private.sound_types,
        sorting = OptionsPrivate.Private.SortOrderForValues(OptionsPrivate.Private.sound_types),
        disabled = function() return not data.actions.finish.do_sound end,
      },
      finish_sound_channel = {
        type = "select",
        width = WeakAuras.normalWidth,
        name = L["Sound Channel"],
        order = 28.5,
        values = OptionsPrivate.Private.sound_channel_types,
        disabled = function() return not data.actions.finish.do_sound end,
        get = function() return data.actions.finish.sound_channel or "Master" end
      },
      finish_sound_path = {
        type = "input",
        width = WeakAuras.doubleWidth,
        name = L["Sound File Path"],
        order = 29,
        hidden = function() return data.actions.finish.sound ~= " custom" end,
        disabled = function() return not data.actions.finish.do_sound end
      },
      finish_sound_kit_id = {
        type = "input",
        width = WeakAuras.doubleWidth,
        name = L["Sound Kit ID"],
        order = 29,
        hidden = function() return data.actions.finish.sound ~= " KitID" end,
        disabled = function() return not data.actions.finish.do_sound end
      },
      finish_do_glow = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Glow External Element"],
        order = 30.1
      },
      finish_glow_action = {
        type = "select",
        width = WeakAuras.normalWidth,
        name = L["Glow Action"],
        order = 30.2,
        values = OptionsPrivate.Private.glow_action_types,
        disabled = function() return not data.actions.finish.do_glow end
      },
      finish_glow_frame_type = {
        type = "select",
        width = WeakAuras.normalWidth,
        desc = function()
          return (
            data.actions.finish.glow_frame_type == "UNITFRAME"
            or data.actions.finish.glow_frame_type == "NAMEPLATE"
          )
          and L["Require unit from trigger"] or nil
        end,
        name = L["Glow Frame Type"],
        order = 30.3,
        values = OptionsPrivate.Private.glow_frame_types,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action == nil
        end
      },
      finish_glow_type_spacer = {
        type = "description",
        width = WeakAuras.normalWidth,
        name = "",
        order = 30.35,
        hidden = function()
          return not data.actions.finish.do_glow
          or not (data.actions.finish.glow_action == "hide" and data.actions.finish.glow_frame_type == "FRAMESELECTOR")
        end,
      },
      finish_glow_type = {
        type = "select",
        width = WeakAuras.normalWidth,
        name = L["Glow Type"],
        order = 30.4,
        values = OptionsPrivate.Private.glow_types,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action ~= "show"
          or data.actions.finish.glow_frame_type == nil
        end,
      },
      finish_glow_frame = {
        type = "input",
        width = WeakAuras.normalWidth,
        name = L["Frame"],
        order = 30.5,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_frame_type ~= "FRAMESELECTOR"
        end
      },
      finish_choose_glow_frame = {
        type = "execute",
        width = WeakAuras.normalWidth,
        name = L["Choose"],
        order = 30.55,
        hidden = function() return not data.actions.finish.do_glow or data.actions.finish.glow_frame_type ~= "FRAMESELECTOR" end,
        func = function()
          if(data.controlledChildren and data.controlledChildren[1]) then
            WeakAuras.PickDisplay(data.controlledChildren[1]);
            OptionsPrivate.StartFrameChooser(WeakAuras.GetData(data.controlledChildren[1]), {"actions", "finish", "glow_frame"});
          else
            OptionsPrivate.StartFrameChooser(data, {"actions", "finish", "glow_frame"});
          end
        end
      },
      finish_use_glow_color = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Glow Color"],
        order = 30.7,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action ~= "show"
          or data.actions.finish.glow_frame_type == nil
          or data.actions.finish.glow_type == nil
        end,
      },
      finish_glow_color = {
        type = "color",
        hasAlpha = true,
        width = WeakAuras.normalWidth,
        name = L["Glow Color"],
        order = 30.8,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action ~= "show"
          or data.actions.finish.glow_frame_type == nil
          or data.actions.finish.glow_type == nil
        end,
        disabled = function() return not data.actions.finish.use_glow_color end,
      },
      finish_glow_startAnim = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Start Animation"],
        order = 10.801,
        get = function()
          return data.actions.finish.glow_startAnim and true or false
        end,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action ~= "show"
          or data.actions.finish.glow_frame_type == nil
          or data.actions.finish.glow_type ~= "Proc"
        end,
      },
      finish_glow_duration = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Duration"],
        order = 10.802,
        softMin = 0.01,
        softMax = 3,
        step = 0.05,
        get = function()
          return data.actions.finish.glow_duration or 1
        end,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action ~= "show"
          or data.actions.finish.glow_frame_type == nil
          or data.actions.finish.glow_type ~= "Proc"
        end,
      },
      finish_glow_lines = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Lines & Particles"],
        order = 30.81,
        min = 1,
        softMax = 30,
        step = 1,
        get = function()
          return data.actions.finish.glow_lines or 8
        end,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action ~= "show"
          or not data.actions.finish.glow_type
          or data.actions.finish.glow_type == "buttonOverlay"
          or data.actions.start.glow_type == "Proc"
          or data.actions.finish.glow_frame_type == nil
        end,
      },
      finish_glow_frequency = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Frequency"],
        order = 30.82,
        softMin = -2,
        softMax = 2,
        step = 0.05,
        get = function()
          return data.actions.finish.glow_frequency or 0.25
        end,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action ~= "show"
          or not data.actions.finish.glow_type
          or data.actions.finish.glow_type == "buttonOverlay"
          or data.actions.start.glow_type == "Proc"
          or data.actions.finish.glow_frame_type == nil
        end,
      },
      finish_glow_length = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Length"],
        order = 30.83,
        min = 0.05,
        softMax = 20,
        step = 0.05,
        get = function()
          return data.actions.finish.glow_length or 10
        end,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action ~= "show"
          or data.actions.finish.glow_type ~= "Pixel"
          or data.actions.finish.glow_frame_type == nil
        end,
      },
      finish_glow_thickness = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Thickness"],
        order = 30.84,
        min = 0.05,
        softMax = 20,
        step = 0.05,
        get = function()
          return data.actions.finish.glow_thickness or 1
        end,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action ~= "show"
          or data.actions.finish.glow_type ~= "Pixel"
          or data.actions.finish.glow_frame_type == nil
        end,
      },
      finish_glow_XOffset = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["X-Offset"],
        order = 30.85,
        softMin = -100,
        softMax = 100,
        step = 0.5,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action ~= "show"
          or not data.actions.finish.glow_type
          or data.actions.finish.glow_type == "buttonOverlay"
          or data.actions.finish.glow_frame_type == nil
        end,
      },
      finish_glow_YOffset = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Y-Offset"],
        order = 30.86,
        softMin = -100,
        softMax = 100,
        step = 0.5,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action ~= "show"
          or not data.actions.finish.glow_type
          or data.actions.finish.glow_type == "buttonOverlay"
          or data.actions.finish.glow_frame_type == nil
        end,
      },
      finish_glow_scale = {
        type = "range",
        control = "WeakAurasSpinBox",
        width = WeakAuras.normalWidth,
        name = L["Scale"],
        order = 30.87,
        min = 0.05,
        softMax = 10,
        step = 0.05,
        isPercent = true,
        get = function()
          return data.actions.finish.glow_scale or 1
        end,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action ~= "show"
          or data.actions.finish.glow_type ~= "ACShine"
          or data.actions.finish.glow_frame_type == nil
        end,
      },
      finish_glow_border = {
        type = "toggle",
        width = WeakAuras.normalWidth,
        name = L["Border"],
        order = 30.88,
        hidden = function()
          return not data.actions.finish.do_glow
          or data.actions.finish.glow_action ~= "show"
          or data.actions.finish.glow_type ~= "Pixel"
          or data.actions.finish.glow_frame_type == nil
        end,
      },
      finish_hide_all_glows = {
        type = "toggle",
        width = WeakAuras.doubleWidth,
        name = L["Hide Glows applied by this aura"],
        order = 31,
      },
      finish_do_custom = {
        type = "toggle",
        width = WeakAuras.doubleWidth,
        name = L["Custom"],
        order = 32,
      },
    -- Text editor added below
    },
  }

  -- Text format option helpers

  OptionsPrivate.commonOptions.AddCodeOption(action.args, data, L["Custom Code"], "init", "https://github.com/WeakAuras/WeakAuras2/wiki/Custom-Code-Blocks#on-init",
                          0.21, function() return not data.actions.init.do_custom end, {"actions", "init", "custom"}, true)

  OptionsPrivate.commonOptions.AddCodeOption(action.args, data, L["Custom Code"], "customOnLoad", "https://github.com/WeakAuras/WeakAuras2/wiki/Custom-Code-Blocks#on-load",
                          0.31, function() return not data.actions.init.do_custom_load end, {"actions", "init", "customOnLoad"}, true)
  OptionsPrivate.commonOptions.AddCodeOption(action.args, data, L["Custom Code"], "customOnUnload", "https://github.com/WeakAuras/WeakAuras2/wiki/Custom-Code-Blocks#on-unload",
                          0.41, function() return not data.actions.init.do_custom_unload end, {"actions", "init", "customOnUnload"}, true)

  OptionsPrivate.commonOptions.AddCodeOption(action.args, data, L["Custom Code"], "start_message", "https://github.com/WeakAuras/WeakAuras2/wiki/Custom-Code-Blocks#chat-message---custom-code",
                          5, function() return not (data.actions.start.do_message and (OptionsPrivate.Private.ContainsCustomPlaceHolder(data.actions.start.message) or (data.actions.start.message_type == "WHISPER" and OptionsPrivate.Private.ContainsCustomPlaceHolder(data.actions.start.message_dest)))) end, {"actions", "start", "message_custom"}, false);

  local startHidden = function()
    return OptionsPrivate.IsCollapsed("format_option", "actions", "start_message", true)
  end

  local startSetHidden = function(hidden)
    OptionsPrivate.SetCollapsed("format_option", "actions", "start_message", hidden)
  end

  local startGet = function(key)
    return data.actions.start["message_format_" .. key]
  end

  local order = 6
  local usedKeys = {}
  local function startAddOption(key, option)
    if usedKeys[key] then
      return
    end
    usedKeys[key] = true
    option.order = order
    order = order + 0.01
    local reload = option.reloadOptions
    option.reloadOptions = nil
    option.set = function(info, v)
      data.actions.start["message_format_" .. key] = v
      WeakAuras.Add(data)
      if reload then
        WeakAuras.ClearAndUpdateOptions(data.id)
      end
    end

    if option.hidden then
      local hidden = option.hidden
      option.hidden = function() return not data.actions.start.do_message or hidden() end
    else
      option.hidden = function() return not data.actions.start.do_message end
    end

    action.args["start_message_format_" .. key] = option
  end

  if data.controlledChildren then
    local list = {}
    for child in OptionsPrivate.Private.TraverseLeafs(data) do
      tinsert(list, child)
    end

    for index, child in ipairs(list) do
      local startGet = function(key)
        return child.actions.start["message_format_" .. key]
      end
      OptionsPrivate.AddTextFormatOption(child.actions and child.actions.start.message, true, startGet, startAddOption, startHidden, startSetHidden, true, index, #list)
    end
  else
    OptionsPrivate.AddTextFormatOption(data.actions and data.actions.start.message, true, startGet, startAddOption, startHidden, startSetHidden, true)
  end


  OptionsPrivate.commonOptions.AddCodeOption(action.args, data, L["Custom Code"], "start", "https://github.com/WeakAuras/WeakAuras2/wiki/Custom-Code-Blocks#on-show",
                          13, function() return not data.actions.start.do_custom end, {"actions", "start", "custom"}, true);

  OptionsPrivate.commonOptions.AddCodeOption(action.args, data, L["Custom Code"], "finish_message", "https://github.com/WeakAuras/WeakAuras2/wiki/Custom-Code-Blocks#chat-message---custom-code",
                          25, function() return not (data.actions.finish.do_message and (OptionsPrivate.Private.ContainsCustomPlaceHolder(data.actions.finish.message) or (data.actions.finish.message_type == "WHISPER" and OptionsPrivate.Private.ContainsCustomPlaceHolder(data.actions.finish.message_dest)))) end, {"actions", "finish", "message_custom"}, false);

  local finishHidden = function()
    return OptionsPrivate.IsCollapsed("format_option", "actions", "finish_message", true)
  end

  local finishSetHidden = function(hidden)
    OptionsPrivate.SetCollapsed("format_option", "actions", "finish_message", hidden)
  end

  local finishGet = function(key)
    return data.actions.finish["message_format_" .. key]
  end

  order = 26
  usedKeys = {}
  local function finishAddOption(key, option)
    if usedKeys[key] then
      return
    end
    option.order = order
    order = order + 0.01
    local reload = option.reloadOptions
    option.reloadOptions = nil
    option.set = function(info, v)
      data.actions.finish["message_format_" .. key] = v
      WeakAuras.Add(data)
      if reload then
        WeakAuras.ClearAndUpdateOptions(data.id)
      end
    end

    if option.hidden then
      local hidden = option.hidden
      option.hidden = function() return not data.actions.finish.do_message or hidden() end
    else
      option.hidden = function() return not data.actions.finish.do_message end
    end

    action.args["finish_message_format_" .. key] = option
  end

  if data.controlledChildren then
    local list = {}
    for child in OptionsPrivate.Private.TraverseLeafs(data) do
      tinsert(list, child)
    end
    for index, child in ipairs(list) do
      local finishGet = function(key)
        return child.actions.finish["message_format_" .. key]
      end
      OptionsPrivate.AddTextFormatOption(child.actions and child.actions.finish.message, true, finishGet, finishAddOption, finishHidden, finishSetHidden, true, index, #list)
    end
  else
    OptionsPrivate.AddTextFormatOption(data.actions and data.actions.finish.message, true, finishGet, finishAddOption, finishHidden, finishSetHidden, true)
  end

  OptionsPrivate.commonOptions.AddCodeOption(action.args, data, L["Custom Code"], "finish", "https://github.com/WeakAuras/WeakAuras2/wiki/Custom-Code-Blocks#on-hide",
                          32, function() return not data.actions.finish.do_custom end, {"actions", "finish", "custom"}, true);

  if data.controlledChildren then
    removeFuncs(action)
    replaceNameDescFuncs(action, data, "action")
    replaceImageFuncs(action, data, "action")
    replaceValuesFuncs(action, data, "action")

    action.get = function(info, ...) return getAll(data, info, ...); end;
    action.set = function(info, ...)
      setAll(data, info, ...);
      if(type(data.id) == "string") then
        WeakAuras.Add(data);
        WeakAuras.UpdateThumbnail(data);
        OptionsPrivate.ResetMoverSizer();
      end
    end
    action.hidden = function(info, ...) return hiddenAll(data, info, ...); end;
    action.disabled = function(info, ...) return disabledAll(data, info, ...); end;
  end

  return action;
end
