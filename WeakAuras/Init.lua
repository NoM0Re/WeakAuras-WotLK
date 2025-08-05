local AddonName = ...
local Private = select(2, ...)
WeakAuras = {}
WeakAuras.L = {}
Private.frames = {}

WeakAuras.normalWidth = 1.3
WeakAuras.halfWidth = WeakAuras.normalWidth / 2
WeakAuras.doubleWidth = WeakAuras.normalWidth * 2

local versionStringFromToc = GetAddOnMetadata("WeakAuras", "Version")
local versionString = "5.20.1 Beta"
local buildTime = "20250721200906"
local isAwesomeEnabled = C_NamePlate and C_NamePlate.GetNamePlateForUnit and true or false

local flavor
if GetRealmName() == "Onyxia" or (GetRealmName() == "Blackrock [PvP only]" and GetExpansionLevel() == 1) then
  flavor = "TBC"
elseif GetRealmName() == "Kezan" then
  flavor = "ClassicPlus"
else
  flavor = "Wrath"
end

WeakAuras.versionString = versionString
WeakAuras.buildTime = buildTime
WeakAuras.newFeatureString = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0|t"
WeakAuras.BuildInfo = select(4, GetBuildInfo())

function WeakAuras.IsAwesomeEnabled()
  return isAwesomeEnabled or false
end

function WeakAuras.IsCorrectVersion()
  return true
end

function WeakAuras.IsWrath()
  return flavor == "Wrath"
end

function WeakAuras.IsTBC()
  return flavor == "TBC"
end

function WeakAuras.IsClassicPlus()
  return flavor == "ClassicPlus"
end

function WeakAuras.IsClassicPlusOrTBC()
  return WeakAuras.IsClassicPlus() or WeakAuras.IsTBC()
end

WeakAuras.prettyPrint = function(...)
  print("|cff9900ffWeakAuras:|r ", ...)
end

-- Force enable WeakAurasCompanion and Archive because some addon managers interfere with it
EnableAddOn("WeakAurasCompanion")
EnableAddOn("WeakAurasArchive")

local libsAreOk = true
do
  local StandAloneLibs = {
    "Archivist",
    "LibStub"
  }
  local LibStubLibs = {
    "CallbackHandler-1.0",
    "AceTimer-3.0",
    "AceSerializer-3.0",
    "AceComm-3.0",
    "LibSharedMedia-3.0",
    "LibDataBroker-1.1",
    "LibCompress",
    "SpellRange-1.0",
    "LibCustomGlow-1.0",
    "LibDBIcon-1.0",
    "LibGetFrame-1.0",
    "LibSerialize",
    "LibGroupTalents-1.0",
  }
  for _, lib in ipairs(StandAloneLibs) do
    if not lib then
        libsAreOk = false
        WeakAuras.prettyPrint("Missing library:", lib)
    end
  end
  if LibStub then
    for _, lib in ipairs(LibStubLibs) do
        if not LibStub:GetLibrary(lib, true) then
          libsAreOk = false
          WeakAuras.prettyPrint("Missing library:", lib)
        end
    end
  else
    libsAreOk = false
  end
end

function WeakAuras.IsLibsOK()
  return libsAreOk
end

if not libsAreOk then
  WeakAuras.prettyPrint("WeakAuras is missing necessary libraries. Please reinstall a proper package.")
end

if versionString ~= versionStringFromToc .. " Beta" and versionStringFromToc ~= "Dev" then
  WeakAuras.prettyPrint("You need to restart your game client to complete the WeakAuras update!")
end

if not WeakAuras.IsLibsOK() then
  WeakAuras.prettyPrint("WeakAuras is missing necessary libraries. Please reinstall a proper package.")
end

-- These function stubs are defined here to reduce the number of errors that occur if WeakAuras.lua fails to compile
function Private.RegisterRegionType(_, _, _ ,_)
end

function Private.RegisterRegionOptions(_, _ , _ ,_)
end

function Private.StartProfileSystem(_)
end

function Private.StartProfileAura(_)
end

function Private.StopProfileSystem(_)
end

function Private.StopProfileAura(_)
end

function Private.StartProfileUID()
end

function Private.StopProfileUID()
end

Private.ExecEnv = {}

-- If WeakAuras shuts down due to being installed on the wrong target, keep the bindings from erroring
function WeakAuras.StartProfile(_)
end

function WeakAuras.StopProfile()
end

function WeakAuras.PrintProfile()
end

function WeakAuras.CountWagoUpdates()
  -- XXX this is to work around the Companion app trying to use our stuff!
  return 0
end

function WeakAuras.Mixin(object, ...)
  for i = 1, select("#", ...) do
    local mixin = select(i, ...)
    for k, v in pairs(mixin) do
      object[k] = v
    end
  end
  return object
end
