if not WeakAuras.IsLibsOK() then return end
---@type string
local AddonName = ...
---@class Private
local Private = select(2, ...)
local L = WeakAuras.L

--- @class AuraEnvironmentWrappedSystem
--- @field Get fun(systemName: string, id: auraId, cloneId: string?): any

--- @type AuraEnvironmentWrappedSystem
Private.AuraEnvironmentWrappedSystem = {
  Get = function(systemName, id, cloneId)
  end
}

--- @type table<auraId, table<string, table<string, any>>> Table of id, cloneId, systemName to wrapped system
local wrappers = {}

--- @type fun(_: any, uid: uid, id: auraId)
local function OnDelete(_, uid, id)
  wrappers[id] = nil
end

--- @type fun(_: any, uid: uid, oldId: auraId, newId: auraId)
local function OnRename(_, uid, oldId, newId)
  wrappers[newId] = wrappers[oldId]
  wrappers[oldId] = nil
end

Private.callbacks:RegisterCallback("Delete", OnDelete)
Private.callbacks:RegisterCallback("Rename", OnRename)

local WrapData = {
  C_Timer = {
    { name = "After", arg = 2},
    { name = "NewTimer", arg = 2},
    { name = "NewTicker", arg = 2}
  }
}

--- @type fun(id: auraId, cloneId: string, system: any, funcs: {name: string, arg: number}[])
--- @return table wrappedSystem
local function Wrap(id, cloneId, system, funcs)
  if type(system) ~= "table" then
    return system
  end
  local wrappedSystem = {}
  for _, data in ipairs(funcs) do
    local func = system[data.name]
    if type(func) == "function" then
      wrappedSystem[data.name] = function(...)
        local packed = Private.SafePack(...)
        local oldArg = select(data.arg, ...)
        if type(oldArg) == "function" then
          packed[data.arg] = function(...)
            local region = WeakAuras.GetRegion(id, cloneId)
            if region then
              Private.ActivateAuraEnvironmentForRegion(region)
              local ok = pcall(oldArg, ...)
              if not ok then
                Private.GetErrorHandlerId(id, L["Callback function"])
              end
              Private.ActivateAuraEnvironment()
            else
              return oldArg(...)
            end
          end
        end
        return func(Private.SafeUnpack(packed))
      end
    end
  end
  setmetatable(wrappedSystem, { __index = system, __metatable = false })
  return wrappedSystem
end

Private.AuraEnvironmentWrappedSystem.Get = function(systemName, id, cloneId)
  local cloneIdKey = cloneId or ""
  wrappers[id] = wrappers[id] or {}
  wrappers[id][cloneIdKey] = wrappers[id][cloneIdKey] or {}
  wrappers[id][cloneIdKey][systemName] = wrappers[id][cloneIdKey][systemName]
    or Wrap(id, cloneId, _G[systemName], WrapData[systemName])
  return wrappers[id][cloneIdKey][systemName]
end
