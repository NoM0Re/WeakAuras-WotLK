if not WeakAuras.IsLibsOK() then return end

---@type string
local AddonName = ...
---@class Private
local Private = select(2, ...)

local LibSpec = WeakAuras.LGT

local subscribers = {}

---@class LibSpecWrapper
---@field Register fun(callback: fun(unit: string))
---@field SpecForUnit fun(unit: string): number?
---@field SpecRolePositionForUnit fun(unit: string): number?, string?, string?
---@field CheckTalentForUnit fun(unit: string, talentId: number): boolean?
---@field CheckGlyphForUnit fun(unit: string, glyphId: number): boolean?
Private.LibSpecWrapper = {
  Register = function(_) end,
  SpecForUnit = function(_) end,
  SpecRolePositionForUnit = function(_) end,
  CheckTalentForUnit = function(_, _) end,
  CheckGlyphForUnit = function(_, _) end,
}

if LibSpec then
  local function ResolveSpecForUnit(unit, role)
    if not unit then return end

    local class = select(2, UnitClass(unit))
    local specIDsByTree = class and Private.specIDByClassAndTree[class]
    if not specIDsByTree then return end

    local _, tree1, tree2, tree3 = LibSpec:GetUnitTalentSpec(unit)
    if not tree1 then return end

    local treeIndex = 1
    if tree2 > tree1 and tree2 > tree3 then
      treeIndex = 2
    elseif tree3 > tree1 and tree3 > tree2 then
      treeIndex = 3
    end

    local specID = specIDsByTree[treeIndex]
    -- LibGroupTalents does not distinguish Feral and Guardian.
    if specID == 103 and (role or LibSpec:GetUnitRole(unit)) == "tank" then
      return 104
    end
    return specID
  end

  function Private.LibSpecWrapper.Register(f)
    tinsert(subscribers, f)
  end

  function Private.LibSpecWrapper.SpecForUnit(unit)
    return ResolveSpecForUnit(unit)
  end

  function Private.LibSpecWrapper.SpecRolePositionForUnit(unit)
    local role = LibSpec:GetUnitRole(unit)
    local position = role == "caster" and "RANGED"
                  or role == "melee" and "MELEE"
                  or role
    return ResolveSpecForUnit(unit, role), role, position
  end

  function Private.LibSpecWrapper.CheckTalentForUnit(unit, talentId)
    local talentName = GetSpellInfo(talentId)
    if talentName then
      return LibSpec:UnitHasTalent(unit, talentName) and true or nil
    end
  end

  function Private.LibSpecWrapper.CheckGlyphForUnit(unit, glyphId)
    return LibSpec:UnitHasGlyph(unit, glyphId)
  end

  function Private.LibSpecWrapper.CallbackHandler(_, _, _, unit)
    if unit then
      for _, f in ipairs(subscribers) do
        f(unit)
      end
    end
  end

  LibSpec.RegisterCallback(Private.LibSpecWrapper, "LibGroupTalents_Update", "CallbackHandler")
  LibSpec.RegisterCallback(Private.LibSpecWrapper, "LibGroupTalents_RoleChange", "CallbackHandler")
end

-- Export for GenericTrigger
WeakAuras.SpecForUnit = Private.LibSpecWrapper.SpecForUnit
WeakAuras.SpecRolePositionForUnit = Private.LibSpecWrapper.SpecRolePositionForUnit
WeakAuras.CheckTalentForUnit = Private.LibSpecWrapper.CheckTalentForUnit
WeakAuras.CheckGlyphForUnit = Private.LibSpecWrapper.CheckGlyphForUnit

-- Export for Spec & Class Trigger
function Private.ExecEnv.GetSpecialization()
  return Private.LibSpecWrapper.SpecForUnit("player")
end

function Private.ExecEnv.GetSpecializationInfo(specID)
  local specInfo = Private.specInfoByID[specID]
  if specInfo then
    return specInfo.id, specInfo.name, nil, specInfo.icon
  end
end
