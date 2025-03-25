local AddonName = ...
local Private = select(2, ...)

local attachedToTarget = {}
local targetToAttached = {}

-- Handles
local function OnDelete(_, uid, id)
  local target = attachedToTarget[id]
  if target then
    if targetToAttached[target] then
      targetToAttached[target][id] = nil
    end
    attachedToTarget[id] = nil
  end
end

local function OnRename(_, uid, oldId, newId)

  local target = attachedToTarget[oldId]
  if target then
    -- renamed aura is an attached aura
    attachedToTarget[newId] = attachedToTarget[oldId]
    attachedToTarget[oldId] = nil

    targetToAttached[target][oldId] = nil
    targetToAttached[target][newId] = true
  end

  -- renamed aura is a targeted aura
  if targetToAttached[oldId] then
    for attached in pairs(targetToAttached[oldId]) do
      local data = WeakAuras.GetData(attached)
      if data then
        data.anchorFrameFrame = "WeakAuras:" .. newId
        WeakAuras.Add(data, true)
      end

      attachedToTarget[attached] = newId
    end
    targetToAttached[newId] = targetToAttached[oldId]
    targetToAttached[oldId] = nil
  end

end

local function OnAdd(_, uid, id, data, simpleChange)
  if simpleChange then
    return
  end
  OnDelete(nil, uid, id)
  if data.anchorFrameType == "SELECTFRAME"
     and data.anchorFrameFrame
     and data.anchorFrameFrame:sub(1, 10) == "WeakAuras:"
  then
    local target = data.anchorFrameFrame:sub(11)
    attachedToTarget[data.id] = target
    targetToAttached[target] = targetToAttached[target] or {}
    targetToAttached[target][data.id] = true
  end
end

Private.callbacks:RegisterCallback("Delete", OnDelete)
Private.callbacks:RegisterCallback("Rename", OnRename)
Private.callbacks:RegisterCallback("Add", OnAdd)
