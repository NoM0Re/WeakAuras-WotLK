if not WeakAuras.IsLibsOK() then return end
local AddonName = ...
local Private = select(2, ...)

local function fixMissingFields(state)
  if type(state) ~= "table" then return end
  -- set show
  if state.show == nil then
    state.show = true
  end
end

local remove = function(states, key)
  local changed = false
  local state = states[key]
  if state then
    state.show = false
    state.changed = true
    states.__changed = true
    changed = true
  end
  return changed
end

local removeAll = function(states)
  local changed = false
  for _, state in pairs(states) do
    state.show = false
    state.changed = true
    changed = true
  end
  if changed then
    states.__changed = true
  end
  return changed
end

local function recurseUpdate(t1, t2)
  local changed = false
  for k, v in pairs(t2) do
    if type(v) == "table" and type(t1[k]) == "table" then
      if recurseUpdate(t1[k], v) then
        changed = true
      end
    else
      if t1[k] ~= v then
        t1[k] = v
        changed = true
      end
    end
  end
  return changed
end

local update = function(states, key, newState)
  local changed = false
  local state = states[key]
  if state then
    fixMissingFields(newState)
    changed = recurseUpdate(state, newState)
    if changed then
      state.changed = true
      states.__changed = true
    end
  end
  return changed
end

local create = function(states, key, newState)
  states[key] = newState
  states[key].changed = true
  states.__changed = true
  fixMissingFields(states[key])
  return true
end

local createOrUpdate = function(states, key, newState)
  key = key or ""
  if states[key] then
    return update(states, key, newState)
  else
    return create(states, key, newState)
  end
end

Private.allstatesMetatable = {
  __index = {
    Update = createOrUpdate,
    Remove = remove,
    RemoveAll = removeAll
  }
}
