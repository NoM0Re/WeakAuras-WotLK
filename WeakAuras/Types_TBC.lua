if not WeakAuras.IsLibsOK() then return end
local AddonName = ...
local Private = select(2, ...)

-- Talent Data for the Warmane TBC Realms "Onyxia" and "Blackrock TBC"
if not WeakAuras.IsTBC() then
  return
end

local WeakAuras = WeakAuras;
local L = WeakAuras.L;

local encounter_list = ""
function Private.InitializeEncounterAndZoneLists()
  if encounter_list ~= "" then
    return
  end
  local raids = {
    {
      L["Karazhan"],
      {
        { L["Attumen the Huntsman"], 652 },
        { L["Moroes"], 653 },
        { L["Maiden of Virtue"], 654 },
        { L["Opera Hall"], 655 },
        { L["The Curator"], 656 },
        { L["Terestian Illhoof"], 657 },
        { L["Shade of Aran"], 658 },
        { L["Netherspite"], 659 },
        { L["Chess Event"], 660 },
        { L["Prince Malchezaar"], 661 },
        { L["Nightbane"], 662 },
      }
    },
    {
      L["Gruul's Lair"],
      {
        { L["High King Maulgar"], 649 },
        { L["Gruul the Dragonkiller"], 650 },
      }
    },
    {
      L["Magtheridon's Lair"],
      {
        { L["Magtheridon"], 651 },
      }
    },
    {
      L["Coilfang: Serpentshrine Cavern"],
      {
        { L["Hydross the Unstable"], 623 },
        { L["The Lurker Below"], 624 },
        { L["Leotheras the Blind"], 625 },
        { L["Fathom-Lord Karathress"], 626 },
        { L["Morogrim Tidewalker"], 627 },
        { L["Lady Vashj"], 628 },
      }
    },
    {
      L["Tempest Keep"],
      {
        { L["Al'ar"], 730 },
        { L["Void Reaver"], 731 },
        { L["High Astromancer Solarian"], 732 },
        { L["Kael'thas Sunstrider"], 733 },
      }
    },
    {
      L["The Battle for Mount Hyjal"],
      {
        { L["Rage Winterchill"], 618 },
        { L["Anetheron"], 619 },
        { L["Kaz'rogal"], 620 },
        { L["Azgalor"], 621 },
        { L["Archimonde"], 622 },
      }
    },
    {
      L["Black Temple"],
      {
        { L["High Warlord Naj'entus"], 601 },
        { L["Supremus"], 602 },
        { L["Shade of Akama"], 603 },
        { L["Teron Gorefiend"], 604 },
        { L["Gurtogg Bloodboil"], 605 },
        { L["Reliquary of Souls"], 606 },
        { L["Mother Shahraz"], 607 },
        { L["The Illidari Council"], 608 },
        { L["Illidan Stormrage"], 609 },
      }
    },
    {
      L["Zul'Aman"],
      {
        { L["Akil'zon"], 1189 },
        { L["Nalorakk"], 1190 },
        { L["Jan'alai"], 1191 },
        { L["Halazzi"], 1192 },
        { L["Hex Lord Malacrass"], 1193 },
        { L["Daakara"], 1194 },
      }
    },
    {
      L["The Sunwell Plateau"],
      {
        { L["Kalecgos"], 724 },
        { L["Brutallus"], 725 },
        { L["Felmyst"], 726 },
        { L["Eredar Twins"], 727 },
        { L["M'uru"], 728 },
        { L["Kil'jaeden"], 729 },
      }
    }
  }
  for _, raid in ipairs(raids) do
    encounter_list = ("%s|cffffd200%s|r\n"):format(encounter_list, raid[1])
    for _, boss in ipairs(raid[2]) do
        encounter_list = ("%s%s: %d\n"):format(encounter_list, boss[1], boss[2])
    end
    encounter_list = encounter_list .. "\n"
  end

  encounter_list = encounter_list:sub(1, -3) .. "\n\n" .. L["Supports multiple entries, separated by commas\n"]
end

function Private.get_encounters_list()
  return encounter_list
end

function Private.get_zoneId_list()
  return ""
end

Private.encounterId_to_modName = {
  [224] = "386",-- 9938:Magmus, DBM-Party-Classic/BlackrockDepths/Magmus.lua
  [227] = "369",-- 9018:High Interrogator Gerstahn, DBM-Party-Classic/BlackrockDepths/Gerstahn.lua
  [228] = "370",-- 9025:Lord Roccor, DBM-Party-Classic/BlackrockDepths/LordRoccor.lua
  [229] = "371",-- 9319:Houndmaster Grebmar, DBM-Party-Classic/BlackrockDepths/HoundmasterGrebmar.lua
  [230] = "372",-- 9027:Gorosh the Dervish |9028:Grizzle |9029:Eviscerator |9030:Ok'thor the Breaker |9031:Anub'shiah |9032:Hedrum the Creeper, DBM-Party-Classic/BlackrockDepths/RingofLaw.lua
  [231] = "373",-- 9024:Pyromancer Loregrain, DBM-Party-Classic/BlackrockDepths/PyromancerLoregrain.lua
  [232] = "374",-- 9017:Lord Incendius, DBM-Party-Classic/BlackrockDepths/LordIncendius.lua
  [233] = "375",-- 9041:Warder Stilgiss, DBM-Party-Classic/BlackrockDepths/WardenStilgiss.lua
  [234] = "376",-- 9056:Fineous Darkvire, DBM-Party-Classic/BlackrockDepths/FineousDarkvire.lua
  [235] = "377",-- 9016:Bael'Gar, DBM-Party-Classic/BlackrockDepths/BaelGar.lua
  [236] = "378",-- 9033:General Angerforge, DBM-Party-Classic/BlackrockDepths/GeneralAngerforge.lua
  [237] = "379",-- 8983:Golem Lord Argelmach, DBM-Party-Classic/BlackrockDepths/GolemLordArgelmach.lua
  [238] = "380",-- 9537:Hurley Blackbreath, DBM-Party-Classic/BlackrockDepths/HurleyBlackbreath.lua
  [239] = "381",-- 9502:Phalanx, DBM-Party-Classic/BlackrockDepths/Phalanx.lua
  [241] = "383",-- 9499:Plugger Spazzring, DBM-Party-Classic/BlackrockDepths/PluggerSpazzring.lua
  [242] = "384",-- 9156:Ambassador Flamelash, DBM-Party-Classic/BlackrockDepths/AmbassadorFlamelash.lua
  [243] = "385",-- 9034:Hate'rel |9035:Anger'rel |9036:Vile'rel |9037:Gloom'rel |9038:Seeth'rel |9039:Doom'rel |9040:Dope'rel, DBM-Party-Classic/BlackrockDepths/TheSeven.lua
  [245] = "387",-- 9019:Emperor Dagran Thaurissan, DBM-Party-Classic/BlackrockDepths/EmperorDagranThaurissan.lua
  [250] = "536",-- 22930:Yor, DBM-Party-BC/Auct_Tombs/Yor.lua
  [267] = "388",-- 9196:Highlord Omokk, DBM-Party-Classic/LowerBlackrockSpire/HighlordOmokk.lua
  [268] = "389",-- 9236:Shadow Hunter Vosh'gajin, DBM-Party-Classic/LowerBlackrockSpire/ShadowHunterVoshgajin.lua
  [269] = "390",-- 9237:War Master Voone, DBM-Party-Classic/LowerBlackrockSpire/WarMasterVoone.lua
  [270] = "391",-- 10596:Mother Smolderweb, DBM-Party-Classic/LowerBlackrockSpire/MotherSmolderweb.lua
  [271] = "392",-- 10584:Urok Doomhowl, DBM-Party-Classic/LowerBlackrockSpire/UrokDoomhowl.lua
  [272] = "393",-- 9736:Quartermaster Zigris, DBM-Party-Classic/LowerBlackrockSpire/QuartermasterZigris.lua
  [273] = "395",-- 10268:Gizrul the Slavener, DBM-Party-Classic/LowerBlackrockSpire/Gizrul.lua
  [274] = "394",-- 10220:Halycon, DBM-Party-Classic/LowerBlackrockSpire/Halycon.lua
  [275] = "396",-- 9568:Overlord Wyrmthalak, DBM-Party-Classic/LowerBlackrockSpire/OverlordWyrmthalak.lua
  [276] = "PyroguardEmberseer",-- 9816:Pyroguard Emberseer, DBM-Party-Classic/UpperBlackrockSpire/PyroguardEmberseer.lua
  [277] = "SolakarFlamewreath",-- 10264:Solakar Flamewreath, DBM-Party-Classic/UpperBlackrockSpire/SolakarFlamewreath.lua
  [278] = "WarchiefRendBlackhand",-- 10339:Gyth |10429:Warchief Rend Blackhand, DBM-Party-Classic/UpperBlackrockSpire/WarchiefRendBlackhand.lua
  [279] = "TheBeast",-- 10430:The Beast, DBM-Party-Classic/UpperBlackrockSpire/TheBeast.lua
  [280] = "GeneralDrakkisath",-- 10363:General Drakkisath, DBM-Party-Classic/UpperBlackrockSpire/GeneralDrakkisath.lua
  [343] = "402",-- 11490:Zevrim Thornhoof, DBM-Party-Classic/DireMaul/ZevrimThornhoof.lua
  [344] = "403",-- 13280:Hydrospawn, DBM-Party-Classic/DireMaul/Hydrospawn.lua
  [345] = "404",-- 14327:Lethtendris, DBM-Party-Classic/DireMaul/Lethtendris.lua
  [346] = "405",-- 11492:Alzzin the Wildshaper, DBM-Party-Classic/DireMaul/Alzzin.lua
  [347] = "407",-- 11488:Illyanna Ravenoak, DBM-Party-Classic/DireMaul/IllyannaRavenoak.lua
  [348] = "408",-- 11487:Magister Kalendris, DBM-Party-Classic/DireMaul/MagisterKelendris.lua
  [349] = "409",-- 11496:Immol'thar, DBM-Party-Classic/DireMaul/Immolthar.lua
  [350] = "406",-- 11489:Tendris Warpwood, DBM-Party-Classic/DireMaul/TendrisWarpwood.lua
  [361] = "410",-- 11486:Prince Tortheldrin, DBM-Party-Classic/DireMaul/PrinceTortheldrin.lua
  [362] = "411",-- 14326:Guard Mol'dar, DBM-Party-Classic/DireMaul/GuardMoldar.lua
  [363] = "412",-- 14322:Stomper Kreeg, DBM-Party-Classic/DireMaul/StomperKreeg.lua
  [364] = "413",-- 14321:Guard Fengus, DBM-Party-Classic/DireMaul/GuardFengus.lua
  [365] = "414",-- 14323:Guard Slip'kik, DBM-Party-Classic/DireMaul/GuardSlipkik.lua
  [366] = "415",-- 14325:Captain Kromcrush, DBM-Party-Classic/DireMaul/CaptainKromcrush.lua
  [367] = "416",-- 14324:Cho'Rush the Observer, DBM-Party-Classic/DireMaul/ChoRush.lua
  [368] = "417",-- 11501:King Gordok, DBM-Party-Classic/DireMaul/KingGordok.lua
  [378] = "420",-- 7079:Viscous Fallout, DBM-Party-Classic/Gnomeregan/ViscousFallout.lua
  [379] = "419",-- 7361:Grubbis, DBM-Party-Classic/Gnomeregan/Grubbis.lua
  [380] = "421",-- 6235:Electrocutioner 6000, DBM-Party-Classic/Gnomeregan/Electrocutioner6000.lua
  [381] = "418",-- 6229:Crowd Pummeler 9-60, DBM-Party-Classic/Gnomeregan/CrowdPummeler.lua
  [382] = "422",-- 7800:Mekgineer Thermaplugg, DBM-Party-Classic/Gnomeregan/MekgineerThermaplugg.lua
  [422] = "423",-- 13282:Noxxion, DBM-Party-Classic/Maraudon/Noxxion.lua
  [423] = "424",-- 12258:Razorlash, DBM-Party-Classic/Maraudon/Razorlash.lua
  [424] = "427",-- 12236:Lord Vyletongue, DBM-Party-Classic/Maraudon/LordVyletongue.lua
  [425] = "428",-- 12225:Celebras the Cursed, DBM-Party-Classic/Maraudon/CelebrastheCursed.lua
  [426] = "429",-- 12203:Landslide, DBM-Party-Classic/Maraudon/Landslide.lua
  [427] = "425",-- 13601:Tinkerer Gizlock, DBM-Party-Classic/Maraudon/TinkererGizlock.lua
  [428] = "430",-- 13596:Rotgrip, DBM-Party-Classic/Maraudon/Rotgrip.lua
  [429] = "431",-- 12201:Princess Theradras, DBM-Party-Classic/Maraudon/PrincessTheradras.lua
  [438] = "AgathelostheRaging|AggemThorncurse|DeathSpeakerJargba|BlindHunter|Roogug|EarthcallerHalmgar",-- 4422:Agathelos the Raging |4424:Aggem Thorncurse |4428:Death Speaker Jargba |4425:Blind Hunter |6168:Roogug |4842:Earthcaller Halmgar, DBM-Party-Classic/RazorfenKraul/AgathelostheRaging.lua | DBM-Party-Classic/RazorfenKraul/AggemThorncurse.lua | DBM-Party-Classic/RazorfenKraul/DeathSpeakerJargba.lua | DBM-Party-Classic/RazorfenKraul/BlindHunter.lua | DBM-Party-Classic/RazorfenKraul/Roogug.lua | DBM-Party-Classic/RazorfenKraul/EarthcallerHalmgar.lua
  [444] = "InterrogatorVishas",-- 3983:Interrogator Vishas, DBM-Party-Classic/ScarletMonastery/InterrogatorVishas.lua
  [446] = "HoundmasterLoksey",-- 3974:Houndmaster Loksey, DBM-Party-Classic/ScarletMonastery/HoundmasterLoksey.lua
  [447] = "ArcanistDoan",-- 6487:Arcanist Doan, DBM-Party-Classic/ScarletMonastery/ArcanistDoan.lua
  [448] = "Herod",-- 3975:Herod, DBM-Party-Classic/ScarletMonastery/Herod.lua
  [449] = "Fairbanks",-- 4542:High Inquisitor Fairbanks, DBM-Party-Classic/ScarletMonastery/HighInquisitorFairbanks.lua
  [450] = "Mograine_and_Whitemane",-- 3976:Scarlet Commander Mograine |3977:High Inquisitor Whitemane |99999:Lord Solanar Bloodwrath, DBM-Party-Classic/ScarletMonastery/Mograine_and_Whitemane.lua
  [451] = "KirtonostheHerald",-- 10506:Kirtonos the Herald, DBM-Party-Classic/Scholomance/KirtonostheHerald.lua
  [452] = "JandiceBarov",-- 10503:Jandice Barov, DBM-Party-Classic/Scholomance/JandiceBarov.lua
  [453] = "Rattlegore",-- 11622:Rattlegore, DBM-Party-Classic/Scholomance/Rattlegore.lua
  [454] = "MardukBlackpool",-- 10433:Marduk Blackpool, DBM-Party-Classic/Scholomance/MardukBlackpool.lua
  [455] = "Vectus",-- 10432:Vectus, DBM-Party-Classic/Scholomance/Vectus.lua
  [456] = "RasFrostwhisper",-- 10508:Ras Frostwhisper, DBM-Party-Classic/Scholomance/RasFrostwhisper.lua
  [457] = "InstructorMalicia",-- 10505:Instructor Malicia, DBM-Party-Classic/Scholomance/InstructorMalicia.lua
  [458] = "DoctorTheolenKrastinov",-- 11261:Doctor Theolen Krastinov, DBM-Party-Classic/Scholomance/DoctorTheolenKrastinov.lua
  [459] = "LorekeeperPolkelt",-- 10901:Lorekeeper Polkelt, DBM-Party-Classic/Scholomance/LorekeeperPolkelt.lua
  [460] = "TheRavenian",-- 10507:The Ravenian, DBM-Party-Classic/Scholomance/TheRavenian.lua
  [461] = "LordAlexeiBarov",-- 10504:Lord Alexei Barov, DBM-Party-Classic/Scholomance/LordAlexeiBarov.lua
  [462] = "LadyIlluciaBarov",-- 10502:Lady Illucia Barov, DBM-Party-Classic/Scholomance/LadyIlluciaBarov.lua
  [463] = "DarkmasterGandling",-- 1853:Darkmaster Gandling, DBM-Party-Classic/Scholomance/DarkmasterGandling.lua
  [464] = "Rethilgore",-- 3914:Rethilgore, DBM-Party-Classic/Shadowfangkeep/Rethilgore.lua
  [465] = "RazorclawtheButcher",-- 3886:Razorclaw the Butcher, DBM-Party-Classic/Shadowfangkeep/RazorclawtheButcher.lua
  [468] = "OdotheBlindwatcher",-- 4279:Odo the Blindwatcher, DBM-Party-Classic/Shadowfangkeep/OdotheBlindwatcher.lua
  [469] = "FenrustheDevourer",-- 4274:Fenrus the Devourer, DBM-Party-Classic/Shadowfangkeep/FenrustheDevourer.lua
  [470] = "WolfMasterNandos",-- 3927:Wolf Master Nandos, DBM-Party-Classic/Shadowfangkeep/WolfMasterNandos.lua
  [471] = "ArchmageArugal",-- 4275:Archmage Arugal, DBM-Party-Classic/Shadowfangkeep/ArchmageArugal.lua
  [472] = "450",-- 10516:The Unforgiven, DBM-Party-Classic/Stratholme/TheUnforgiven.lua
  [473] = "443",-- 10558:Hearthsinger Forresten, DBM-Party-Classic/Stratholme/HearthsingerForresten.lua
  [474] = "445",-- 10808:Timmy the Cruel, DBM-Party-Classic/Stratholme/TimmytheCruel.lua
  [475] = "446",-- 10997:Willey Hopebreaker, DBM-Party-Classic/Stratholme/WilleyHopebreaker.lua
  [476] = "749",-- 11032:Commander Malor, DBM-Party-Classic/Stratholme/CommanderMalor.lua
  [477] = "448",-- 10811:Instructor Galford, DBM-Party-Classic/Stratholme/InstructorGalford.lua
  [478] = "449",-- 10812:Grand Crusader Dathrohan |10813:Balnazzar, DBM-Party-Classic/Stratholme/Balnazzar.lua
  [479] = "451",-- 10436:Baroness Anastari, DBM-Party-Classic/Stratholme/BaronessAnastari.lua
  [480] = "452",-- 10437:Nerub'enkan, DBM-Party-Classic/Stratholme/Narubenkan.lua
  [481] = "453",-- 10438:Maleki the Pallid, DBM-Party-Classic/Stratholme/MalekithePallid.lua
  [482] = "454",-- 10435:Magistrate Barthilas, DBM-Party-Classic/Stratholme/MagistrateBarthilas.lua
  [483] = "455",-- 10439:Ramstein the Gorger, DBM-Party-Classic/Stratholme/RamsteintheGorger.lua
  [484] = "456",-- 10440:Baron Rivendare, DBM-Party-Classic/Stratholme/LordAuriusRivendare.lua
  [486] = "Dreamscythe",-- 5721:Dreamscythe, DBM-Party-Classic/SunkenTemple/Dreamscythe.lua
  [487] = "Weaver|598|599",-- 5720:Weaver, DBM-Party-Classic/SunkenTemple/Weaver.lua
  [488] = "458",-- 5710:Jammal'an the Prophet, DBM-Party-Classic/SunkenTemple/JammalantheProphet.lua
  [490] = "Morphaz",-- 5719:Morphaz, DBM-Party-Classic/SunkenTemple/Morphaz.lua
  [491] = "Hazzas",-- 5722:Hazzas, DBM-Party-Classic/SunkenTemple/Hazzas.lua
  [492] = "457",-- 8443:Avatar of Hakkar, DBM-Party-Classic/SunkenTemple/AvatarofHakkar.lua
  [493] = "463",-- 5709:Shade of Eranikus, DBM-Party-Classic/SunkenTemple/ShadeofEranikus.lua
  -- [519] = "Commander",-- 26796:Commander Stoutbeard |26798:Commander Kolurg, DBM-Party-WotLK/TheNexus/Commander.lua
  -- [530] = "VarosCloudstrider",-- 27447:Varos Cloudstrider, DBM-Party-WotLK/TheOculus/VarosCloudstrider.lua
  -- [533] = "MageLordUrom",-- 27655:Mage-Lord Urom, DBM-Party-WotLK/TheOculus/MageLordUrom.lua
  -- [534] = "LeyGuardianEregos",-- 27656:Ley-Guardian Eregos, DBM-Party-WotLK/TheOculus/LeyGuardianEregos.lua
  [547] = "467",-- 6910:Revelosh, DBM-Party-Classic/Uldaman/Revelosh.lua
  [548] = "468",-- 6906:Baelog |6907:Eric |6908:Olaf, DBM-Party-Classic/Uldaman/TheLostDwarves.lua
  [549] = "469",-- 7228:Ironaya, DBM-Party-Classic/Uldaman/Ironaya.lua
  [551] = "470",-- 7206:Ancient Stone Keeper, DBM-Party-Classic/Uldaman/AncientStoneKeeper.lua
  [552] = "471",-- 7291:Galgann Firehammer, DBM-Party-Classic/Uldaman/GalgannFirehammer.lua
  [553] = "472",-- 4854:Grimlok, DBM-Party-Classic/Uldaman/Grimlok.lua
  [554] = "473",-- 2748:Archaedas, DBM-Party-Classic/Uldaman/Archaedas.lua
  [585] = "Tutenkash|474|AmnennartheColdbringer|Glutton|MordreshFireEye|PlaguemawtheRotting|Ragglesnout",-- 7355:Tuten'kash |7358:Amnennar the Coldbringer |8567:Glutton |7357:Mordresh Fire Eye |7356:Plaguemaw the Rotting |7354:Ragglesnout, DBM-Party-Classic/RazorfenDowns/Tutenkash.lua | DBM-Party-Classic/RazorfenDowns/AmnennartheColdbringer.lua | DBM-Party-Classic/RazorfenDowns/Glutton.lua | DBM-Party-Classic/RazorfenDowns/MordreshFireEye.lua | DBM-Party-Classic/RazorfenDowns/PlaguemawtheRotting.lua | DBM-Party-Classic/RazorfenDowns/Ragglesnout.lua
  [586] = "475",-- 3669:Lord Cobrahn, DBM-Party-Classic/WailingCaverns/LordCobrahn.lua
  [587] = "477",-- 3653:Kresh, DBM-Party-Classic/WailingCaverns/Kresh.lua
  [588] = "476",-- 3670:Lord Pythas, DBM-Party-Classic/WailingCaverns/LordPythas.lua
  [589] = "478",-- 3674:Skum, DBM-Party-Classic/WailingCaverns/Skum.lua
  [590] = "479",-- 3673:Lord Serpentis, DBM-Party-Classic/WailingCaverns/LordSerpentis.lua
  [591] = "480",-- 5775:Verdan the Everliving, DBM-Party-Classic/WailingCaverns/VerantheEverliving.lua
  [592] = "481",-- 3654:Mutanus the Devourer, DBM-Party-Classic/WailingCaverns/MutanustheDevourer.lua
  [593] = "HydromancerVelrath",-- 7795:Hydromancer Velratha, DBM-Party-Classic/ZulFarrak/HydromancerVelrath.lua
  [594] = "483",-- 7273:Gahz'rilla, DBM-Party-Classic/ZulFarrak/Gahzrilla.lua
  [595] = "484",-- 8127:Antu'sul, DBM-Party-Classic/ZulFarrak/Antusul.lua
  [596] = "485",-- 7272:Theka the Martyr, DBM-Party-Classic/ZulFarrak/ThekatheMartyr.lua
  [597] = "486",-- 7271:Witch Doctor Zum'rah, DBM-Party-Classic/ZulFarrak/WitchDoctorZumrah.lua
  [600] = "489",-- 7267:Chief Ukorz Sandscalp, DBM-Party-Classic/ZulFarrak/ChiefUkorzSandscalp.lua
  [601] = "Najentus",-- 22887:High Warlord Naj'entus, DBM-BlackTemple/Najentus.lua
  [602] = "Supremus",-- 22898:Supremus, DBM-BlackTemple/Supremus.lua
  [603] = "Akama",-- 22841:Shade of Akama, DBM-BlackTemple/ShadeOfAkama.lua
  [604] = "TeronGorefiend",-- 22871:Teron Gorefiend, DBM-BlackTemple/TeronGorefiend.lua
  [605] = "Bloodboil",-- 22948:Gurtogg Bloodboil, DBM-BlackTemple/Bloodboil.lua
  [606] = "Souls",-- 23418:Essence of Suffering, DBM-BlackTemple/EssenceOfSouls.lua
  [607] = "Shahraz",-- 22947:Mother Shahraz, DBM-BlackTemple/Shahraz.lua
  [608] = "Council",-- 22949:Gathios the Shatterer |22950:High Nethermancer Zerevor |22951:Lady Malande |22952:Veras Darkshadow, DBM-BlackTemple/IllidariCouncil.lua
  [609] = "Illidan",-- 22917:Illidan Stormrage, DBM-BlackTemple/Illidan.lua
  [610] = "Razorgore",-- 12435:Razorgore the Untamed |99999:Lord Solanar Bloodwrath, DBM-BWL/Razorgore.lua
  [611] = "Vaelastrasz",-- 13020:Vaelastrasz the Corrupt, DBM-BWL/Vaelastrasz.lua
  [612] = "Broodlord",-- 12017:Broodlord Lashlayer, DBM-BWL/Broodlord.lua
  [613] = "Firemaw",-- 11983:Firemaw, DBM-BWL/Firemaw.lua
  [614] = "Ebonroc",-- 14601:Ebonroc, DBM-BWL/Ebonroc.lua
  [615] = "Flamegor",-- 11981:Flamegor, DBM-BWL/Flamegor.lua
  [616] = "Chromaggus",-- 14020:Chromaggus, DBM-BWL/Chromaggus.lua
  [617] = "Nefarian-Classic",-- 11583:Nefarian, DBM-BWL/Nefarian.lua
  [618] = "Rage",-- 17767:Rage Winterchill, DBM-Hyjal/RageWinterchill.lua
  [619] = "Anetheron",-- 17808:Anetheron, DBM-Hyjal/Anetheron.lua
  [620] = "Kazrogal",-- 17888:Kaz'rogal, DBM-Hyjal/Kazrogal.lua
  [621] = "Azgalor",-- 17842:Azgalor, DBM-Hyjal/Azgalor.lua
  [622] = "Archimonde",-- 17968:Archimonde, DBM-Hyjal/Archimonde.lua
  [623] = "Hydross",-- 21216:Hydross the Unstable, DBM-Serpentshrine/Hydross.lua
  [624] = "LurkerBelow",-- 21217:The Lurker Below, DBM-Serpentshrine/TheLurkerBelow.lua
  [625] = "Leotheras",-- 21215:Leotheras the Blind, DBM-Serpentshrine/Leotheras.lua
  [626] = "Fathomlord",-- 21214:Fathom-Lord Karathress, DBM-Serpentshrine/Fathomlord.lua
  [627] = "Tidewalker",-- 21213:Morogrim Tidewalker, DBM-Serpentshrine/Tidewalker.lua
  [628] = "Vashj",-- 21212:Lady Vashj, DBM-Serpentshrine/Vashj.lua
  [649] = "Maulgar",-- 18831:High King Maulgar |18832:Krosh Firehand |18834:Olm the Summoner |18835:Kiggler the Crazed |18836:Blindeye the Seer, DBM-Gruul/Maulgar.lua
  [650] = "Gruul",-- 19044:Gruul the Dragonkiller, DBM-Gruul/Gruul.lua
  [651] = "Magtheridon",-- 17257:Magtheridon, DBM-Magtheridon/Magtheridon.lua
  [652] = "Attumen",-- 16151:Midnight |16152:Attumen the Huntsman, DBM-Karazhan/Attumen.lua
  [653] = "Moroes",-- 15687:Moroes, DBM-Karazhan/Moroes.lua
  [654] = "Maiden",-- 16457:Maiden of Virtue, DBM-Karazhan/MaidenOfVirtue.lua
  [655] = "BigBadWolf|RomuloAndJulianne|Oz",-- 17521:The Big Bad Wolf |17533:Romulo |17534:Julianne |99999:Lord Solanar Bloodwrath |18168:The Crone, DBM-Karazhan/BigBadWolf.lua | DBM-Karazhan/RomuloAndJulianne.lua | DBM-Karazhan/WizardOfOz.lua
  [656] = "Curator",-- 15691:The Curator, DBM-Karazhan/Curator.lua
  [657] = "TerestianIllhoof",-- 15688:Terestian Illhoof, DBM-Karazhan/TerestianIllhoof.lua
  [658] = "Aran",-- 16524:Shade of Aran, DBM-Karazhan/ShadeOfAran.lua
  [659] = "Netherspite",-- 15689:Netherspite, DBM-Karazhan/Netherspite.lua
  [660] = "Chess",-- 21684:King Llane |21752:Warchief Blackhand, DBM-Karazhan/Chess.lua
  [661] = "Prince",-- 15690:Prince Malchezaar, DBM-Karazhan/PrinceMalchezaar.lua
  [662] = "NightbaneRaid",-- 17225:Nightbane, DBM-Karazhan/Nightbane.lua
  [663] = "Lucifron",-- 12118:Lucifron, DBM-MC/Lucifron.lua
  [664] = "Magmadar",-- 11982:Magmadar, DBM-MC/Magmadar.lua
  [665] = "Gehennas",-- 12259:Gehennas, DBM-MC/Gehennas.lua
  [666] = "Garr-Classic",-- 12057:Garr, DBM-MC/Garr.lua
  [667] = "Shazzrah",-- 12264:Shazzrah, DBM-MC/Shazzrah.lua
  [668] = "Geddon",-- 12056:Baron Geddon, DBM-MC/Geddon.lua
  [669] = "Sulfuron",-- 12098:Sulfuron Harbinger, DBM-MC/Sulfuron.lua
  [670] = "Golemagg",-- 11988:Golemagg the Incinerator, DBM-MC/Golemagg.lua
  [671] = "Majordomo",-- 11663:Flamewaker Healer |11664:Flamewaker Elite |12018:Majordomo Executus, DBM-MC/Majordomo.lua
  [672] = "Ragnaros-Classic",-- 11502:Ragnaros, DBM-MC/Ragnaros.lua
  [709] = "Skeram",-- 15263:The Prophet Skeram, DBM-AQ40/Skeram.lua
  [710] = "ThreeBugs",-- 15511:Lord Kri |15543:Princess Yauj |15544:Vem, DBM-AQ40/ThreeBugs.lua
  [711] = "Sartura",-- 15516:Battleguard Sartura, DBM-AQ40/Sartura.lua
  [712] = "Fankriss",-- 15510:Fankriss the Unyielding, DBM-AQ40/Fankriss.lua
  [713] = "Viscidus",-- 15299:Viscidus, DBM-AQ40/Viscidus.lua
  [714] = "Huhuran",-- 15509:Princess Huhuran, DBM-AQ40/Huhuran.lua
  [715] = "TwinEmpsAQ",-- 15275:Emperor Vek'nilash |15276:Emperor Vek'lor, DBM-AQ40/TwinEmps.lua
  [716] = "Ouro",-- 15517:Ouro, DBM-AQ40/Ouro.lua
  [717] = "CThun",-- 15589:Eye of C'Thun |15727:C'Thun, DBM-AQ40/CThun.lua
  [718] = "Kurinnaxx",-- 15348:Kurinnaxx, DBM-AQ20/Kurinnaxx.lua
  [719] = "Rajaxx",-- 15341:General Rajaxx, DBM-AQ20/Rajaxx.lua
  [720] = "Moam",-- 15340:Moam, DBM-AQ20/Moam.lua
  [721] = "Buru",-- 15370:Buru the Gorger, DBM-AQ20/Buru.lua
  [722] = "Ayamiss",-- 15369:Ayamiss the Hunter, DBM-AQ20/Ayamiss.lua
  [723] = "Ossirian",-- 15339:Ossirian the Unscarred, DBM-AQ20/Ossirian.lua
  [724] = "Kal",-- 24850:Kalecgos, DBM-Sunwell/Kalecgos.lua
  [725] = "Brutallus",-- 24882:Brutallus, DBM-Sunwell/Brutallus.lua
  [726] = "Felmyst",-- 25038:Felmyst, DBM-Sunwell/Felmyst.lua
  [727] = "Twins",-- 25165:Lady Sacrolash |25166:Grand Warlock Alythess, DBM-Sunwell/EredarTwins.lua
  [728] = "Muru",-- 25741:M'uru, DBM-Sunwell/M'uru.lua
  [729] = "Kil",-- 25315:Kil'jaeden, DBM-Sunwell/Kil'jaeden.lua
  [730] = "Alar",-- 19514:Al'ar, DBM-TheEye/Alar.lua
  [731] = "VoidReaver",-- 19516:Void Reaver, DBM-TheEye/VoidReaver.lua
  [732] = "Solarian",-- 18805:High Astromancer Solarian, DBM-TheEye/Solarian.lua
  [733] = "KaelThas",-- 19622:Kael'thas Sunstrider, DBM-TheEye/KaelThas.lua
  [784] = "Venoxis",-- 14507:High Priest Venoxis, DBM-ZG/Venoxis.lua
  [785] = "Jeklik",-- 14517:High Priestess Jeklik, DBM-ZG/Jeklik.lua
  [786] = "Marli",-- 14510:High Priestess Mar'li, DBM-ZG/Marli.lua
  [787] = "Bloodlord",-- 11382:Bloodlord Mandokir |14988:Ohgan, DBM-ZG/Bloodlord.lua
  [788] = "EdgeOfMadness",-- 15083:Hazza'rah, DBM-ZG/EdgeOfMadness.lua
  [789] = "Thekal",-- 11347:Zealot Lor'Khan |11348:Zealot Zath |14509:High Priest Thekal, DBM-ZG/Thekal.lua
  [790] = "Gahzranka",-- 15114:Gahz'ranka, DBM-ZG/Gahzranka.lua
  [791] = "Arlokk",-- 14515:High Priestess Arlokk, DBM-ZG/Arlokk.lua
  [792] = "Jindo",-- 11380:Jin'do the Hexxer, DBM-ZG/Jindo.lua
  [793] = "Hakkar",-- 14834:Hakkar, DBM-ZG/Hakkar.lua
  [1070] = "BaronSilverlaine",-- 3887:Baron Silverlaine, DBM-Party-Classic/Shadowfangkeep/BaronSilverlaine.lua
  [1071] = "CommanderSpringvale",-- 4278:Commander Springvale, DBM-Party-Classic/Shadowfangkeep/CommanderSpringvale.lua
  [1084] = "Onyxia|Onyxia-Vanilla",-- 10184:Onyxia |10184:Onyxia, DBM-Onyxia/Onyxia.lua | DBM-VanillaOnyxia/Onyxia.lua
  -- [1085] = "Anub'arak_Coliseum",
  -- [1086] = "Champions",-- 34441:Vivienne Blackwhisper |34444:Thrakgar |34445:Liandra Suncaller |34447:Caiphus the Stern |34448:Ruj'kah |34449:Ginselle Blightslinger |34450:Harkzog |34451:Birana Stormhoof |34453:Narrhok Steelbreaker |34454:Maz'dinah |34455:Broln Stouthorn |34456:Malithas Brightblade |34458:Gorgrim Shadowcleave |34459:Erin Misthoof |34460:Kavina Grovesong |34461:Tyrius Duskblade |34463:Shaabad |34465:Velanaa |34466:Anthar Forgemender |34467:Alyssia Moonstalker |34468:Noozle Whizzlestick |34469:Melador Valestrider |34470:Saamul |34471:Baelnor Lightbearer |34472:Irieth Shadowstep |34473:Brienna Nightfell |34474:Serissa Grimdabbler |34475:Shocuul, DBM-Coliseum/Champions.lua
  -- [1087] = "Jaraxxus",-- 34780:Lord Jaraxxus, DBM-Coliseum/Jaraxxus.lua
  -- [1088] = "NorthrendBeasts",-- 34796:Gormok the Impaler |34797:Icehowl |34799:Dreadscale |35144:Acidmaw, DBM-Coliseum/NorthrendBeasts.lua
  -- [1089] = "ValkTwins",-- 34496:Eydis Darkbane |34497:Fjola Lightbane, DBM-Coliseum/Twins.lua
  -- [1090] = "Sartharion",-- 28860:Sartharion, DBM-ChamberOfAspects/Obsidian/Sartharion.lua
  -- [1091] = "Shadron",-- 30451:Shadron, DBM-ChamberOfAspects/Obsidian/Shadron.lua
  -- [1092] = "Tenebron",-- 30452:Tenebron, DBM-ChamberOfAspects/Obsidian/Tenebron.lua
  -- [1093] = "Vesperon",-- 30449:Vesperon, DBM-ChamberOfAspects/Obsidian/Vesperon.lua
  -- [1094] = "Malygos",-- 28859:Malygos, DBM-EyeOfEternity/Malygos.lua
  -- [1095] = "BPCouncil",-- 37970:Prince Valanar |37972:Prince Keleseth |37973:Prince Taldaram, DBM-Icecrown/TheCrimsonHall/BPCouncil.lua
  -- [1096] = "Deathbringer",-- 37813:Deathbringer Saurfang, DBM-Icecrown/TheLowerSpire/Deathbringer.lua
  -- [1097] = "Festergut",-- 36626:Festergut, DBM-Icecrown/ThePlagueworks/Festergut.lua
  -- [1098] = "Valithria",-- 36789:Valithria Dreamwalker, DBM-Icecrown/FrostwingHalls/Valithria.lua
  -- [1099] = "GunshipBattle",-- 36939:High Overlord Saurfang |36948:Muradin Bronzebeard |37215:Orgrim's Hammer |37540:The Skybreaker, DBM-Icecrown/TheLowerSpire/GunshipBattle.lua
  -- [1100] = "Deathwhisper",-- 36855:Lady Deathwhisper, DBM-Icecrown/TheLowerSpire/Deathwhisper.lua
  -- [1101] = "LordMarrowgar",-- 36612:Lord Marrowgar, DBM-Icecrown/TheLowerSpire/LordMarrowgar.lua
  -- [1102] = "Putricide",-- 36678:Professor Putricide, DBM-Icecrown/ThePlagueworks/Putricide.lua
  -- [1103] = "Lanathel",-- 37955:Blood-Queen Lana'thel, DBM-Icecrown/TheCrimsonHall/Lanathel.lua
  -- [1104] = "Rotface",-- 36627:Rotface, DBM-Icecrown/ThePlagueworks/Rotface.lua
  -- [1105] = "Sindragosa",-- 36853:Sindragosa, DBM-Icecrown/FrostwingHalls/Sindragosa.lua
  -- [1106] = "LichKing",-- 36597:The Lich King, DBM-Icecrown/TheFrozenThrone/LichKing.lua
  [1107] = "Anub'Rekhan|Anub'Rekhan-Vanilla",
  [1108] = "Gluth|Gluth-Vanilla",-- 15932:Gluth |15932:Gluth, DBM-Naxx/ConstructQuarter/Gluth.lua | DBM-VanillaNaxx/ConstructQuarter/Gluth.lua
  [1109] = "Gothik|Gothik-Vanilla",-- 16060:Gothik the Harvester |16060:Gothik the Harvester, DBM-Naxx/MilitaryQuarter/Gothik.lua | DBM-VanillaNaxx/MilitaryQuarter/Gothik.lua
  [1110] = "Faerlina|Faerlina-Vanilla",-- 15953:Grand Widow Faerlina |15953:Grand Widow Faerlina, DBM-Naxx/ArachnidQuarter/Faerlina.lua | DBM-VanillaNaxx/ArachnidQuarter/Faerlina.lua
  [1111] = "Grobbulus|Grobbulus-Vanilla",-- 15931:Grobbulus |15931:Grobbulus, DBM-Naxx/ConstructQuarter/Grobbulus.lua | DBM-VanillaNaxx/ConstructQuarter/Grobbulus.lua
  [1112] = "Heigan|Heigan-Vanilla",-- 15936:Heigan the Unclean |15936:Heigan the Unclean, DBM-Naxx/PlagueQuarter/Heigan.lua | DBM-VanillaNaxx/PlagueQuarter/Heigan.lua
  [1113] = "Razuvious|Razuvious-Vanilla",-- 16061:Instructor Razuvious |16061:Instructor Razuvious, DBM-Naxx/MilitaryQuarter/Razuvious.lua | DBM-VanillaNaxx/MilitaryQuarter/Razuvious.lua
  [1114] = "Kel'Thuzad|Kel'Thuzad-Vanilla",
  [1115] = "Loatheb|Loatheb-Vanilla",-- 16011:Loatheb |16011:Loatheb, DBM-Naxx/PlagueQuarter/Loatheb.lua | DBM-VanillaNaxx/PlagueQuarter/Loatheb.lua
  [1116] = "Maexxna|Maexxna-Vanilla",-- 15952:Maexxna |15952:Maexxna, DBM-Naxx/ArachnidQuarter/Maexxna.lua | DBM-VanillaNaxx/ArachnidQuarter/Maexxna.lua
  [1117] = "Noth|Noth-Vanilla",-- 15954:Noth the Plaguebringer |15954:Noth the Plaguebringer, DBM-Naxx/PlagueQuarter/Noth.lua | DBM-VanillaNaxx/PlagueQuarter/Noth.lua
  [1118] = "Patchwerk|Patchwerk-Vanilla",-- 16028:Patchwerk |16028:Patchwerk, DBM-Naxx/ConstructQuarter/Patchwerk.lua | DBM-VanillaNaxx/ConstructQuarter/Patchwerk.lua
  [1119] = "Sapphiron|Sapphiron-Vanilla",-- 15989:Sapphiron |15989:Sapphiron, DBM-Naxx/FrostwyrmLair/Sapphiron.lua | DBM-VanillaNaxx/FrostwyrmLair/Sapphiron.lua
  [1120] = "Thaddius|Thaddius-Vanilla",-- 15928:Thaddius |15928:Thaddius, DBM-Naxx/ConstructQuarter/Thaddius.lua | DBM-VanillaNaxx/ConstructQuarter/Thaddius.lua
  [1121] = "Horsemen|Horsemen-Vanilla",-- 16063:Sir Zeliek |16064:Thane Korth'azz |16065:Lady Blaumeux |30549:Baron Rivendare |16063:Sir Zeliek |16064:Thane Korth'azz |16065:Lady Blaumeux |30549:Baron Rivendare, DBM-Naxx/MilitaryQuarter/Horsemen.lua | DBM-VanillaNaxx/MilitaryQuarter/Horsemen.lua
  -- [1126] = "Archavon",-- 31125:Archavon the Stone Watcher, DBM-VoA/Archavon.lua
  -- [1127] = "Emalon",-- 33993:Emalon the Storm Watcher, DBM-VoA/Emalon.lua
  -- [1128] = "Koralon",-- 35013:Koralon the Flame Watcher, DBM-VoA/Koralon.lua
  -- [1129] = "Toravon",-- 38433:Toravon the Ice Watcher, DBM-VoA/Toravon.lua
  -- [1130] = "Algalon",-- 32871:Algalon the Observer, DBM-Ulduar/Algalon.lua
  -- [1131] = "Auriaya",-- 33515:Auriaya, DBM-Ulduar/Auriaya.lua
  -- [1132] = "FlameLeviathan",-- 33113:Flame Leviathan, DBM-Ulduar/FlameLeviathan.lua
  -- [1133] = "Freya",-- 32906:Freya, DBM-Ulduar/Freya.lua
  -- [1134] = "GeneralVezax",-- 33271:General Vezax, DBM-Ulduar/GeneralVezax.lua
  -- [1135] = "Hodir",-- 32845:Hodir |32926:Flash Freeze, DBM-Ulduar/Hodir.lua
  -- [1136] = "Ignis",-- 33118:Ignis the Furnace Master, DBM-Ulduar/Ignis.lua
  -- [1137] = "Kologarn",-- 32930:Kologarn, DBM-Ulduar/Kologarn.lua
  -- [1138] = "Mimiron",-- 33432:Leviathan Mk II, DBM-Ulduar/Mimiron.lua
  -- [1139] = "Razorscale",-- 33186:Razorscale, DBM-Ulduar/Razorscale.lua
  -- [1140] = "IronCouncil",-- 32857:Stormcaller Brundir |32867:Steelbreaker |32927:Runemaster Molgeim, DBM-Ulduar/IronCouncil.lua
  -- [1141] = "Thorim",-- 32865:Thorim, DBM-Ulduar/Thorim.lua
  -- [1142] = "XT002",-- 33293:XT-002 Deconstructor, DBM-Ulduar/XT002.lua
  -- [1143] = "YoggSaron",-- 33288:Yogg-Saron, DBM-Ulduar/YoggSaron.lua
  [1144] = "MinerJohnson",-- 3586:Miner Johnson, DBM-Party-Classic/Deadmines/MinerJohnson.lua
  -- [1147] = "Baltharus",-- 39751:Baltharus the Warborn, DBM-ChamberOfAspects/Ruby/Baltharus.lua
  -- [1148] = "Zarithrian",-- 39746:General Zarithrian, DBM-ChamberOfAspects/Ruby/Zarithrian.lua
  -- [1149] = "Saviana",-- 39747:Saviana Ragefire, DBM-ChamberOfAspects/Ruby/Saviana.lua
  -- [1150] = "Halion",-- 39863:Halion, DBM-ChamberOfAspects/Ruby/Halion.lua
  [1189] = "Akilzon",-- 23574:Akil'zon, DBM-ZulAman/Akil'zon.lua
  [1190] = "Nalorakk",-- 23576:Nalorakk, DBM-ZulAman/Nalorakk.lua
  [1191] = "Janalai",-- 23578:Jan'alai, DBM-ZulAman/Jan'alai.lua
  [1192] = "Halazzi",-- 23577:Halazzi, DBM-ZulAman/Halazzi.lua
  [1193] = "Malacrass",-- 24239:Hex Lord Malacrass, DBM-ZulAman/Malacrass.lua
  [1194] = "ZulJin",-- 23863:Daakara, DBM-ZulAman/Zul'jin.lua
  [1443] = "Oggleflint",-- 11517:Oggleflint, DBM-Party-Classic/RagefireChasm/Oggleflint.lua
  [1444] = "Jergosh",-- 11518:Jergosh the Invoker, DBM-Party-Classic/RagefireChasm/Jergosh.lua
  [1445] = "Bazzalan",-- 11519:Bazzalan, DBM-Party-Classic/RagefireChasm/Bazzalan.lua
  [1446] = "Taragaman",-- 11520:Taragaman the Hungerer, DBM-Party-Classic/RagefireChasm/Taragaman.lua
  [1659] = "OverlordRamtusk",-- 4420:Overlord Ramtusk, DBM-Party-Classic/RazorfenKraul/OverlordRamtusk.lua
  [1661] = "CharlgaRazorflank",-- 4421:Charlga Razorflank, DBM-Party-Classic/RazorfenKraul/CharlgaRazorflank.lua
  [1801] = "Kazzak|KazzakClassic",-- 18728:Doom Lord Kazzak |12397:Lord Kazzak, DBM-Outland/Kazzak.lua | DBM-Azeroth/KazzakClassic.lua
  [1887] = "748",-- 7023:Obsidian Sentinel, DBM-Party-Classic/Uldaman/ObsidianSentinel.lua
  [1889] = "524",-- 18373:Exarch Maladaar, DBM-Party-BC/Auct_Crypts/Maladaar.lua
  [1890] = "523",-- 18371:Shirrak the Dead Watcher, DBM-Party-BC/Auct_Crypts/Shirrak.lua
  [1891] = "528",-- 17308:Omor the Unscarred, DBM-Party-BC/Hellfire_Ramp/Omor.lua
  [1892] = "529",-- 17307:Vazruden the Herald |17537:Vazruden, DBM-Party-BC/Hellfire_Ramp/Vazruden.lua
  [1893] = "527",-- 17306:Watchkeeper Gargolmar, DBM-Party-BC/Hellfire_Ramp/Gargolmar.lua
  [1894] = "533",-- 24664:Kael'thas Sunstrider, DBM-Party-BC/MagistersTerrace/Kael'thas.lua
  [1895] = "532",-- 24560:Priestess Delrissa, DBM-Party-BC/MagistersTerrace/Delrissa.lua
  [1897] = "530",-- 24723:Selin Fireheart, DBM-Party-BC/MagistersTerrace/Selin.lua
  [1898] = "531",-- 24744:Vexallus, DBM-Party-BC/MagistersTerrace/Vexallus.lua
  [1899] = "537",-- 18344:Nexus-Prince Shaffar, DBM-Party-BC/Auct_Tombs/Shaffar.lua
  [1900] = "534",-- 18341:Pandemonius, DBM-Party-BC/Auct_Tombs/Pandemonius.lua
  [1901] = "535",-- 18343:Tavarok, DBM-Party-BC/Auct_Tombs/Tavarok.lua
  [1902] = "543",-- 18473:Talon King Ikiss, DBM-Party-BC/Auct_SethekkHalls/Ikiss.lua
  [1903] = "541",-- 18472:Darkweaver Syth, DBM-Party-BC/Auct_SethekkHalls/Syth.lua
  [1904] = "542",-- 23035:Anzu, DBM-Party-BC/Auct_SethekkHalls/Anzu.lua
  [1905] = "538",-- 17848:Lieutenant Drake, DBM-Party-BC/CoT_OldHillsbrad/Drake.lua
  [1906] = "540",-- 18096:Epoch Hunter, DBM-Party-BC/CoT_OldHillsbrad/EpochHunter.lua
  [1907] = "539",-- 17862:Captain Skarloc, DBM-Party-BC/CoT_OldHillsbrad/Skarloc.lua
  [1908] = "544",-- 18731:Ambassador Hellmaw, DBM-Party-BC/Auct_ShadowLabyrinth/Hellmaw.lua
  [1909] = "545",-- 18667:Blackheart the Inciter, DBM-Party-BC/Auct_ShadowLabyrinth/Inciter.lua
  [1910] = "547",-- 18708:Murmur, DBM-Party-BC/Auct_ShadowLabyrinth/Murmur.lua
  [1911] = "546",-- 18732:Grandmaster Vorpil, DBM-Party-BC/Auct_ShadowLabyrinth/Vorpil.lua
  [1913] = "549",-- 20885:Dalliah the Doomsayer, DBM-Party-BC/TK_Arcatraz/Dalliah.lua
  [1914] = "551",-- 20912:Harbinger Skyriss, DBM-Party-BC/TK_Arcatraz/Skyriss.lua
  [1915] = "550",-- 20886:Wrath-Scryer Soccothrates, DBM-Party-BC/TK_Arcatraz/Soccothrates.lua
  [1916] = "548",-- 20870:?, DBM-Party-BC/TK_Arcatraz/Zereketh.lua
  [1919] = "554",-- 17881:Aeonus, DBM-Party-BC/CoT_BlackMorass/Aeonus.lua
  [1920] = "552",-- 17879:Chrono Lord Deja, DBM-Party-BC/CoT_BlackMorass/Deja.lua
  [1921] = "553",-- 17880:Temporus, DBM-Party-BC/CoT_BlackMorass/Temporus.lua
  [1922] = "555",-- 17381:The Maker, DBM-Party-BC/Hellfire_BloodFurnace/Maker.lua
  [1923] = "557",-- 17377:Keli'dan the Breaker, DBM-Party-BC/Hellfire_BloodFurnace/Keli'dan.lua
  [1924] = "556",-- 17380:Broggok, DBM-Party-BC/Hellfire_BloodFurnace/Broggok.lua
  [1925] = "558",-- 17976:Commander Sarannis, DBM-Party-BC/TK_Botanica/Sarannis.lua
  [1926] = "559",-- 17975:High Botanist Freywinn, DBM-Party-BC/TK_Botanica/Freywinn.lua
  [1927] = "561",-- 17980:Laj, DBM-Party-BC/TK_Botanica/Laj.lua
  [1928] = "560",-- 17978:Thorngrin the Tender, DBM-Party-BC/TK_Botanica/Thorngrin.lua
  [1929] = "562",-- 17977:Warp Splinter, DBM-Party-BC/TK_Botanica/WarpSplinter.lua
  [1930] = "564",-- 19221:Nethermancer Sepethrea, DBM-Party-BC/TK_Mechanar/Sepethrea.lua
  [1931] = "565",-- 19220:Pathaleon the Calculator, DBM-Party-BC/TK_Mechanar/Pathaleon.lua
  [1932] = "563",-- 19219:Mechano-Lord Capacitus, DBM-Party-BC/TK_Mechanar/Capacitus.lua
  [1933] = "Gyrokill",-- 19218:Gatewatcher Gyro-Kill, DBM-Party-BC/TK_Mechanar/Gyrokill.lua
  [1934] = "Ironhand",-- 19710:Gatewatcher Iron-Hand, DBM-Party-BC/TK_Mechanar/Ironhand.lua
  [1935] = "728",-- 20923:Blood Guard Porung, DBM-Party-BC/Hellfire_ShatteredHalls/Porung.lua
  [1936] = "566",-- 16807:Grand Warlock Nethekurse, DBM-Party-BC/Hellfire_ShatteredHalls/Nethekurse.lua
  [1937] = "568",-- 16809:Warbringer O'mrogg, DBM-Party-BC/Hellfire_ShatteredHalls/O'mrogg.lua
  [1938] = "569",-- 16808:Warchief Kargath Bladefist, DBM-Party-BC/Hellfire_ShatteredHalls/Kargath.lua
  [1939] = "570",-- 17941:Mennu the Betrayer, DBM-Party-BC/Coil_Slavepens/Mennu.lua
  [1940] = "572",-- 17942:Quagmirran, DBM-Party-BC/Coil_Slavepens/Quagmirran.lua
  [1941] = "571",-- 17991:Rokmar the Crackler, DBM-Party-BC/Coil_Slavepens/Rokmar.lua
  [1942] = "573",-- 17797:Hydromancer Thespia, DBM-Party-BC/Coil_Steamvault/Thespia.lua
  [1943] = "574",-- 17796:Mekgineer Steamrigger, DBM-Party-BC/Coil_Steamvault/Steamrigger.lua
  [1944] = "575",-- 17798:Warlord Kalithresh, DBM-Party-BC/Coil_Steamvault/Kalithresh.lua
  [1945] = "577",-- 18105:Ghaz'an, DBM-Party-BC/Coil_Underbog/Ghazan.lua
  [1946] = "576",-- 17770:Hungarfen, DBM-Party-BC/Coil_Underbog/Hungarfen.lua
  [1947] = "578",-- 17826:Swamplord Musel'ek, DBM-Party-BC/Coil_Underbog/Muselek.lua
  [1948] = "579",-- 17882:The Black Stalker, DBM-Party-BC/Coil_Underbog/Stalker.lua
  -- [1966] = "Taldaram",-- 29308:Prince Taldaram, DBM-Party-WotLK/AhnKahet/Taldaram.lua
  -- [1967] = "JedogaShadowseeker",-- 29310:Jedoga Shadowseeker, DBM-Party-WotLK/AhnKahet/JedogaShadowseeker.lua
  -- [1968] = "Volazj",-- 29311:Herald Volazj, DBM-Party-WotLK/AhnKahet/Volazj.lua
  -- [1969] = "Nadox",-- 29309:Elder Nadox, DBM-Party-WotLK/AhnKahet/Nadox.lua
  -- [1971] = "Krikthir",-- 28684:Krik'thir the Gatewatcher, DBM-Party-WotLK/AzjolNerub/Krikthir.lua
  -- [1972] = "Hadronox",-- 28921:Hadronox, DBM-Party-WotLK/AzjolNerub/Hadronox.lua
  -- [1973] = "Anubarak",-- 29120:Anub'arak, DBM-Party-WotLK/AzjolNerub/Anubarak.lua
  -- [1974] = "Trollgore",-- 26630:Trollgore, DBM-Party-WotLK/DrakTharon/Trollgore.lua
  -- [1975] = "ProphetTharonja",-- 26632:The Prophet Tharon'ja, DBM-Party-WotLK/DrakTharon/ProphetTharonja.lua
  -- [1976] = "NovosTheSummoner",-- 26631:Novos the Summoner, DBM-Party-WotLK/DrakTharon/NovosTheSummoner.lua
  -- [1977] = "KingDred",-- 27483:King Dred, DBM-Party-WotLK/DrakTharon/Dred.lua
  -- [1978] = "Sladran",-- 29304:Slad'ran, DBM-Party-WotLK/Gundrak/Sladran.lua
  -- [1980] = "Moorabi",-- 29305:Moorabi, DBM-Party-WotLK/Gundrak/Moorabi.lua
  -- [1981] = "Galdarah",-- 29306:Gal'darah, DBM-Party-WotLK/Gundrak/Galdarah.lua
  -- [1983] = "BloodstoneAnnihilator",-- 29307:Drakkari Colossus, DBM-Party-WotLK/Gundrak/BloodstoneAnnihilator.lua
  -- [1984] = "Ionar",-- 28546:Ionar, DBM-Party-WotLK/HallsOfLightning/Ionar.lua
  -- [1985] = "Volkhan",-- 28587:Volkhan, DBM-Party-WotLK/HallsOfLightning/Volkhan.lua
  -- [1986] = "Loken",-- 28923:Loken, DBM-Party-WotLK/HallsOfLightning/Loken.lua
  -- [1987] = "Bjarngrin",-- 28586:General Bjarngrim, DBM-Party-WotLK/HallsOfLightning/Bjarngrin.lua
  -- [1988] = "Eck",-- 29932:Eck the Ferocious, DBM-Party-WotLK/Gundrak/Eck.lua
  -- [1989] = "Amanitar",-- 30258:Amanitar, DBM-Party-WotLK/AhnKahet/Amanitar.lua
  -- [1992] = "Falric",-- 38112:Falric, DBM-Party-WotLK/HallsofReflection/Falric.lua
  -- [1993] = "Marwyn",-- 38113:Marwyn, DBM-Party-WotLK/HallsofReflection/Marwyn.lua
  -- [1994] = "Krystallus",-- 27977:Krystallus, DBM-Party-WotLK/HallsOfStone/Krystallus.lua
  -- [1995] = "BrannBronzebeard",-- 28070:Brann Bronzebeard, DBM-Party-WotLK/HallsOfStone/BrannBronzebeard.lua
  -- [1996] = "MaidenOfGrief",-- 27975:Maiden of Grief, DBM-Party-WotLK/HallsOfStone/MaidenOfGrief.lua
  -- [1998] = "SjonnirTheIronshaper",-- 27978:Sjonnir The Ironshaper, DBM-Party-WotLK/HallsOfStone/SjonnirTheIronshaper.lua
  -- [1999] = "ForgemasterGarfrost",-- 36494:Forgemaster Garfrost, DBM-Party-WotLK/PitofSaron/ForgemasterGarfrost.lua
  -- [2000] = "ScourgelordTyrannus",-- 36658:Scourgelord Tyrannus |36661:Rimefang, DBM-Party-WotLK/PitofSaron/ScourgelordTyrannus.lua
  -- [2001] = "Ick",-- 36476:Ick, DBM-Party-WotLK/PitofSaron/Ick.lua
  -- [2002] = "Meathook",-- 26529:Meathook, DBM-Party-WotLK/OldStratholme/Meathook.lua
  -- [2003] = "ChronoLordEpoch",-- 26532:Chrono-Lord Epoch, DBM-Party-WotLK/OldStratholme/ChronoLordEpoch.lua
  -- [2004] = "SalrammTheFleshcrafter",-- 26530:Salramm the Fleshcrafter, DBM-Party-WotLK/OldStratholme/SalrammTheFleshCrafter.lua
  -- [2005] = "MalGanis",-- 26533:Mal'Ganis, DBM-Party-WotLK/OldStratholme/MalGanis.lua
  -- [2006] = "Bronjahm",-- 36497:Bronjahm, DBM-Party-WotLK/ForgeofSouls/Bronjahm.lua
  -- [2007] = "DevourerofSouls",-- 36502:Devourer of Souls, DBM-Party-WotLK/ForgeofSouls/DevourerofSouls.lua
  -- [2009] = "Anomalus",-- 26763:Anomalus, DBM-Party-WotLK/TheNexus/Anomalus.lua
  -- [2010] = "GrandMagusTelestra",-- 26731:Grand Magus Telestra, DBM-Party-WotLK/TheNexus/GrandMagusTelestra.lua
  -- [2011] = "Keristrasza",-- 26723:Keristrasza, DBM-Party-WotLK/TheNexus/Keristrasza.lua
  -- [2012] = "OrmorokTheTreeShaper",-- 26794:Ormorok the Tree-Shaper, DBM-Party-WotLK/TheNexus/OrmorokTheTreeShaper.lua
  -- [2016] = "DrakosTheInterrogator",-- 27654:Drakos the Interrogator, DBM-Party-WotLK/TheOculus/DrakosTheInterrogator.lua
  -- [2020] = "Cyanigosa",-- 31134:Cyanigosa, DBM-Party-WotLK/VioletHold/Cyanigosa.lua
  -- [2021] = "BlackKnight",-- 10000:Arugal |35451:The Black Knight, DBM-Party-WotLK/TrialoftheChampion/Black_Knight.lua
  -- [2022] = "GrandChampions",-- 34657:Jaelyne Evensong |34701:Colosos |34702:Ambrose Boltspark |34703:Lana Stouthammer |34705:Marshal Jacob Alerius |35569:Eressea Dawnsinger |35570:Zul'tore |35571:Runok Wildmane |35572:Mokra the Skullcrusher |35617:Deathstalker Visceri, DBM-Party-WotLK/TrialoftheChampion/Champions.lua
  -- [2023] = "Confessor|EadricthePure",-- 34928:Argent Confessor Paletress |35119:Eadric the Pure, DBM-Party-WotLK/TrialoftheChampion/Confessor.lua | DBM-Party-WotLK/TrialoftheChampion/Eadric_the_Pure.lua
  -- [2024] = "ConstructorAndController",-- 24200:Skarvald the Constructor |24201:Dalronn the Controller, DBM-Party-WotLK/UtgardeKeep/ConstructorAndController.lua
  -- [2025] = "IngvarThePlunderer",-- 23954:Ingvar the Plunderer |23980:Ingvar the Plunderer, DBM-Party-WotLK/UtgardeKeep/IngvarThePlunderer.lua
  -- [2026] = "Keleseth",-- 23953:Prince Keleseth, DBM-Party-WotLK/UtgardeKeep/Keleseth.lua
  -- [2027] = "GortokPalehoof",-- 26687:Gortok Palehoof, DBM-Party-WotLK/UtgardePinnacle/GortokPalehoof.lua
  -- [2028] = "Ymiron",-- 26861:King Ymiron, DBM-Party-WotLK/UtgardePinnacle/Ymiron.lua
  -- [2029] = "SkadiTheRuthless",-- 26693:Skadi the Ruthless, DBM-Party-WotLK/UtgardePinnacle/SkadiTheRuthless.lua
  -- [2030] = "SvalaSorrowgrave",-- 29281:Svala, DBM-Party-WotLK/UtgardePinnacle/SvalaSorrowgrave.lua
  -- [2321] = "LichKingEvent",-- DBM-Party-WotLK/HallsofReflection/LichKingEvent.lua
  [2456] = "Gruul",-- 19044:Gruul the Dragonkiller, DBM-Gruul/Gruul.lua
  -- [2658] = "Erekem",-- 29315:Erekem, DBM-Party-WotLK/VioletHold/Erekem.lua
  -- [2659] = "Moragg",-- 29316:Moragg, DBM-Party-WotLK/VioletHold/Moragg.lua
  -- [2660] = "Ichoron",-- 29313:Ichoron, DBM-Party-WotLK/VioletHold/Ichoron.lua
  -- [2661] = "Xevoss",-- 29266:Xevozz, DBM-Party-WotLK/VioletHold/Xevoss.lua
  -- [2662] = "Lavanthor",-- 29312:Lavanthor, DBM-Party-WotLK/VioletHold/Lavanthor.lua
  -- [2663] = "Zuramat",-- 29314:Zuramat the Obliterator, DBM-Party-WotLK/VioletHold/Zuramat.lua
  [2725] = "HeadlessHorseman",-- 23682:Headless Horseman |23775:Head of the Horseman, DBM-WorldEvents/Holidays/HeadlessHorseman.lua
  [2761] = "GhamooRa",-- 4887:Ghamoo-Ra, DBM-Party-Classic/BlackfathomDeeps/GhamooRa.lua
  [2762] = "LadySerevess",-- 4831:Lady Sarevess, DBM-Party-Classic/BlackfathomDeeps/LadySerevess.lua
  [2763] = "Gelihast",-- 6243:Gelihast, DBM-Party-Classic/BlackfathomDeeps/Gelihast.lua
  [2765] = "OldSerrakis",-- 4830:Old Serra'kis, DBM-Party-Classic/BlackfathomDeeps/OldSerrakis.lua
  [2766] = "TwilightLordKelris",-- 4832:Twilight Lord Kelris, DBM-Party-Classic/BlackfathomDeeps/TwilightLordKelris.lua
  [2767] = "Akumai",-- 4829:Aku'mai, DBM-Party-Classic/BlackfathomDeeps/Akumai.lua
  [2818] = "BloodmageThalnos",-- 4543:Bloodmage Thalnos, DBM-Party-Classic/ScarletMonastery/BloodmageThalnos.lua
  [2879] = "ApothecaryTrio",-- 36272:Apothecary Frye |36296:Apothecary Hummel |36565:Apothecary Baxter, DBM-WorldEvents/Holidays/ApothecaryTrio.lua
  [2967] = "RhahkZor",-- 644:Rhahk'Zor, DBM-Party-Classic/Deadmines/RhahkZor.lua
  [2968] = "SneedsShredder",-- 642:Sneed's Shredder |643:Sneed, DBM-Party-Classic/Deadmines/SneedsShredder.lua
  [2969] = "Gilnid",-- 1763:Gilnid, DBM-Party-Classic/Deadmines/Gilnid.lua
  [2970] = "MrSmite",-- 646:Mr. Smite, DBM-Party-Classic/Deadmines/MrSmite.lua
  [2971] = "CaptainGreenskin",-- 647:Captain Greenskin, DBM-Party-Classic/Deadmines/CaptainGreenskin.lua
  [2972] = "EdwinVanCleef",-- 639:Edwin VanCleef, DBM-Party-Classic/Deadmines/EdwinVanCleef.lua
  [2986] = "Cookie",-- 645:Cookie, DBM-Party-Classic/Deadmines/Cookie.lua
  -- fictional encounterIds
  [3000] = "AQ20Trash",-- DBM-AQ20/AQ20Trash.lua
  [3001] = "AQ40Trash",-- DBM-AQ40/AQ40Trash.lua
  [3002] = "MCTrash",-- DBM-MC/MCTrash.lua
  [3003] = "AuctTombsTrash",-- DBM-Party-BC/Auct_Tombs/AuctTombsTrash.lua
  -- [3004] = "Freya_Elders",-- 32913:Elder Ironbranch |32914:Elder Stonebark |32915:Elder Brightleaf, DBM-Ulduar/Freya_Elders.lua
  -- [3005] = "ICCTrash",-- DBM-Icecrown/Trash.lua
  -- [3010] = "HoRWaveTimer",-- 30658:Lieutenant Sinclari, DBM-Party-WotLK/HallsofReflection/WaveTimers.lua
  -- [3011] = "StratWaves",-- DBM-Party-WotLK/OldStratholme/OldStratholmeWaves.lua
  [3012] = "HyjalWaveTimers",-- DBM-Hyjal/WaveTimers.lua
  -- [3013] = "PortalTimers",-- 30658:Lieutenant Sinclari, DBM-Party-WotLK/VioletHold/PortalTimers.lua
  [3017] = "Ahune",-- 25740:Ahune, DBM-WorldEvents/Holidays/Ahune.lua
  [3018] = "CorenDirebrew",-- 23872:Coren Direbrew, DBM-WorldEvents/Holidays/CorenDirebrew.lua
  [3020] = "Azuregos",-- 6109:Azuregos, DBM-Azeroth/Azuregos.lua
  [3022] = "Emeriss",-- 14889:Emeriss, DBM-Azeroth/Emeriss.lua
  [3023] = "Lethon",-- 14888:Lethon, DBM-Azeroth/Lethon.lua
  [3024] = "Taerar",-- 14890:Taerar, DBM-Azeroth/Taerar.lua
  [3025] = "Ysondre",-- 14887:Ysondre, DBM-Azeroth/Ysondre.lua
  [3026] = "Doomwalker",-- 17711:Doomwalker, DBM-Outland/Doomwalker.lua
  [3030] = "PT",-- DBM-Party-BC/CoT_BlackMorass/PortalTimers.lua
  [3031] = "Quest",-- DBM-Outland/Quest.lua
  [3032] = "TalonGuards",-- 12460:Death Talon Wyrmguard |12461:Death Talon Overseer |99999:Lord Solanar Bloodwrath, DBM-BWL/TalonGuards.lua
  [3040] = "BazilThredd",-- 1716:Bazil Thredd, DBM-Party-Classic/StormwindStockaid/BazilThredd.lua
  [3041] = "BruegalIronknuckle",-- 1720:Bruegal Ironknuckle, DBM-Party-Classic/StormwindStockaid/BruegalIronknuckle.lua
  [3042] = "DextrenWard",-- 1663:Dextren Ward, DBM-Party-Classic/StormwindStockaid/DextrenWard.lua
  [3043] = "Hamhock",-- 1717:Hamhock, DBM-Party-Classic/StormwindStockaid/Hamhock.lua
  [3044] = "KamDeepfury",-- 1666:Kam Deepfury, DBM-Party-Classic/StormwindStockaid/KamDeepfury.lua
  [3045] = "Targorr",-- 1696:Targorr the Dread, DBM-Party-Classic/StormwindStockaid/Targorr.lua
  [3046] = "GoralukAnvilcrack",-- 10899:Goraluk Anvilcrack, DBM-Party-Classic/UpperBlackrockSpire/GoralukAnvilcrack.lua
  [3047] = "JedRunewatcher",-- 10509:Jed Runewatcher, DBM-Party-Classic/UpperBlackrockSpire/JedRunewatcher.lua
  [3048] = "DeathswornCaptain",-- 3872:Deathsworn Captain, DBM-Party-Classic/Shadowfangkeep/DeathswornCaptain.lua
  [3049] = "DeviateFaerie",-- 5912:Deviate Faerie Dragon, DBM-Party-Classic/WailingCaverns/DeviateFaerieDragon.lua
  [3050] = "Shadikith|Hyakiss|Rokad"
}

Private.talentInfo = {
  ["HUNTER"] = {
    {
      "Interface\\Icons\\Spell_Nature_RavenForm", -- [1]
      1, -- [2]
      2, -- [3]
      19552, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\Spell_Nature_Reincarnation", -- [1]
      1, -- [2]
      3, -- [3]
      19583, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\Ability_Hunter_SilentHunter", -- [1]
      2, -- [2]
      1, -- [3]
      35029, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Ability_Hunter_AspectOfTheMonkey", -- [1]
      2, -- [2]
      2, -- [3]
      19549, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\INV_Misc_Pelt_Bear_03", -- [1]
      2, -- [2]
      3, -- [3]
      19609, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\Ability_Hunter_BeastSoothe", -- [1]
      2, -- [2]
      4, -- [3]
      24443, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Ability_Mount_JungleTiger", -- [1]
      3, -- [2]
      1, -- [3]
      19559, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Ability_Druid_Dash", -- [1]
      3, -- [2]
      2, -- [3]
      19596, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\Ability_BullRush", -- [1]
      3, -- [2]
      3, -- [3]
      19616, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Ability_Hunter_MendPet", -- [1]
      4, -- [2]
      2, -- [3]
      19572, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\INV_Misc_MonsterClaw_04", -- [1]
      4, -- [2]
      3, -- [3]
      19598, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\Ability_Druid_DemoralizingRoar", -- [1]
      5, -- [2]
      1, -- [3]
      19578, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Ability_Devour", -- [1]
      5, -- [2]
      2, -- [3]
      19577, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Spell_Nature_AbolishMagic", -- [1]
      5, -- [2]
      4, -- [3]
      19590, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\Ability_Hunter_AnimalHandler", -- [1]
      6, -- [2]
      1, -- [3]
      34453, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\INV_Misc_MonsterClaw_03", -- [1]
      6, -- [2]
      3, -- [3]
      19621, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Ability_Hunter_FerociousInspiration", -- [1]
      7, -- [2]
      1, -- [3]
      34455, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Ability_Druid_FerociousBite", -- [1]
      7, -- [2]
      2, -- [3]
      19574, -- [4]
    }, -- [18]
    {
      "Interface\\Icons\\Ability_Hunter_CatlikeReflexes", -- [1]
      7, -- [2]
      3, -- [3]
      34462, -- [4]
    }, -- [19]
    {
      "Interface\\Icons\\Ability_Hunter_SerpentSwiftness", -- [1]
      8, -- [2]
      3, -- [3]
      34466, -- [4]
    }, -- [20]
    {
      "Interface\\Icons\\Ability_Hunter_BeastWithin", -- [1]
      9, -- [2]
      2, -- [3]
      34692, -- [4]
    }, -- [21]
    nil, -- [22]
    nil, -- [23]
    nil, -- [24]
    nil, -- [25]
    nil, -- [26]
    nil, -- [27]
    nil, -- [28]
    nil, -- [29]
    nil, -- [30]
    nil, -- [31]
    nil, -- [32]
    nil, -- [33]
    nil, -- [34]
    nil, -- [35]
    nil, -- [36]
    nil, -- [37]
    nil, -- [38]
    nil, -- [39]
    nil, -- [40]
    {
      "Interface\\Icons\\Spell_Frost_Stun", -- [1]
      1, -- [2]
      2, -- [3]
      19407, -- [4]
    }, -- [41]
    {
      "Interface\\Icons\\Ability_SearingArrow", -- [1]
      1, -- [2]
      3, -- [3]
      19426, -- [4]
    }, -- [42]
    {
      "Interface\\Icons\\Ability_Hunter_SniperShot", -- [1]
      2, -- [2]
      2, -- [3]
      19421, -- [4]
    }, -- [43]
    {
      "Interface\\Icons\\Spell_Frost_WizardMark", -- [1]
      2, -- [2]
      3, -- [3]
      19416, -- [4]
    }, -- [44]
    {
      "Interface\\Icons\\Ability_Hunter_GoForTheThroat", -- [1]
      3, -- [2]
      1, -- [3]
      34950, -- [4]
    }, -- [45]
    {
      "Interface\\Icons\\Ability_ImpalingBolt", -- [1]
      3, -- [2]
      2, -- [3]
      19454, -- [4]
    }, -- [46]
    {
      "Interface\\Icons\\INV_Spear_07", -- [1]
      3, -- [2]
      3, -- [3]
      19434, -- [4]
    }, -- [47]
    {
      "Interface\\Icons\\Ability_Hunter_RapidKilling", -- [1]
      3, -- [2]
      4, -- [3]
      34948, -- [4]
    }, -- [48]
    {
      "Interface\\Icons\\Ability_Hunter_Quickshot", -- [1]
      4, -- [2]
      2, -- [3]
      19464, -- [4]
    }, -- [49]
    {
      "Interface\\Icons\\Ability_PierceDamage", -- [1]
      4, -- [2]
      3, -- [3]
      19485, -- [4]
    }, -- [50]
    {
      "Interface\\Icons\\Spell_Arcane_StarFire", -- [1]
      5, -- [2]
      1, -- [3]
      35100, -- [4]
    }, -- [51]
    {
      "Interface\\Icons\\Ability_GolemStormBolt", -- [1]
      5, -- [2]
      2, -- [3]
      19503, -- [4]
    }, -- [52]
    {
      "Interface\\Icons\\Ability_UpgradeMoonGlaive", -- [1]
      5, -- [2]
      3, -- [3]
      19461, -- [4]
    }, -- [53]
    {
      "Interface\\Icons\\Ability_Hunter_CombatExperience", -- [1]
      6, -- [2]
      1, -- [3]
      34475, -- [4]
    }, -- [54]
    {
      "Interface\\Icons\\INV_Weapon_Rifle_06", -- [1]
      6, -- [2]
      4, -- [3]
      19507, -- [4]
    }, -- [55]
    {
      "Interface\\Icons\\Ability_Hunter_ZenArchery", -- [1]
      7, -- [2]
      1, -- [3]
      34482, -- [4]
    }, -- [56]
    {
      "Interface\\Icons\\Ability_TrueShot", -- [1]
      7, -- [2]
      2, -- [3]
      19506, -- [4]
    }, -- [57]
    {
      "Interface\\Icons\\Ability_UpgradeMoonGlaive", -- [1]
      7, -- [2]
      3, -- [3]
      35104, -- [4]
    }, -- [58]
    {
      "Interface\\Icons\\Ability_Hunter_MasterMarksman", -- [1]
      8, -- [2]
      2, -- [3]
      34485, -- [4]
    }, -- [59]
    {
      "Interface\\Icons\\Ability_TheBlackArrow", -- [1]
      9, -- [2]
      2, -- [3]
      34490, -- [4]
    }, -- [60]
    nil, -- [61]
    nil, -- [62]
    nil, -- [63]
    nil, -- [64]
    nil, -- [65]
    nil, -- [66]
    nil, -- [67]
    nil, -- [68]
    nil, -- [69]
    nil, -- [70]
    nil, -- [71]
    nil, -- [72]
    nil, -- [73]
    nil, -- [74]
    nil, -- [75]
    nil, -- [76]
    nil, -- [77]
    nil, -- [78]
    nil, -- [79]
    nil, -- [80]
    {
      "Interface\\Icons\\INV_Misc_Head_Dragon_Black", -- [1]
      1, -- [2]
      1, -- [3]
      24293, -- [4]
    }, -- [81]
    {
      "Interface\\Icons\\Spell_Holy_PrayerOfHealing", -- [1]
      1, -- [2]
      2, -- [3]
      19151, -- [4]
    }, -- [82]
    {
      "Interface\\Icons\\Ability_TownWatch", -- [1]
      1, -- [2]
      3, -- [3]
      19498, -- [4]
    }, -- [83]
    {
      "Interface\\Icons\\Ability_Racial_BloodRage", -- [1]
      1, -- [2]
      4, -- [3]
      19159, -- [4]
    }, -- [84]
    {
      "Interface\\Icons\\Spell_Nature_StrangleVines", -- [1]
      2, -- [2]
      1, -- [3]
      19184, -- [4]
    }, -- [85]
    {
      "Interface\\Icons\\Ability_Parry", -- [1]
      2, -- [2]
      2, -- [3]
      19295, -- [4]
    }, -- [86]
    {
      "Interface\\Icons\\Ability_Rogue_Trip", -- [1]
      2, -- [2]
      3, -- [3]
      19228, -- [4]
    }, -- [87]
    {
      "Interface\\Icons\\Spell_Nature_TimeStop", -- [1]
      3, -- [2]
      1, -- [3]
      19239, -- [4]
    }, -- [88]
    {
      "Interface\\Icons\\Spell_Shadow_Twilight", -- [1]
      3, -- [2]
      2, -- [3]
      19255, -- [4]
    }, -- [89]
    {
      "Interface\\Icons\\Ability_Whirlwind", -- [1]
      3, -- [2]
      3, -- [3]
      19263, -- [4]
    }, -- [90]
    {
      "Interface\\Icons\\Ability_Ensnare", -- [1]
      4, -- [2]
      1, -- [3]
      19376, -- [4]
    }, -- [91]
    {
      "Interface\\Icons\\Ability_Kick", -- [1]
      4, -- [2]
      2, -- [3]
      19290, -- [4]
    }, -- [92]
    {
      "Interface\\Icons\\Ability_Rogue_FeignDeath", -- [1]
      4, -- [2]
      4, -- [3]
      19286, -- [4]
    }, -- [93]
    {
      "Interface\\Icons\\Ability_Hunter_SurvivalInstincts", -- [1]
      5, -- [2]
      1, -- [3]
      34494, -- [4]
    }, -- [94]
    {
      "Interface\\Icons\\Spell_Holy_BlessingOfStamina", -- [1]
      5, -- [2]
      2, -- [3]
      19370, -- [4]
    }, -- [95]
    {
      "Interface\\Icons\\Ability_Warrior_Challange", -- [1]
      5, -- [2]
      3, -- [3]
      19306, -- [4]
    }, -- [96]
    {
      "Interface\\Icons\\Ability_Hunter_Resourcefulness", -- [1]
      6, -- [2]
      1, -- [3]
      34491, -- [4]
    }, -- [97]
    {
      "Interface\\Icons\\Spell_Nature_Invisibilty", -- [1]
      6, -- [2]
      3, -- [3]
      19168, -- [4]
    }, -- [98]
    {
      "Interface\\Icons\\Ability_Hunter_ThrilloftheHunt", -- [1]
      7, -- [2]
      1, -- [3]
      34497, -- [4]
    }, -- [99]
    {
      "Interface\\Icons\\INV_Spear_02", -- [1]
      7, -- [2]
      2, -- [3]
      19386, -- [4]
    }, -- [100]
    {
      "Interface\\Icons\\Ability_Rogue_FindWeakness", -- [1]
      7, -- [2]
      3, -- [3]
      34500, -- [4]
    }, -- [101]
    {
      "Interface\\Icons\\Ability_Hunter_MasterTactitian", -- [1]
      8, -- [2]
      2, -- [3]
      34506, -- [4]
    }, -- [102]
    {
      "Interface\\Icons\\Ability_Hunter_Readiness", -- [1]
      9, -- [2]
      2, -- [3]
      23989, -- [4]
    }, -- [103]
    nil, -- [104]
    nil, -- [105]
    nil, -- [106]
    nil, -- [107]
    nil, -- [108]
    nil, -- [109]
    nil, -- [110]
    nil, -- [111]
    nil, -- [112]
    nil, -- [113]
    nil, -- [114]
    nil, -- [115]
    nil, -- [116]
    nil, -- [117]
    nil, -- [118]
    nil, -- [119]
    nil, -- [120]
    {
      "HunterBeastMastery", -- [1]
      "HunterMarksmanship", -- [2]
      "HunterSurvival", -- [3]
    }, -- [121]
  },
  ["WARRIOR"] = {
    {
      "Interface\\Icons\\Ability_Rogue_Ambush", -- [1]
      1, -- [2]
      1, -- [3]
      12282, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\Ability_Parry", -- [1]
      1, -- [2]
      2, -- [3]
      16462, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\Ability_Gouge", -- [1]
      1, -- [2]
      3, -- [3]
      12286, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Ability_Warrior_Charge", -- [1]
      2, -- [2]
      1, -- [3]
      12285, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\Spell_Magic_MageArmor", -- [1]
      2, -- [2]
      2, -- [3]
      12300, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\Ability_ThunderClap", -- [1]
      2, -- [2]
      3, -- [3]
      12287, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\INV_Sword_05", -- [1]
      3, -- [2]
      1, -- [3]
      12290, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Spell_Holy_BlessingOfStamina", -- [1]
      3, -- [2]
      2, -- [3]
      12296, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\Ability_BackStab", -- [1]
      3, -- [2]
      3, -- [3]
      12834, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\INV_Axe_09", -- [1]
      4, -- [2]
      2, -- [3]
      12163, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\Ability_SearingArrow", -- [1]
      4, -- [2]
      3, -- [3]
      16493, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\INV_Axe_06", -- [1]
      5, -- [2]
      1, -- [3]
      12700, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Spell_Shadow_DeathPact", -- [1]
      5, -- [2]
      2, -- [3]
      12292, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\INV_Mace_01", -- [1]
      5, -- [2]
      3, -- [3]
      12284, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\INV_Sword_27", -- [1]
      5, -- [2]
      4, -- [3]
      12281, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\Ability_Rogue_Sprint", -- [1]
      6, -- [2]
      1, -- [3]
      29888, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Ability_ShockWave", -- [1]
      6, -- [2]
      3, -- [3]
      12289, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Ability_Warrior_ImprovedDisciplines", -- [1]
      6, -- [2]
      4, -- [3]
      29723, -- [4]
    }, -- [18]
    {
      "Interface\\Icons\\Ability_Warrior_BloodFrenzy", -- [1]
      7, -- [2]
      1, -- [3]
      29836, -- [4]
    }, -- [19]
    {
      "Interface\\Icons\\Ability_Warrior_SavageBlow", -- [1]
      7, -- [2]
      2, -- [3]
      12294, -- [4]
    }, -- [20]
    {
      "Interface\\Icons\\Ability_Hunter_Harass", -- [1]
      7, -- [2]
      3, -- [3]
      29834, -- [4]
    }, -- [21]
    {
      "Interface\\Icons\\Ability_Warrior_SavageBlow", -- [1]
      8, -- [2]
      2, -- [3]
      35446, -- [4]
    }, -- [22]
    {
      "Interface\\Icons\\Ability_Warrior_EndlessRage", -- [1]
      9, -- [2]
      2, -- [3]
      29623, -- [4]
    }, -- [23]
    nil, -- [24]
    nil, -- [25]
    nil, -- [26]
    nil, -- [27]
    nil, -- [28]
    nil, -- [29]
    nil, -- [30]
    nil, -- [31]
    nil, -- [32]
    nil, -- [33]
    nil, -- [34]
    nil, -- [35]
    nil, -- [36]
    nil, -- [37]
    nil, -- [38]
    nil, -- [39]
    nil, -- [40]
    {
      "Interface\\Icons\\Spell_Nature_Purge", -- [1]
      1, -- [2]
      2, -- [3]
      12321, -- [4]
    }, -- [41]
    {
      "Interface\\Icons\\Ability_Rogue_Eviscerate", -- [1]
      1, -- [2]
      3, -- [3]
      12320, -- [4]
    }, -- [42]
    {
      "Interface\\Icons\\Ability_Warrior_WarCry", -- [1]
      2, -- [2]
      2, -- [3]
      12324, -- [4]
    }, -- [43]
    {
      "Interface\\Icons\\Spell_Nature_StoneClawTotem", -- [1]
      2, -- [2]
      3, -- [3]
      12322, -- [4]
    }, -- [44]
    {
      "Interface\\Icons\\Ability_Warrior_Cleave", -- [1]
      3, -- [2]
      1, -- [3]
      12329, -- [4]
    }, -- [45]
    {
      "Interface\\Icons\\Spell_Shadow_DeathScream", -- [1]
      3, -- [2]
      2, -- [3]
      12323, -- [4]
    }, -- [46]
    {
      "Interface\\Icons\\Spell_Shadow_SummonImp", -- [1]
      3, -- [2]
      3, -- [3]
      16487, -- [4]
    }, -- [47]
    {
      "Interface\\Icons\\Spell_Nature_FocusedMind", -- [1]
      3, -- [2]
      4, -- [3]
      12318, -- [4]
    }, -- [48]
    {
      "Interface\\Icons\\Ability_DualWield", -- [1]
      4, -- [2]
      1, -- [3]
      23584, -- [4]
    }, -- [49]
    {
      "Interface\\Icons\\INV_Sword_48", -- [1]
      4, -- [2]
      2, -- [3]
      20502, -- [4]
    }, -- [50]
    {
      "Interface\\Icons\\Spell_Shadow_UnholyFrenzy", -- [1]
      4, -- [2]
      3, -- [3]
      12317, -- [4]
    }, -- [51]
    {
      "Interface\\Icons\\Ability_Warrior_DecisiveStrike", -- [1]
      5, -- [2]
      1, -- [3]
      12862, -- [4]
    }, -- [52]
    {
      "Interface\\Icons\\Ability_Rogue_SliceDice", -- [1]
      5, -- [2]
      2, -- [3]
      12328, -- [4]
    }, -- [53]
    {
      "Interface\\Icons\\Ability_Warrior_WeaponMastery", -- [1]
      5, -- [2]
      4, -- [3]
      20504, -- [4]
    }, -- [54]
    {
      "Interface\\Icons\\Spell_Nature_AncestralGuardian", -- [1]
      6, -- [2]
      1, -- [3]
      20500, -- [4]
    }, -- [55]
    {
      "Interface\\Icons\\Ability_GhoulFrenzy", -- [1]
      6, -- [2]
      3, -- [3]
      12319, -- [4]
    }, -- [56]
    {
      "Interface\\Icons\\Ability_Marksmanship", -- [1]
      7, -- [2]
      1, -- [3]
      29590, -- [4]
    }, -- [57]
    {
      "Interface\\Icons\\Spell_Nature_BloodLust", -- [1]
      7, -- [2]
      2, -- [3]
      23881, -- [4]
    }, -- [58]
    {
      "Interface\\Icons\\Ability_Whirlwind", -- [1]
      7, -- [2]
      3, -- [3]
      29721, -- [4]
    }, -- [59]
    {
      "Interface\\Icons\\Ability_Racial_Avatar", -- [1]
      8, -- [2]
      3, -- [3]
      29759, -- [4]
    }, -- [60]
    {
      "Interface\\Icons\\Ability_Warrior_Rampage", -- [1]
      9, -- [2]
      2, -- [3]
      29801, -- [4]
    }, -- [61]
    nil, -- [62]
    nil, -- [63]
    nil, -- [64]
    nil, -- [65]
    nil, -- [66]
    nil, -- [67]
    nil, -- [68]
    nil, -- [69]
    nil, -- [70]
    nil, -- [71]
    nil, -- [72]
    nil, -- [73]
    nil, -- [74]
    nil, -- [75]
    nil, -- [76]
    nil, -- [77]
    nil, -- [78]
    nil, -- [79]
    nil, -- [80]
    {
      "Interface\\Icons\\Ability_Racial_BloodRage", -- [1]
      1, -- [2]
      1, -- [3]
      12301, -- [4]
    }, -- [81]
    {
      "Interface\\Icons\\Spell_Nature_EnchantArmor", -- [1]
      1, -- [2]
      2, -- [3]
      12295, -- [4]
    }, -- [82]
    {
      "Interface\\Icons\\Spell_Nature_MirrorImage", -- [1]
      1, -- [2]
      3, -- [3]
      12297, -- [4]
    }, -- [83]
    {
      "Interface\\Icons\\INV_Shield_06", -- [1]
      2, -- [2]
      2, -- [3]
      12298, -- [4]
    }, -- [84]
    {
      "Interface\\Icons\\Spell_Holy_Devotion", -- [1]
      2, -- [2]
      3, -- [3]
      12299, -- [4]
    }, -- [85]
    {
      "Interface\\Icons\\Spell_Holy_AshesToAshes", -- [1]
      3, -- [2]
      1, -- [3]
      12975, -- [4]
    }, -- [86]
    {
      "Interface\\Icons\\Ability_Defend", -- [1]
      3, -- [2]
      2, -- [3]
      12945, -- [4]
    }, -- [87]
    {
      "Interface\\Icons\\Ability_Warrior_Revenge", -- [1]
      3, -- [2]
      3, -- [3]
      12797, -- [4]
    }, -- [88]
    {
      "Interface\\Icons\\Ability_Warrior_InnerRage", -- [1]
      3, -- [2]
      4, -- [3]
      12303, -- [4]
    }, -- [89]
    {
      "Interface\\Icons\\Ability_Warrior_Sunder", -- [1]
      4, -- [2]
      1, -- [3]
      12308, -- [4]
    }, -- [90]
    {
      "Interface\\Icons\\Ability_Warrior_Disarm", -- [1]
      4, -- [2]
      2, -- [3]
      12313, -- [4]
    }, -- [91]
    {
      "Interface\\Icons\\Spell_Nature_Reincarnation", -- [1]
      4, -- [2]
      3, -- [3]
      12302, -- [4]
    }, -- [92]
    {
      "Interface\\Icons\\Ability_Warrior_ShieldWall", -- [1]
      5, -- [2]
      1, -- [3]
      12312, -- [4]
    }, -- [93]
    {
      "Interface\\Icons\\Ability_ThunderBolt", -- [1]
      5, -- [2]
      2, -- [3]
      12809, -- [4]
    }, -- [94]
    {
      "Interface\\Icons\\Ability_Warrior_ShieldBash", -- [1]
      5, -- [2]
      3, -- [3]
      12311, -- [4]
    }, -- [95]
    {
      "Interface\\Icons\\Ability_Warrior_ShieldMastery", -- [1]
      6, -- [2]
      1, -- [3]
      29598, -- [4]
    }, -- [96]
    {
      "Interface\\Icons\\INV_Sword_20", -- [1]
      6, -- [2]
      3, -- [3]
      16538, -- [4]
    }, -- [97]
    {
      "Interface\\Icons\\Ability_Warrior_DefensiveStance", -- [1]
      7, -- [2]
      1, -- [3]
      29593, -- [4]
    }, -- [98]
    {
      "Interface\\Icons\\INV_Shield_05", -- [1]
      7, -- [2]
      2, -- [3]
      23922, -- [4]
    }, -- [99]
    {
      "Interface\\Icons\\Ability_Warrior_FocusedRage", -- [1]
      7, -- [2]
      3, -- [3]
      29787, -- [4]
    }, -- [100]
    {
      "Interface\\Icons\\INV_Helmet_21", -- [1]
      8, -- [2]
      2, -- [3]
      29140, -- [4]
    }, -- [101]
    {
      "Interface\\Icons\\INV_Sword_11", -- [1]
      9, -- [2]
      2, -- [3]
      20243, -- [4]
    }, -- [102]
    nil, -- [103]
    nil, -- [104]
    nil, -- [105]
    nil, -- [106]
    nil, -- [107]
    nil, -- [108]
    nil, -- [109]
    nil, -- [110]
    nil, -- [111]
    nil, -- [112]
    nil, -- [113]
    nil, -- [114]
    nil, -- [115]
    nil, -- [116]
    nil, -- [117]
    nil, -- [118]
    nil, -- [119]
    nil, -- [120]
    {
      "WarriorArms", -- [1]
      "WarriorFury", -- [2]
      "WarriorProtection", -- [3]
    }, -- [121]
  },
  ["SHAMAN"] = {
    {
      "Interface\\Icons\\Spell_Nature_WispSplode", -- [1]
      1, -- [2]
      2, -- [3]
      16039, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\Spell_Fire_Fireball", -- [1]
      1, -- [2]
      3, -- [3]
      16035, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\Spell_Nature_StoneClawTotem", -- [1]
      2, -- [2]
      1, -- [3]
      16043, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Spell_Nature_SpiritArmor", -- [1]
      2, -- [2]
      2, -- [3]
      28996, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\Spell_Fire_Immolation", -- [1]
      2, -- [2]
      3, -- [3]
      16038, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\Spell_Shadow_ManaBurn", -- [1]
      3, -- [2]
      1, -- [3]
      16164, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Spell_Frost_FrostWard", -- [1]
      3, -- [2]
      2, -- [3]
      16040, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Spell_Nature_CallStorm", -- [1]
      3, -- [2]
      3, -- [3]
      16041, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\Spell_Fire_SealOfFire", -- [1]
      4, -- [2]
      1, -- [3]
      16086, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Spell_Shadow_SoulLeech_2", -- [1]
      4, -- [2]
      2, -- [3]
      29062, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\Spell_Fire_ElementalDevastation", -- [1]
      4, -- [2]
      4, -- [3]
      30160, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\Spell_Nature_StormReach", -- [1]
      5, -- [2]
      1, -- [3]
      28999, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Spell_Fire_Volcano", -- [1]
      5, -- [2]
      2, -- [3]
      16089, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Spell_Nature_UnrelentingStorm", -- [1]
      5, -- [2]
      4, -- [3]
      30664, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\Spell_Nature_ElementalPrecision_1", -- [1]
      6, -- [2]
      1, -- [3]
      30672, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\Spell_Lightning_LightningBolt01", -- [1]
      6, -- [2]
      3, -- [3]
      16578, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Spell_Nature_WispHeal", -- [1]
      7, -- [2]
      2, -- [3]
      16166, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Spell_Nature_ElementalShields", -- [1]
      7, -- [2]
      3, -- [3]
      30669, -- [4]
    }, -- [18]
    {
      "Interface\\Icons\\Spell_Nature_LightningOverload", -- [1]
      8, -- [2]
      2, -- [3]
      30675, -- [4]
    }, -- [19]
    {
      "Interface\\Icons\\Spell_Fire_TotemOfWrath", -- [1]
      9, -- [2]
      2, -- [3]
      30706, -- [4]
    }, -- [20]
    nil, -- [21]
    nil, -- [22]
    nil, -- [23]
    nil, -- [24]
    nil, -- [25]
    nil, -- [26]
    nil, -- [27]
    nil, -- [28]
    nil, -- [29]
    nil, -- [30]
    nil, -- [31]
    nil, -- [32]
    nil, -- [33]
    nil, -- [34]
    nil, -- [35]
    nil, -- [36]
    nil, -- [37]
    nil, -- [38]
    nil, -- [39]
    nil, -- [40]
    {
      "Interface\\Icons\\Spell_Shadow_GrimWard", -- [1]
      1, -- [2]
      2, -- [3]
      17485, -- [4]
    }, -- [41]
    {
      "Interface\\Icons\\INV_Shield_06", -- [1]
      1, -- [2]
      3, -- [3]
      16253, -- [4]
    }, -- [42]
    {
      "Interface\\Icons\\Spell_Nature_StoneSkinTotem", -- [1]
      2, -- [2]
      1, -- [3]
      16258, -- [4]
    }, -- [43]
    {
      "Interface\\Icons\\Ability_ThunderBolt", -- [1]
      2, -- [2]
      2, -- [3]
      16255, -- [4]
    }, -- [44]
    {
      "Interface\\Icons\\Spell_Nature_SpiritWolf", -- [1]
      2, -- [2]
      3, -- [3]
      16262, -- [4]
    }, -- [45]
    {
      "Interface\\Icons\\Spell_Nature_LightningShield", -- [1]
      2, -- [2]
      4, -- [3]
      16261, -- [4]
    }, -- [46]
    {
      "Interface\\Icons\\Spell_Nature_EarthBindTotem", -- [1]
      3, -- [2]
      1, -- [3]
      16259, -- [4]
    }, -- [47]
    {
      "Interface\\Icons\\Spell_Nature_ElementalAbsorption", -- [1]
      3, -- [2]
      3, -- [3]
      43338, -- [4]
    }, -- [48]
    {
      "Interface\\Icons\\Spell_Nature_MirrorImage", -- [1]
      3, -- [2]
      4, -- [3]
      16254, -- [4]
    }, -- [49]
    {
      "Interface\\Icons\\Ability_GhoulFrenzy", -- [1]
      4, -- [2]
      2, -- [3]
      16256, -- [4]
    }, -- [50]
    {
      "Interface\\Icons\\Spell_Holy_Devotion", -- [1]
      4, -- [2]
      3, -- [3]
      16252, -- [4]
    }, -- [51]
    {
      "Interface\\Icons\\Spell_Fire_EnchantWeapon", -- [1]
      5, -- [2]
      1, -- [3]
      29192, -- [4]
    }, -- [52]
    {
      "Interface\\Icons\\Ability_Parry", -- [1]
      5, -- [2]
      2, -- [3]
      16268, -- [4]
    }, -- [53]
    {
      "Interface\\Icons\\Spell_Fire_FlameTounge", -- [1]
      5, -- [2]
      3, -- [3]
      16266, -- [4]
    }, -- [54]
    {
      "Interface\\Icons\\Spell_Nature_MentalQuickness", -- [1]
      6, -- [2]
      1, -- [3]
      30812, -- [4]
    }, -- [55]
    {
      "Interface\\Icons\\Ability_Hunter_SwiftStrike", -- [1]
      6, -- [2]
      4, -- [3]
      29082, -- [4]
    }, -- [56]
    {
      "Interface\\Icons\\Ability_DualWieldSpecialization", -- [1]
      7, -- [2]
      1, -- [3]
      30816, -- [4]
    }, -- [57]
    {
      "Interface\\Icons\\Ability_DualWield", -- [1]
      7, -- [2]
      2, -- [3]
      30798, -- [4]
    }, -- [58]
    {
      "Interface\\Icons\\Ability_Shaman_Stormstrike", -- [1]
      7, -- [2]
      3, -- [3]
      17364, -- [4]
    }, -- [59]
    {
      "Interface\\Icons\\Spell_Nature_UnleashedRage", -- [1]
      8, -- [2]
      2, -- [3]
      30802, -- [4]
    }, -- [60]
    {
      "Interface\\Icons\\Spell_Nature_ShamanRage", -- [1]
      9, -- [2]
      2, -- [3]
      30823, -- [4]
    }, -- [61]
    nil, -- [62]
    nil, -- [63]
    nil, -- [64]
    nil, -- [65]
    nil, -- [66]
    nil, -- [67]
    nil, -- [68]
    nil, -- [69]
    nil, -- [70]
    nil, -- [71]
    nil, -- [72]
    nil, -- [73]
    nil, -- [74]
    nil, -- [75]
    nil, -- [76]
    nil, -- [77]
    nil, -- [78]
    nil, -- [79]
    nil, -- [80]
    {
      "Interface\\Icons\\Spell_Nature_MagicImmunity", -- [1]
      1, -- [2]
      2, -- [3]
      16182, -- [4]
    }, -- [81]
    {
      "Interface\\Icons\\Spell_Frost_ManaRecharge", -- [1]
      1, -- [2]
      3, -- [3]
      16179, -- [4]
    }, -- [82]
    {
      "Interface\\Icons\\Spell_Nature_Reincarnation", -- [1]
      2, -- [2]
      1, -- [3]
      16184, -- [4]
    }, -- [83]
    {
      "Interface\\Icons\\Spell_Nature_UndyingStrength", -- [1]
      2, -- [2]
      2, -- [3]
      16176, -- [4]
    }, -- [84]
    {
      "Interface\\Icons\\Spell_Nature_MoonGlow", -- [1]
      2, -- [2]
      3, -- [3]
      16173, -- [4]
    }, -- [85]
    {
      "Interface\\Icons\\Spell_Frost_Stun", -- [1]
      3, -- [2]
      1, -- [3]
      16180, -- [4]
    }, -- [86]
    {
      "Interface\\Icons\\Spell_Nature_HealingWaveLesser", -- [1]
      3, -- [2]
      2, -- [3]
      16181, -- [4]
    }, -- [87]
    {
      "Interface\\Icons\\Spell_Nature_NullWard", -- [1]
      3, -- [2]
      3, -- [3]
      16189, -- [4]
    }, -- [88]
    {
      "Interface\\Icons\\Spell_Nature_HealingTouch", -- [1]
      3, -- [2]
      4, -- [3]
      29187, -- [4]
    }, -- [89]
    {
      "Interface\\Icons\\Spell_Nature_ManaRegenTotem", -- [1]
      4, -- [2]
      2, -- [3]
      16187, -- [4]
    }, -- [90]
    {
      "Interface\\Icons\\Spell_Nature_Tranquility", -- [1]
      4, -- [2]
      3, -- [3]
      16194, -- [4]
    }, -- [91]
    {
      "Interface\\Icons\\Spell_Nature_HealingWay", -- [1]
      5, -- [2]
      1, -- [3]
      29206, -- [4]
    }, -- [92]
    {
      "Interface\\Icons\\Spell_Nature_RavenForm", -- [1]
      5, -- [2]
      3, -- [3]
      16188, -- [4]
    }, -- [93]
    {
      "Interface\\Icons\\Spell_Nature_FocusedMind", -- [1]
      5, -- [2]
      4, -- [3]
      30864, -- [4]
    }, -- [94]
    {
      "Interface\\Icons\\Spell_Frost_WizardMark", -- [1]
      6, -- [2]
      3, -- [3]
      16178, -- [4]
    }, -- [95]
    {
      "Interface\\Icons\\Spell_Frost_SummonWaterElemental", -- [1]
      7, -- [2]
      2, -- [3]
      16190, -- [4]
    }, -- [96]
    {
      "Interface\\Icons\\Spell_Nature_NatureGuardian", -- [1]
      7, -- [2]
      3, -- [3]
      30881, -- [4]
    }, -- [97]
    {
      "Interface\\Icons\\Spell_Nature_NatureBlessing", -- [1]
      8, -- [2]
      2, -- [3]
      30867, -- [4]
    }, -- [98]
    {
      "Interface\\Icons\\Spell_Nature_HealingWaveGreater", -- [1]
      8, -- [2]
      3, -- [3]
      30872, -- [4]
    }, -- [99]
    {
      "Interface\\Icons\\Spell_Nature_SkinofEarth", -- [1]
      9, -- [2]
      2, -- [3]
      974, -- [4]
    }, -- [100]
    nil, -- [101]
    nil, -- [102]
    nil, -- [103]
    nil, -- [104]
    nil, -- [105]
    nil, -- [106]
    nil, -- [107]
    nil, -- [108]
    nil, -- [109]
    nil, -- [110]
    nil, -- [111]
    nil, -- [112]
    nil, -- [113]
    nil, -- [114]
    nil, -- [115]
    nil, -- [116]
    nil, -- [117]
    nil, -- [118]
    nil, -- [119]
    nil, -- [120]
    {
      "ShamanElementalCombat", -- [1]
      "ShamanEnhancement", -- [2]
      "ShamanRestoration", -- [3]
    }, -- [121]
  },
  ["MAGE"] = {
    {
      "Interface\\Icons\\Spell_Holy_DispelMagic", -- [1]
      1, -- [2]
      1, -- [3]
      11210, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\Spell_Holy_Devotion", -- [1]
      1, -- [2]
      2, -- [3]
      11222, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\Spell_Nature_StarFall", -- [1]
      1, -- [2]
      3, -- [3]
      11237, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\INV_Wand_01", -- [1]
      2, -- [2]
      1, -- [3]
      6057, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\Spell_Nature_AstralRecalGroup", -- [1]
      2, -- [2]
      2, -- [3]
      29441, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\Spell_Shadow_ManaBurn", -- [1]
      2, -- [2]
      3, -- [3]
      11213, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Spell_Nature_AbolishMagic", -- [1]
      3, -- [2]
      1, -- [3]
      11247, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Spell_Nature_WispSplode", -- [1]
      3, -- [2]
      2, -- [3]
      11242, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\Spell_Arcane_ArcaneResilience", -- [1]
      3, -- [2]
      4, -- [3]
      28574, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Spell_Shadow_DetectLesserInvisibility", -- [1]
      4, -- [2]
      1, -- [3]
      11252, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\Spell_Frost_IceShock", -- [1]
      4, -- [2]
      2, -- [3]
      11255, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\Spell_Shadow_SiphonMana", -- [1]
      4, -- [2]
      4, -- [3]
      18462, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Spell_Arcane_Blink", -- [1]
      5, -- [2]
      1, -- [3]
      31569, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Spell_Nature_EnchantArmor", -- [1]
      5, -- [2]
      2, -- [3]
      12043, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\Spell_Shadow_Charm", -- [1]
      5, -- [2]
      4, -- [3]
      11232, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\Spell_Arcane_PrismaticCloak", -- [1]
      6, -- [2]
      1, -- [3]
      31574, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Spell_Shadow_Teleport", -- [1]
      6, -- [2]
      2, -- [3]
      15058, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Spell_Arcane_ArcanePotency", -- [1]
      6, -- [2]
      3, -- [3]
      31571, -- [4]
    }, -- [18]
    {
      "Interface\\Icons\\Spell_Nature_StarFall", -- [1]
      7, -- [2]
      1, -- [3]
      31579, -- [4]
    }, -- [19]
    {
      "Interface\\Icons\\Spell_Nature_Lightning", -- [1]
      7, -- [2]
      2, -- [3]
      12042, -- [4]
    }, -- [20]
    {
      "Interface\\Icons\\Spell_Arcane_ArcaneTorrent", -- [1]
      7, -- [2]
      3, -- [3]
      35578, -- [4]
    }, -- [21]
    {
      "Interface\\Icons\\Spell_Arcane_MindMastery", -- [1]
      8, -- [2]
      2, -- [3]
      31584, -- [4]
    }, -- [22]
    {
      "Interface\\Icons\\Spell_Nature_Slow", -- [1]
      9, -- [2]
      2, -- [3]
      31589, -- [4]
    }, -- [23]
    nil, -- [24]
    nil, -- [25]
    nil, -- [26]
    nil, -- [27]
    nil, -- [28]
    nil, -- [29]
    nil, -- [30]
    nil, -- [31]
    nil, -- [32]
    nil, -- [33]
    nil, -- [34]
    nil, -- [35]
    nil, -- [36]
    nil, -- [37]
    nil, -- [38]
    nil, -- [39]
    nil, -- [40]
    {
      "Interface\\Icons\\Spell_Fire_FlameBolt", -- [1]
      1, -- [2]
      2, -- [3]
      11069, -- [4]
    }, -- [41]
    {
      "Interface\\Icons\\Spell_Fire_MeteorStorm", -- [1]
      1, -- [2]
      3, -- [3]
      11103, -- [4]
    }, -- [42]
    {
      "Interface\\Icons\\Spell_Fire_Incinerate", -- [1]
      2, -- [2]
      1, -- [3]
      11119, -- [4]
    }, -- [43]
    {
      "Interface\\Icons\\Spell_Fire_Flare", -- [1]
      2, -- [2]
      2, -- [3]
      11100, -- [4]
    }, -- [44]
    {
      "Interface\\Icons\\Spell_Fire_Fireball", -- [1]
      2, -- [2]
      3, -- [3]
      11078, -- [4]
    }, -- [45]
    {
      "Interface\\Icons\\Spell_Fire_FlameShock", -- [1]
      3, -- [2]
      1, -- [3]
      18459, -- [4]
    }, -- [46]
    {
      "Interface\\Icons\\Spell_Fire_SelfDestruct", -- [1]
      3, -- [2]
      2, -- [3]
      11108, -- [4]
    }, -- [47]
    {
      "Interface\\Icons\\Spell_Fire_Fireball02", -- [1]
      3, -- [2]
      3, -- [3]
      11366, -- [4]
    }, -- [48]
    {
      "Interface\\Icons\\Spell_Fire_Fire", -- [1]
      3, -- [2]
      4, -- [3]
      11083, -- [4]
    }, -- [49]
    {
      "Interface\\Icons\\Spell_Fire_SoulBurn", -- [1]
      4, -- [2]
      1, -- [3]
      11095, -- [4]
    }, -- [50]
    {
      "Interface\\Icons\\Spell_Fire_FireArmor", -- [1]
      4, -- [2]
      2, -- [3]
      11094, -- [4]
    }, -- [51]
    {
      "Interface\\Icons\\Spell_Fire_MasterOfElements", -- [1]
      4, -- [2]
      4, -- [3]
      29074, -- [4]
    }, -- [52]
    {
      "Interface\\Icons\\Spell_Fire_PlayingWithFire", -- [1]
      5, -- [2]
      1, -- [3]
      31638, -- [4]
    }, -- [53]
    {
      "Interface\\Icons\\Spell_Nature_WispHeal", -- [1]
      5, -- [2]
      2, -- [3]
      11115, -- [4]
    }, -- [54]
    {
      "Interface\\Icons\\Spell_Holy_Excorcism_02", -- [1]
      5, -- [2]
      3, -- [3]
      11113, -- [4]
    }, -- [55]
    {
      "Interface\\Icons\\Spell_Fire_BurningSpeed", -- [1]
      6, -- [2]
      1, -- [3]
      31641, -- [4]
    }, -- [56]
    {
      "Interface\\Icons\\Spell_Fire_Immolation", -- [1]
      6, -- [2]
      3, -- [3]
      11124, -- [4]
    }, -- [57]
    {
      "Interface\\Icons\\Spell_Fire_Burnout", -- [1]
      7, -- [2]
      1, -- [3]
      34293, -- [4]
    }, -- [58]
    {
      "Interface\\Icons\\Spell_Fire_SealOfFire", -- [1]
      7, -- [2]
      2, -- [3]
      11129, -- [4]
    }, -- [59]
    {
      "Interface\\Icons\\Spell_Fire_MoltenBlood", -- [1]
      7, -- [2]
      3, -- [3]
      31679, -- [4]
    }, -- [60]
    {
      "Interface\\Icons\\Spell_Fire_FlameBolt", -- [1]
      8, -- [2]
      3, -- [3]
      31656, -- [4]
    }, -- [61]
    {
      "Interface\\Icons\\INV_Misc_Head_Dragon_01", -- [1]
      9, -- [2]
      2, -- [3]
      31661, -- [4]
    }, -- [62]
    nil, -- [63]
    nil, -- [64]
    nil, -- [65]
    nil, -- [66]
    nil, -- [67]
    nil, -- [68]
    nil, -- [69]
    nil, -- [70]
    nil, -- [71]
    nil, -- [72]
    nil, -- [73]
    nil, -- [74]
    nil, -- [75]
    nil, -- [76]
    nil, -- [77]
    nil, -- [78]
    nil, -- [79]
    nil, -- [80]
    {
      "Interface\\Icons\\Spell_Frost_FrostWard", -- [1]
      1, -- [2]
      1, -- [3]
      11189, -- [4]
    }, -- [81]
    {
      "Interface\\Icons\\Spell_Frost_FrostBolt02", -- [1]
      1, -- [2]
      2, -- [3]
      11070, -- [4]
    }, -- [82]
    {
      "Interface\\Icons\\Spell_Ice_MagicDamage", -- [1]
      1, -- [2]
      3, -- [3]
      29438, -- [4]
    }, -- [83]
    {
      "Interface\\Icons\\Spell_Frost_IceShard", -- [1]
      2, -- [2]
      1, -- [3]
      11207, -- [4]
    }, -- [84]
    {
      "Interface\\Icons\\Spell_Frost_FrostArmor", -- [1]
      2, -- [2]
      2, -- [3]
      11071, -- [4]
    }, -- [85]
    {
      "Interface\\Icons\\Spell_Frost_FreezingBreath", -- [1]
      2, -- [2]
      3, -- [3]
      11165, -- [4]
    }, -- [86]
    {
      "Interface\\Icons\\Spell_Frost_Wisp", -- [1]
      2, -- [2]
      4, -- [3]
      11175, -- [4]
    }, -- [87]
    {
      "Interface\\Icons\\Spell_Frost_Frostbolt", -- [1]
      3, -- [2]
      1, -- [3]
      11151, -- [4]
    }, -- [88]
    {
      "Interface\\Icons\\Spell_Frost_ColdHearted", -- [1]
      3, -- [2]
      2, -- [3]
      12472, -- [4]
    }, -- [89]
    {
      "Interface\\Icons\\Spell_Frost_IceStorm", -- [1]
      3, -- [2]
      4, -- [3]
      11185, -- [4]
    }, -- [90]
    {
      "Interface\\Icons\\Spell_Shadow_DarkRitual", -- [1]
      4, -- [2]
      1, -- [3]
      16757, -- [4]
    }, -- [91]
    {
      "Interface\\Icons\\Spell_Frost_Stun", -- [1]
      4, -- [2]
      2, -- [3]
      11160, -- [4]
    }, -- [92]
    {
      "Interface\\Icons\\Spell_Frost_FrostShock", -- [1]
      4, -- [2]
      3, -- [3]
      11170, -- [4]
    }, -- [93]
    {
      "Interface\\Icons\\Spell_Frost_FrozenCore", -- [1]
      5, -- [2]
      1, -- [3]
      31667, -- [4]
    }, -- [94]
    {
      "Interface\\Icons\\Spell_Frost_WizardMark", -- [1]
      5, -- [2]
      2, -- [3]
      11958, -- [4]
    }, -- [95]
    {
      "Interface\\Icons\\Spell_Frost_Glacier", -- [1]
      5, -- [2]
      3, -- [3]
      11190, -- [4]
    }, -- [96]
    {
      "Interface\\Icons\\Spell_Frost_IceFloes", -- [1]
      6, -- [2]
      1, -- [3]
      31670, -- [4]
    }, -- [97]
    {
      "Interface\\Icons\\Spell_Frost_ChillingBlast", -- [1]
      6, -- [2]
      3, -- [3]
      11180, -- [4]
    }, -- [98]
    {
      "Interface\\Icons\\Spell_Ice_Lament", -- [1]
      7, -- [2]
      2, -- [3]
      11426, -- [4]
    }, -- [99]
    {
      "Interface\\Icons\\Spell_Frost_ArcticWinds", -- [1]
      7, -- [2]
      3, -- [3]
      31674, -- [4]
    }, -- [100]
    {
      "Interface\\Icons\\Spell_Frost_FrostBolt02", -- [1]
      8, -- [2]
      2, -- [3]
      31682, -- [4]
    }, -- [101]
    {
      "Interface\\Icons\\Spell_Frost_SummonWaterElemental_2", -- [1]
      9, -- [2]
      2, -- [3]
      31687, -- [4]
    }, -- [102]
    nil, -- [103]
    nil, -- [104]
    nil, -- [105]
    nil, -- [106]
    nil, -- [107]
    nil, -- [108]
    nil, -- [109]
    nil, -- [110]
    nil, -- [111]
    nil, -- [112]
    nil, -- [113]
    nil, -- [114]
    nil, -- [115]
    nil, -- [116]
    nil, -- [117]
    nil, -- [118]
    nil, -- [119]
    nil, -- [120]
    {
      "MageArcane", -- [1]
      "MageFire", -- [2]
      "MageFrost", -- [3]
    }, -- [121]
  },
  ["PRIEST"] = {
    {
      "Interface\\Icons\\Spell_Magic_MageArmor", -- [1]
      1, -- [2]
      2, -- [3]
      14522, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\INV_Wand_01", -- [1]
      1, -- [2]
      3, -- [3]
      14524, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\Spell_Nature_ManaRegenTotem", -- [1]
      2, -- [2]
      1, -- [3]
      14523, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Spell_Holy_WordFortitude", -- [1]
      2, -- [2]
      2, -- [3]
      14749, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\Spell_Holy_PowerWordShield", -- [1]
      2, -- [2]
      3, -- [3]
      14748, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\Spell_Nature_Tranquility", -- [1]
      2, -- [2]
      4, -- [3]
      14531, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Spell_Holy_Absolution", -- [1]
      3, -- [2]
      1, -- [3]
      33167, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Spell_Frost_WindWalkOn", -- [1]
      3, -- [2]
      2, -- [3]
      14751, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\Spell_Nature_Sleep", -- [1]
      3, -- [2]
      3, -- [3]
      14521, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Spell_Holy_InnerFire", -- [1]
      4, -- [2]
      1, -- [3]
      14747, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\Ability_Hibernation", -- [1]
      4, -- [2]
      2, -- [3]
      14520, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\Spell_Shadow_ManaBurn", -- [1]
      4, -- [2]
      4, -- [3]
      14750, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Spell_Nature_EnchantArmor", -- [1]
      5, -- [2]
      2, -- [3]
      18551, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Spell_Holy_DivineSpirit", -- [1]
      5, -- [2]
      3, -- [3]
      14752, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\Spell_Holy_DivineSpirit", -- [1]
      5, -- [2]
      4, -- [3]
      33174, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\Spell_Shadow_FocusedPower", -- [1]
      6, -- [2]
      1, -- [3]
      33186, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Spell_Nature_SlowingTotem", -- [1]
      6, -- [2]
      3, -- [3]
      18544, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Spell_Arcane_FocusedPower", -- [1]
      7, -- [2]
      1, -- [3]
      45234, -- [4]
    }, -- [18]
    {
      "Interface\\Icons\\Spell_Holy_PowerInfusion", -- [1]
      7, -- [2]
      2, -- [3]
      10060, -- [4]
    }, -- [19]
    {
      "Interface\\Icons\\Spell_Holy_PowerWordShield", -- [1]
      7, -- [2]
      3, -- [3]
      33201, -- [4]
    }, -- [20]
    {
      "Interface\\Icons\\Spell_Arcane_MindMastery", -- [1]
      8, -- [2]
      2, -- [3]
      34908, -- [4]
    }, -- [21]
    {
      "Interface\\Icons\\Spell_Holy_PainSupression", -- [1]
      9, -- [2]
      2, -- [3]
      33206, -- [4]
    }, -- [22]
    nil, -- [23]
    nil, -- [24]
    nil, -- [25]
    nil, -- [26]
    nil, -- [27]
    nil, -- [28]
    nil, -- [29]
    nil, -- [30]
    nil, -- [31]
    nil, -- [32]
    nil, -- [33]
    nil, -- [34]
    nil, -- [35]
    nil, -- [36]
    nil, -- [37]
    nil, -- [38]
    nil, -- [39]
    nil, -- [40]
    {
      "Interface\\Icons\\Spell_Holy_HealingFocus", -- [1]
      1, -- [2]
      1, -- [3]
      14913, -- [4]
    }, -- [41]
    {
      "Interface\\Icons\\Spell_Holy_Renew", -- [1]
      1, -- [2]
      2, -- [3]
      14908, -- [4]
    }, -- [42]
    {
      "Interface\\Icons\\Spell_Holy_SealOfSalvation", -- [1]
      1, -- [2]
      3, -- [3]
      14889, -- [4]
    }, -- [43]
    {
      "Interface\\Icons\\Spell_Holy_SpellWarding", -- [1]
      2, -- [2]
      2, -- [3]
      27900, -- [4]
    }, -- [44]
    {
      "Interface\\Icons\\Spell_Holy_SealOfWrath", -- [1]
      2, -- [2]
      3, -- [3]
      18530, -- [4]
    }, -- [45]
    {
      "Interface\\Icons\\Spell_Holy_HolyNova", -- [1]
      3, -- [2]
      1, -- [3]
      15237, -- [4]
    }, -- [46]
    {
      "Interface\\Icons\\Spell_Holy_BlessedRecovery", -- [1]
      3, -- [2]
      2, -- [3]
      27811, -- [4]
    }, -- [47]
    {
      "Interface\\Icons\\Spell_Holy_LayOnHands", -- [1]
      3, -- [2]
      4, -- [3]
      14892, -- [4]
    }, -- [48]
    {
      "Interface\\Icons\\Spell_Holy_Purify", -- [1]
      4, -- [2]
      1, -- [3]
      27789, -- [4]
    }, -- [49]
    {
      "Interface\\Icons\\Spell_Holy_Heal02", -- [1]
      4, -- [2]
      2, -- [3]
      14912, -- [4]
    }, -- [50]
    {
      "Interface\\Icons\\Spell_Holy_SearingLightPriest", -- [1]
      4, -- [2]
      3, -- [3]
      14909, -- [4]
    }, -- [51]
    {
      "Interface\\Icons\\Spell_Holy_PrayerOfHealing02", -- [1]
      5, -- [2]
      1, -- [3]
      14911, -- [4]
    }, -- [52]
    {
      "Interface\\Icons\\INV_Enchant_EssenceEternalLarge", -- [1]
      5, -- [2]
      2, -- [3]
      20711, -- [4]
    }, -- [53]
    {
      "Interface\\Icons\\Spell_Holy_SpiritualGuidence", -- [1]
      5, -- [2]
      3, -- [3]
      14901, -- [4]
    }, -- [54]
    {
      "Interface\\Icons\\Spell_Holy_SurgeOfLight", -- [1]
      6, -- [2]
      1, -- [3]
      33150, -- [4]
    }, -- [55]
    {
      "Interface\\Icons\\Spell_Nature_MoonGlow", -- [1]
      6, -- [2]
      3, -- [3]
      14898, -- [4]
    }, -- [56]
    {
      "Interface\\Icons\\Spell_Holy_Fanaticism", -- [1]
      7, -- [2]
      1, -- [3]
      34753, -- [4]
    }, -- [57]
    {
      "Interface\\Icons\\Spell_Holy_SummonLightwell", -- [1]
      7, -- [2]
      2, -- [3]
      724, -- [4]
    }, -- [58]
    {
      "Interface\\Icons\\Spell_Holy_BlessedResillience", -- [1]
      7, -- [2]
      3, -- [3]
      33142, -- [4]
    }, -- [59]
    {
      "Interface\\Icons\\Spell_Holy_GreaterHeal", -- [1]
      8, -- [2]
      2, -- [3]
      33158, -- [4]
    }, -- [60]
    {
      "Interface\\Icons\\Spell_Holy_CircleOfRenewal", -- [1]
      9, -- [2]
      2, -- [3]
      34861, -- [4]
    }, -- [61]
    nil, -- [62]
    nil, -- [63]
    nil, -- [64]
    nil, -- [65]
    nil, -- [66]
    nil, -- [67]
    nil, -- [68]
    nil, -- [69]
    nil, -- [70]
    nil, -- [71]
    nil, -- [72]
    nil, -- [73]
    nil, -- [74]
    nil, -- [75]
    nil, -- [76]
    nil, -- [77]
    nil, -- [78]
    nil, -- [79]
    nil, -- [80]
    {
      "Interface\\Icons\\Spell_Shadow_Requiem", -- [1]
      1, -- [2]
      2, -- [3]
      15270, -- [4]
    }, -- [81]
    {
      "Interface\\Icons\\Spell_Shadow_GatherShadows", -- [1]
      1, -- [2]
      3, -- [3]
      15268, -- [4]
    }, -- [82]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowWard", -- [1]
      2, -- [2]
      1, -- [3]
      15318, -- [4]
    }, -- [83]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowWordPain", -- [1]
      2, -- [2]
      2, -- [3]
      15275, -- [4]
    }, -- [84]
    {
      "Interface\\Icons\\Spell_Shadow_BurningSpirit", -- [1]
      2, -- [2]
      3, -- [3]
      15260, -- [4]
    }, -- [85]
    {
      "Interface\\Icons\\Spell_Shadow_PsychicScream", -- [1]
      3, -- [2]
      1, -- [3]
      15392, -- [4]
    }, -- [86]
    {
      "Interface\\Icons\\Spell_Shadow_UnholyFrenzy", -- [1]
      3, -- [2]
      2, -- [3]
      15273, -- [4]
    }, -- [87]
    {
      "Interface\\Icons\\Spell_Shadow_SiphonMana", -- [1]
      3, -- [2]
      3, -- [3]
      15407, -- [4]
    }, -- [88]
    {
      "Interface\\Icons\\Spell_Magic_LesserInvisibilty", -- [1]
      4, -- [2]
      2, -- [3]
      15274, -- [4]
    }, -- [89]
    {
      "Interface\\Icons\\Spell_Shadow_ChillTouch", -- [1]
      4, -- [2]
      3, -- [3]
      17322, -- [4]
    }, -- [90]
    {
      "Interface\\Icons\\Spell_Shadow_BlackPlague", -- [1]
      4, -- [2]
      4, -- [3]
      15257, -- [4]
    }, -- [91]
    {
      "Interface\\Icons\\Spell_Shadow_ImpPhaseShift", -- [1]
      5, -- [2]
      1, -- [3]
      15487, -- [4]
    }, -- [92]
    {
      "Interface\\Icons\\Spell_Shadow_UnsummonBuilding", -- [1]
      5, -- [2]
      2, -- [3]
      15286, -- [4]
    }, -- [93]
    {
      "Interface\\Icons\\Spell_Shadow_ImprovedVampiricEmbrace", -- [1]
      5, -- [2]
      3, -- [3]
      27839, -- [4]
    }, -- [94]
    {
      "Interface\\Icons\\Spell_Nature_FocusedMind", -- [1]
      5, -- [2]
      4, -- [3]
      33213, -- [4]
    }, -- [95]
    {
      "Interface\\Icons\\Spell_Shadow_GrimWard", -- [1]
      6, -- [2]
      1, -- [3]
      14910, -- [4]
    }, -- [96]
    {
      "Interface\\Icons\\Spell_Shadow_Twilight", -- [1]
      6, -- [2]
      3, -- [3]
      15259, -- [4]
    }, -- [97]
    {
      "Interface\\Icons\\Spell_Shadow_Shadowform", -- [1]
      7, -- [2]
      2, -- [3]
      15473, -- [4]
    }, -- [98]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowPower", -- [1]
      7, -- [2]
      3, -- [3]
      33221, -- [4]
    }, -- [99]
    {
      "Interface\\Icons\\Spell_Shadow_Misery", -- [1]
      8, -- [2]
      3, -- [3]
      33191, -- [4]
    }, -- [100]
    {
      "Interface\\Icons\\Spell_Holy_Stoicism", -- [1]
      9, -- [2]
      2, -- [3]
      34914, -- [4]
    }, -- [101]
    nil, -- [102]
    nil, -- [103]
    nil, -- [104]
    nil, -- [105]
    nil, -- [106]
    nil, -- [107]
    nil, -- [108]
    nil, -- [109]
    nil, -- [110]
    nil, -- [111]
    nil, -- [112]
    nil, -- [113]
    nil, -- [114]
    nil, -- [115]
    nil, -- [116]
    nil, -- [117]
    nil, -- [118]
    nil, -- [119]
    nil, -- [120]
    {
      "PriestDiscipline", -- [1]
      "PriestHoly", -- [2]
      "PriestShadow", -- [3]
    }, -- [121]
  },
  ["WARLOCK"] = {
    {
      "Interface\\Icons\\Spell_Shadow_UnsummonBuilding", -- [1]
      1, -- [2]
      2, -- [3]
      18174, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\Spell_Shadow_AbominationExplosion", -- [1]
      1, -- [2]
      3, -- [3]
      17810, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\Spell_Shadow_CurseOfMannoroth", -- [1]
      2, -- [2]
      1, -- [3]
      18179, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Spell_Shadow_Haunting", -- [1]
      2, -- [2]
      2, -- [3]
      18213, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\Spell_Shadow_BurningSpirit", -- [1]
      2, -- [2]
      3, -- [3]
      18182, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\Spell_Shadow_LifeDrain02", -- [1]
      2, -- [2]
      4, -- [3]
      17804, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Spell_Shadow_CurseOfSargeras", -- [1]
      3, -- [2]
      1, -- [3]
      18827, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Spell_Shadow_FingerOfDeath", -- [1]
      3, -- [2]
      2, -- [3]
      17783, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\Spell_Shadow_Contagion", -- [1]
      3, -- [2]
      3, -- [3]
      18288, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Spell_Shadow_CallofBone", -- [1]
      4, -- [2]
      1, -- [3]
      18218, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\Spell_Shadow_Twilight", -- [1]
      4, -- [2]
      2, -- [3]
      18094, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\Spell_Shadow_AbominationExplosion", -- [1]
      4, -- [2]
      4, -- [3]
      32381, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowEmbrace", -- [1]
      5, -- [2]
      1, -- [3]
      32385, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Spell_Shadow_Requiem", -- [1]
      5, -- [2]
      2, -- [3]
      18265, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\Spell_Shadow_GrimWard", -- [1]
      5, -- [2]
      3, -- [3]
      18223, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\Spell_Shadow_ShadeTrueSight", -- [1]
      6, -- [2]
      2, -- [3]
      18271, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Spell_Shadow_PainfulAfflictions", -- [1]
      7, -- [2]
      2, -- [3]
      30060, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Spell_Shadow_DarkRitual", -- [1]
      7, -- [2]
      3, -- [3]
      18220, -- [4]
    }, -- [18]
    {
      "Interface\\Icons\\Spell_Shadow_DeathScream", -- [1]
      8, -- [2]
      1, -- [3]
      30054, -- [4]
    }, -- [19]
    {
      "Interface\\Icons\\Spell_Shadow_CurseOfAchimonde", -- [1]
      8, -- [2]
      3, -- [3]
      32477, -- [4]
    }, -- [20]
    {
      "Interface\\Icons\\Spell_Shadow_UnstableAffliction_3", -- [1]
      9, -- [2]
      2, -- [3]
      30108, -- [4]
    }, -- [21]
    nil, -- [22]
    nil, -- [23]
    nil, -- [24]
    nil, -- [25]
    nil, -- [26]
    nil, -- [27]
    nil, -- [28]
    nil, -- [29]
    nil, -- [30]
    nil, -- [31]
    nil, -- [32]
    nil, -- [33]
    nil, -- [34]
    nil, -- [35]
    nil, -- [36]
    nil, -- [37]
    nil, -- [38]
    nil, -- [39]
    nil, -- [40]
    {
      "Interface\\Icons\\INV_Stone_04", -- [1]
      1, -- [2]
      1, -- [3]
      18692, -- [4]
    }, -- [41]
    {
      "Interface\\Icons\\Spell_Shadow_SummonImp", -- [1]
      1, -- [2]
      2, -- [3]
      18694, -- [4]
    }, -- [42]
    {
      "Interface\\Icons\\Spell_Shadow_Metamorphosis", -- [1]
      1, -- [2]
      3, -- [3]
      18697, -- [4]
    }, -- [43]
    {
      "Interface\\Icons\\Spell_Shadow_LifeDrain", -- [1]
      2, -- [2]
      1, -- [3]
      18703, -- [4]
    }, -- [44]
    {
      "Interface\\Icons\\Spell_Shadow_SummonVoidWalker", -- [1]
      2, -- [2]
      2, -- [3]
      18705, -- [4]
    }, -- [45]
    {
      "Interface\\Icons\\Spell_Holy_MagicalSentry", -- [1]
      2, -- [2]
      3, -- [3]
      18731, -- [4]
    }, -- [46]
    {
      "Interface\\Icons\\Spell_Shadow_SummonSuccubus", -- [1]
      3, -- [2]
      1, -- [3]
      18754, -- [4]
    }, -- [47]
    {
      "Interface\\Icons\\Spell_Nature_RemoveCurse", -- [1]
      3, -- [2]
      2, -- [3]
      18708, -- [4]
    }, -- [48]
    {
      "Interface\\Icons\\Spell_Shadow_AntiShadow", -- [1]
      3, -- [2]
      3, -- [3]
      18748, -- [4]
    }, -- [49]
    {
      "Interface\\Icons\\Spell_Shadow_RagingScream", -- [1]
      3, -- [2]
      4, -- [3]
      30143, -- [4]
    }, -- [50]
    {
      "Interface\\Icons\\Spell_Shadow_ImpPhaseShift", -- [1]
      4, -- [2]
      2, -- [3]
      18709, -- [4]
    }, -- [51]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowWordDominate", -- [1]
      4, -- [2]
      3, -- [3]
      18769, -- [4]
    }, -- [52]
    {
      "Interface\\Icons\\Spell_Shadow_EnslaveDemon", -- [1]
      5, -- [2]
      1, -- [3]
      18821, -- [4]
    }, -- [53]
    {
      "Interface\\Icons\\Spell_Shadow_PsychicScream", -- [1]
      5, -- [2]
      2, -- [3]
      18788, -- [4]
    }, -- [54]
    {
      "Interface\\Icons\\INV_Ammo_FireTar", -- [1]
      5, -- [2]
      4, -- [3]
      18767, -- [4]
    }, -- [55]
    {
      "Interface\\Icons\\Spell_Shadow_ManaFeed", -- [1]
      6, -- [2]
      1, -- [3]
      30326, -- [4]
    }, -- [56]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowPact", -- [1]
      6, -- [2]
      3, -- [3]
      23785, -- [4]
    }, -- [57]
    {
      "Interface\\Icons\\Spell_Shadow_DemonicFortitude", -- [1]
      7, -- [2]
      1, -- [3]
      30319, -- [4]
    }, -- [58]
    {
      "Interface\\Icons\\Spell_Shadow_GatherShadows", -- [1]
      7, -- [2]
      2, -- [3]
      19028, -- [4]
    }, -- [59]
    {
      "Interface\\Icons\\Spell_Shadow_ImprovedVampiricEmbrace", -- [1]
      7, -- [2]
      3, -- [3]
      35691, -- [4]
    }, -- [60]
    {
      "Interface\\Icons\\Spell_Shadow_DemonicTactics", -- [1]
      8, -- [2]
      2, -- [3]
      30242, -- [4]
    }, -- [61]
    {
      "Interface\\Icons\\Spell_Shadow_SummonFelGuard", -- [1]
      9, -- [2]
      2, -- [3]
      30146, -- [4]
    }, -- [62]
    nil, -- [63]
    nil, -- [64]
    nil, -- [65]
    nil, -- [66]
    nil, -- [67]
    nil, -- [68]
    nil, -- [69]
    nil, -- [70]
    nil, -- [71]
    nil, -- [72]
    nil, -- [73]
    nil, -- [74]
    nil, -- [75]
    nil, -- [76]
    nil, -- [77]
    nil, -- [78]
    nil, -- [79]
    nil, -- [80]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowBolt", -- [1]
      1, -- [2]
      2, -- [3]
      17793, -- [4]
    }, -- [81]
    {
      "Interface\\Icons\\Spell_Fire_WindsofWoe", -- [1]
      1, -- [2]
      3, -- [3]
      17778, -- [4]
    }, -- [82]
    {
      "Interface\\Icons\\Spell_Shadow_DeathPact", -- [1]
      2, -- [2]
      2, -- [3]
      17788, -- [4]
    }, -- [83]
    {
      "Interface\\Icons\\Spell_Fire_Fire", -- [1]
      2, -- [2]
      3, -- [3]
      18119, -- [4]
    }, -- [84]
    {
      "Interface\\Icons\\Spell_Fire_FireBolt", -- [1]
      3, -- [2]
      1, -- [3]
      18126, -- [4]
    }, -- [85]
    {
      "Interface\\Icons\\Spell_Shadow_Curse", -- [1]
      3, -- [2]
      2, -- [3]
      18128, -- [4]
    }, -- [86]
    {
      "Interface\\Icons\\Spell_Fire_FlameShock", -- [1]
      3, -- [2]
      3, -- [3]
      18130, -- [4]
    }, -- [87]
    {
      "Interface\\Icons\\Spell_Shadow_ScourgeBuild", -- [1]
      3, -- [2]
      4, -- [3]
      17877, -- [4]
    }, -- [88]
    {
      "Interface\\Icons\\Spell_Fire_LavaSpawn", -- [1]
      4, -- [2]
      1, -- [3]
      18135, -- [4]
    }, -- [89]
    {
      "Interface\\Icons\\Spell_Shadow_CorpseExplode", -- [1]
      4, -- [2]
      2, -- [3]
      17917, -- [4]
    }, -- [90]
    {
      "Interface\\Icons\\Spell_Fire_SoulBurn", -- [1]
      4, -- [2]
      4, -- [3]
      17927, -- [4]
    }, -- [91]
    {
      "Interface\\Icons\\Spell_Fire_Volcano", -- [1]
      5, -- [2]
      1, -- [3]
      18096, -- [4]
    }, -- [92]
    {
      "Interface\\Icons\\Spell_Fire_Immolation", -- [1]
      5, -- [2]
      2, -- [3]
      17815, -- [4]
    }, -- [93]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowWordPain", -- [1]
      5, -- [2]
      3, -- [3]
      17959, -- [4]
    }, -- [94]
    {
      "Interface\\Icons\\Spell_Shadow_NetherProtection", -- [1]
      6, -- [2]
      1, -- [3]
      30299, -- [4]
    }, -- [95]
    {
      "Interface\\Icons\\Spell_Fire_SelfDestruct", -- [1]
      6, -- [2]
      3, -- [3]
      17954, -- [4]
    }, -- [96]
    {
      "Interface\\Icons\\Spell_Fire_PlayingWithFire", -- [1]
      7, -- [2]
      1, -- [3]
      34935, -- [4]
    }, -- [97]
    {
      "Interface\\Icons\\Spell_Fire_Fireball", -- [1]
      7, -- [2]
      2, -- [3]
      17962, -- [4]
    }, -- [98]
    {
      "Interface\\Icons\\Spell_Shadow_SoulLeech_3", -- [1]
      7, -- [2]
      3, -- [3]
      30293, -- [4]
    }, -- [99]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowandFlame", -- [1]
      8, -- [2]
      2, -- [3]
      30288, -- [4]
    }, -- [100]
    {
      "Interface\\Icons\\Spell_Shadow_Shadowfury", -- [1]
      9, -- [2]
      2, -- [3]
      30283, -- [4]
    }, -- [101]
    nil, -- [102]
    nil, -- [103]
    nil, -- [104]
    nil, -- [105]
    nil, -- [106]
    nil, -- [107]
    nil, -- [108]
    nil, -- [109]
    nil, -- [110]
    nil, -- [111]
    nil, -- [112]
    nil, -- [113]
    nil, -- [114]
    nil, -- [115]
    nil, -- [116]
    nil, -- [117]
    nil, -- [118]
    nil, -- [119]
    nil, -- [120]
    {
      "WarlockCurses", -- [1]
      "WarlockSummoning", -- [2]
      "WarlockDestruction", -- [3]
    }, -- [121]
  },
  ["DEATHKNIGHT"] = {
    {
      "Interface\\Icons\\INV_Axe_68", -- [1]
      1, -- [2]
      1, -- [3]
      48979, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\Spell_DeathKnight_Subversion", -- [1]
      1, -- [2]
      2, -- [3]
      48997, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\Ability_UpgradeMoonGlaive", -- [1]
      1, -- [2]
      3, -- [3]
      55226, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\INV_Shoulder_36", -- [1]
      2, -- [2]
      1, -- [3]
      49393, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\Ability_Rogue_BloodyEye", -- [1]
      2, -- [2]
      2, -- [3]
      49004, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\INV_Sword_68", -- [1]
      2, -- [2]
      3, -- [3]
      55108, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Spell_DeathKnight_RuneTap", -- [1]
      3, -- [2]
      1, -- [3]
      48982, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Spell_DeathKnight_DarkConviction", -- [1]
      3, -- [2]
      2, -- [3]
      49480, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\INV_Sword_62", -- [1]
      3, -- [2]
      3, -- [3]
      50034, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Spell_DeathKnight_RuneTap", -- [1]
      4, -- [2]
      1, -- [3]
      49489, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\Spell_DeathKnight_SpellDeflection", -- [1]
      4, -- [2]
      3, -- [3]
      49497, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\Spell_DeathKnight_Vendetta", -- [1]
      4, -- [2]
      4, -- [3]
      49015, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Spell_Deathknight_DeathStrike", -- [1]
      5, -- [2]
      1, -- [3]
      49395, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Spell_Misc_WarsongFocus", -- [1]
      5, -- [2]
      3, -- [3]
      50029, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\Ability_Hunter_RapidKilling", -- [1]
      5, -- [2]
      4, -- [3]
      49005, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\Ability_BackStab", -- [1]
      6, -- [2]
      2, -- [3]
      48988, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Ability_Warrior_IntensifyRage", -- [1]
      6, -- [2]
      3, -- [3]
      53138, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Spell_Shadow_SoulLeech", -- [1]
      7, -- [2]
      1, -- [3]
      49027, -- [4]
    }, -- [18]
    {
      "Interface\\Icons\\Spell_DeathKnight_BladedArmor", -- [1]
      7, -- [2]
      2, -- [3]
      49016, -- [4]
    }, -- [19]
    {
      "Interface\\Icons\\Spell_Deathknight_BloodPresence", -- [1]
      7, -- [2]
      3, -- [3]
      50365, -- [4]
    }, -- [20]
    {
      "Interface\\Icons\\Spell_DeathKnight_Butcher2", -- [1]
      8, -- [2]
      1, -- [3]
      62908, -- [4]
    }, -- [21]
    {
      "Interface\\Icons\\Spell_Shadow_PainSpike", -- [1]
      8, -- [2]
      2, -- [3]
      49018, -- [4]
    }, -- [22]
    {
      "Interface\\Icons\\Spell_Shadow_LifeDrain", -- [1]
      8, -- [2]
      3, -- [3]
      55233, -- [4]
    }, -- [23]
    {
      "Interface\\Icons\\Ability_Creature_Cursed_02", -- [1]
      9, -- [2]
      1, -- [3]
      50150, -- [4]
    }, -- [24]
    {
      "Interface\\Icons\\INV_Weapon_Shortblade_40", -- [1]
      9, -- [2]
      2, -- [3]
      55050, -- [4]
    }, -- [25]
    {
      "Interface\\Icons\\Spell_Deathknight_ClassIcon", -- [1]
      9, -- [2]
      3, -- [3]
      49023, -- [4]
    }, -- [26]
    {
      "Interface\\Icons\\Spell_Nature_Reincarnation", -- [1]
      10, -- [2]
      2, -- [3]
      61154, -- [4]
    }, -- [27]
    {
      "Interface\\Icons\\INV_Sword_07", -- [1]
      11, -- [2]
      2, -- [3]
      49028, -- [4]
    }, -- [28]
    nil, -- [29]
    nil, -- [30]
    nil, -- [31]
    nil, -- [32]
    nil, -- [33]
    nil, -- [34]
    nil, -- [35]
    nil, -- [36]
    nil, -- [37]
    nil, -- [38]
    nil, -- [39]
    nil, -- [40]
    {
      "Interface\\Icons\\Spell_DeathKnight_IceTouch", -- [1]
      1, -- [2]
      1, -- [3]
      51456, -- [4]
    }, -- [41]
    {
      "Interface\\Icons\\Spell_Arcane_Arcane01", -- [1]
      1, -- [2]
      2, -- [3]
      49455, -- [4]
    }, -- [42]
    {
      "Interface\\Icons\\Spell_Holy_Devotion", -- [1]
      1, -- [2]
      3, -- [3]
      49789, -- [4]
    }, -- [43]
    {
      "Interface\\Icons\\Spell_Frost_ManaRecharge", -- [1]
      2, -- [2]
      2, -- [3]
      55061, -- [4]
    }, -- [44]
    {
      "Interface\\Icons\\Spell_Shadow_DarkRitual", -- [1]
      2, -- [2]
      3, -- [3]
      49663, -- [4]
    }, -- [45]
    {
      "Interface\\Icons\\Ability_DualWield", -- [1]
      2, -- [2]
      4, -- [3]
      49226, -- [4]
    }, -- [46]
    {
      "Interface\\Icons\\Spell_Deathknight_IcyTalons", -- [1]
      3, -- [2]
      1, -- [3]
      50887, -- [4]
    }, -- [47]
    {
      "Interface\\Icons\\Spell_Shadow_RaiseDead", -- [1]
      3, -- [2]
      2, -- [3]
      49039, -- [4]
    }, -- [48]
    {
      "Interface\\Icons\\INV_Weapon_Hand_18", -- [1]
      3, -- [2]
      3, -- [3]
      51468, -- [4]
    }, -- [49]
    {
      "Interface\\Icons\\INV_Sword_122", -- [1]
      4, -- [2]
      2, -- [3]
      51128, -- [4]
    }, -- [50]
    {
      "Interface\\Icons\\Spell_Frost_FrostShock", -- [1]
      4, -- [2]
      3, -- [3]
      49149, -- [4]
    }, -- [51]
    {
      "Interface\\Icons\\Spell_Shadow_Twilight", -- [1]
      4, -- [2]
      4, -- [3]
      49657, -- [4]
    }, -- [52]
    {
      "Interface\\Icons\\INV_CHEST_MAIL_04", -- [1]
      5, -- [2]
      2, -- [3]
      51108, -- [4]
    }, -- [53]
    {
      "Interface\\Icons\\Spell_Nature_RemoveDisease", -- [1]
      5, -- [2]
      3, -- [3]
      49791, -- [4]
    }, -- [54]
    {
      "Interface\\Icons\\Spell_Shadow_SoulLeech_2", -- [1]
      5, -- [2]
      4, -- [3]
      49796, -- [4]
    }, -- [55]
    {
      "Interface\\Icons\\Spell_Deathknight_IcyTalons", -- [1]
      6, -- [2]
      1, -- [3]
      55610, -- [4]
    }, -- [56]
    {
      "Interface\\Icons\\INV_Sword_112", -- [1]
      6, -- [2]
      2, -- [3]
      49024, -- [4]
    }, -- [57]
    {
      "Interface\\Icons\\Spell_Frost_FreezingBreath", -- [1]
      6, -- [2]
      3, -- [3]
      49188, -- [4]
    }, -- [58]
    {
      "Interface\\Icons\\Spell_Frost_Wisp", -- [1]
      7, -- [2]
      1, -- [3]
      50040, -- [4]
    }, -- [59]
    {
      "Interface\\Icons\\INV_Staff_15", -- [1]
      7, -- [2]
      2, -- [3]
      49203, -- [4]
    }, -- [60]
    {
      "Interface\\Icons\\Spell_Deathknight_FrostPresence", -- [1]
      7, -- [2]
      3, -- [3]
      50384, -- [4]
    }, -- [61]
    {
      "Interface\\Icons\\Ability_DualWieldSpecialization", -- [1]
      8, -- [2]
      1, -- [3]
      65661, -- [4]
    }, -- [62]
    {
      "Interface\\Icons\\INV_Weapon_Shortblade_79", -- [1]
      8, -- [2]
      2, -- [3]
      54639, -- [4]
    }, -- [63]
    {
      "Interface\\Icons\\INV_Armor_Helm_Plate_Naxxramas_RaidWarrior_C_01", -- [1]
      8, -- [2]
      3, -- [3]
      51271, -- [4]
    }, -- [64]
    {
      "Interface\\Icons\\Spell_Fire_ElementalDevastation", -- [1]
      9, -- [2]
      1, -- [3]
      49200, -- [4]
    }, -- [65]
    {
      "Interface\\Icons\\Spell_DeathKnight_EmpowerRuneBlade2", -- [1]
      9, -- [2]
      2, -- [3]
      49143, -- [4]
    }, -- [66]
    {
      "Interface\\Icons\\INV-Sword_53", -- [1]
      9, -- [2]
      3, -- [3]
      50187, -- [4]
    }, -- [67]
    {
      "Interface\\Icons\\Spell_Nature_Tranquility", -- [1]
      10, -- [2]
      2, -- [3]
      49202, -- [4]
    }, -- [68]
    {
      "Interface\\Icons\\Spell_Frost_ArcticWinds", -- [1]
      11, -- [2]
      2, -- [3]
      49184, -- [4]
    }, -- [69]
    nil, -- [70]
    nil, -- [71]
    nil, -- [72]
    nil, -- [73]
    nil, -- [74]
    nil, -- [75]
    nil, -- [76]
    nil, -- [77]
    nil, -- [78]
    nil, -- [79]
    nil, -- [80]
    {
      "Interface\\Icons\\Spell_Deathknight_PlagueStrike", -- [1]
      1, -- [2]
      1, -- [3]
      51745, -- [4]
    }, -- [81]
    {
      "Interface\\Icons\\Spell_Shadow_BurningSpirit", -- [1]
      1, -- [2]
      2, -- [3]
      48962, -- [4]
    }, -- [82]
    {
      "Interface\\Icons\\Spell_Nature_MirrorImage", -- [1]
      1, -- [2]
      3, -- [3]
      55129, -- [4]
    }, -- [83]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowWordPain", -- [1]
      2, -- [2]
      1, -- [3]
      49036, -- [4]
    }, -- [84]
    {
      "Interface\\Icons\\Spell_Shadow_DeathAndDecay", -- [1]
      2, -- [2]
      2, -- [3]
      48963, -- [4]
    }, -- [85]
    {
      "Interface\\Icons\\Spell_DeathKnight_Strangulate", -- [1]
      2, -- [2]
      3, -- [3]
      49588, -- [4]
    }, -- [86]
    {
      "Interface\\Icons\\Spell_DeathKnight_Gnaw_Ghoul", -- [1]
      2, -- [2]
      4, -- [3]
      48965, -- [4]
    }, -- [87]
    {
      "Interface\\Icons\\Spell_Shadow_PlagueCloud", -- [1]
      3, -- [2]
      1, -- [3]
      49013, -- [4]
    }, -- [88]
    {
      "Interface\\Icons\\INV_Weapon_Shortblade_60", -- [1]
      3, -- [2]
      2, -- [3]
      51459, -- [4]
    }, -- [89]
    {
      "Interface\\Icons\\Ability_Creature_Disease_02", -- [1]
      3, -- [2]
      3, -- [3]
      49158, -- [4]
    }, -- [90]
    {
      "Interface\\Icons\\Spell_DeathKnight_SummonDeathCharger", -- [1]
      4, -- [2]
      2, -- [3]
      49146, -- [4]
    }, -- [91]
    {
      "Interface\\Icons\\Ability_CriticalStrike", -- [1]
      4, -- [2]
      3, -- [3]
      49219, -- [4]
    }, -- [92]
    {
      "Interface\\Icons\\Spell_DeathKnight_ArmyOfTheDead", -- [1]
      4, -- [2]
      4, -- [3]
      55620, -- [4]
    }, -- [93]
    {
      "Interface\\Icons\\Spell_Shadow_Contagion", -- [1]
      5, -- [2]
      1, -- [3]
      49194, -- [4]
    }, -- [94]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowandFlame", -- [1]
      5, -- [2]
      2, -- [3]
      49220, -- [4]
    }, -- [95]
    {
      "Interface\\Icons\\Spell_Shadow_Shadesofdarkness", -- [1]
      5, -- [2]
      3, -- [3]
      49223, -- [4]
    }, -- [96]
    {
      "Interface\\Icons\\Spell_Shadow_Shadowfiend", -- [1]
      6, -- [2]
      1, -- [3]
      55666, -- [4]
    }, -- [97]
    {
      "Interface\\Icons\\Spell_Shadow_AntiMagicShell", -- [1]
      6, -- [2]
      2, -- [3]
      49224, -- [4]
    }, -- [98]
    {
      "Interface\\Icons\\Spell_Shadow_ShadeTrueSight", -- [1]
      6, -- [2]
      3, -- [3]
      49208, -- [4]
    }, -- [99]
    {
      "Interface\\Icons\\Spell_Shadow_AnimateDead", -- [1]
      6, -- [2]
      4, -- [3]
      52143, -- [4]
    }, -- [100]
    {
      "Interface\\Icons\\Spell_Shadow_UnholyFrenzy", -- [1]
      7, -- [2]
      1, -- [3]
      66799, -- [4]
    }, -- [101]
    {
      "Interface\\Icons\\Spell_DeathKnight_AntiMagicZone", -- [1]
      7, -- [2]
      2, -- [3]
      51052, -- [4]
    }, -- [102]
    {
      "Interface\\Icons\\Spell_Deathknight_UnholyPresence", -- [1]
      7, -- [2]
      3, -- [3]
      50391, -- [4]
    }, -- [103]
    {
      "Interface\\Icons\\Ability_GhoulFrenzy", -- [1]
      7, -- [2]
      4, -- [3]
      63560, -- [4]
    }, -- [104]
    {
      "Interface\\Icons\\Spell_Nature_NullifyDisease", -- [1]
      8, -- [2]
      2, -- [3]
      49032, -- [4]
    }, -- [105]
    {
      "Interface\\Icons\\INV_Chest_Leather_13", -- [1]
      8, -- [2]
      3, -- [3]
      49222, -- [4]
    }, -- [106]
    {
      "Interface\\Icons\\Spell_Shadow_CallofBone", -- [1]
      9, -- [2]
      1, -- [3]
      49217, -- [4]
    }, -- [107]
    {
      "Interface\\Icons\\Ability_Creature_Cursed_03", -- [1]
      9, -- [2]
      2, -- [3]
      51099, -- [4]
    }, -- [108]
    {
      "Interface\\Icons\\Spell_DeathKnight_ScourgeStrike", -- [1]
      9, -- [2]
      3, -- [3]
      55090, -- [4]
    }, -- [109]
    {
      "Interface\\Icons\\INV_Weapon_Halberd14", -- [1]
      10, -- [2]
      2, -- [3]
      50117, -- [4]
    }, -- [110]
    {
      "Interface\\Icons\\Ability_Hunter_Pet_Bat", -- [1]
      11, -- [2]
      2, -- [3]
      49206, -- [4]
    }, -- [111]
    nil, -- [112]
    nil, -- [113]
    nil, -- [114]
    nil, -- [115]
    nil, -- [116]
    nil, -- [117]
    nil, -- [118]
    nil, -- [119]
    nil, -- [120]
    {
      "DeathKnightBlood", -- [1]
      "DeathKnightFrost", -- [2]
      "DeathKnightUnholy", -- [3]
    }, -- [121]
  },
  ["DRUID"] = {
    {
      "Interface\\Icons\\Spell_Nature_AbolishMagic", -- [1]
      1, -- [2]
      1, -- [3]
      16814, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\Spell_Nature_NaturesWrath", -- [1]
      1, -- [2]
      2, -- [3]
      16689, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\Spell_Nature_NaturesWrath", -- [1]
      1, -- [2]
      3, -- [3]
      17245, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Spell_Nature_StrangleVines", -- [1]
      2, -- [2]
      1, -- [3]
      16918, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\INV_Staff_01", -- [1]
      2, -- [2]
      2, -- [3]
      35363, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\Spell_Nature_StarFall", -- [1]
      2, -- [2]
      3, -- [3]
      16821, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Spell_Nature_Thorns", -- [1]
      3, -- [2]
      1, -- [3]
      16836, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Spell_Nature_InsectSwarm", -- [1]
      3, -- [2]
      3, -- [3]
      5570, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\Spell_Nature_NatureTouchGrow", -- [1]
      3, -- [2]
      4, -- [3]
      16819, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Spell_Nature_Purge", -- [1]
      4, -- [2]
      2, -- [3]
      16909, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\Spell_Arcane_StarFire", -- [1]
      4, -- [2]
      3, -- [3]
      16850, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\Ability_Druid_LunarGuidance", -- [1]
      5, -- [2]
      1, -- [3]
      33589, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Spell_Nature_NaturesBlessing", -- [1]
      5, -- [2]
      2, -- [3]
      16880, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Spell_Nature_Sentinal", -- [1]
      5, -- [2]
      3, -- [3]
      16845, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\Spell_Nature_MoonGlow", -- [1]
      6, -- [2]
      2, -- [3]
      16896, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\Ability_Druid_BalanceofPower", -- [1]
      6, -- [2]
      3, -- [3]
      33592, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Ability_Druid_Dreamstate", -- [1]
      7, -- [2]
      1, -- [3]
      33597, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Spell_Nature_ForceOfNature", -- [1]
      7, -- [2]
      2, -- [3]
      24858, -- [4]
    }, -- [18]
    {
      "Interface\\Icons\\Spell_Nature_FaerieFire", -- [1]
      7, -- [2]
      3, -- [3]
      33600, -- [4]
    }, -- [19]
    {
      "Interface\\Icons\\Ability_Druid_TwilightsWrath", -- [1]
      8, -- [2]
      2, -- [3]
      33603, -- [4]
    }, -- [20]
    {
      "Interface\\Icons\\Ability_Druid_ForceofNature", -- [1]
      9, -- [2]
      2, -- [3]
      33831, -- [4]
    }, -- [21]
    nil, -- [22]
    nil, -- [23]
    nil, -- [24]
    nil, -- [25]
    nil, -- [26]
    nil, -- [27]
    nil, -- [28]
    nil, -- [29]
    nil, -- [30]
    nil, -- [31]
    nil, -- [32]
    nil, -- [33]
    nil, -- [34]
    nil, -- [35]
    nil, -- [36]
    nil, -- [37]
    nil, -- [38]
    nil, -- [39]
    nil, -- [40]
    {
      "Interface\\Icons\\Ability_Hunter_Pet_Hyena", -- [1]
      1, -- [2]
      2, -- [3]
      16934, -- [4]
    }, -- [41]
    {
      "Interface\\Icons\\Ability_Druid_DemoralizingRoar", -- [1]
      1, -- [2]
      3, -- [3]
      16858, -- [4]
    }, -- [42]
    {
      "Interface\\Icons\\Ability_Ambush", -- [1]
      2, -- [2]
      1, -- [3]
      16947, -- [4]
    }, -- [43]
    {
      "Interface\\Icons\\Ability_Druid_Bash", -- [1]
      2, -- [2]
      2, -- [3]
      16940, -- [4]
    }, -- [44]
    {
      "Interface\\Icons\\INV_Misc_Pelt_Bear_03", -- [1]
      2, -- [2]
      3, -- [3]
      16929, -- [4]
    }, -- [45]
    {
      "Interface\\Icons\\Spell_Nature_SpiritWolf", -- [1]
      3, -- [2]
      1, -- [3]
      17002, -- [4]
    }, -- [46]
    {
      "Interface\\Icons\\Ability_Hunter_Pet_Bear", -- [1]
      3, -- [2]
      2, -- [3]
      16979, -- [4]
    }, -- [47]
    {
      "Interface\\Icons\\INV_Misc_MonsterClaw_04", -- [1]
      3, -- [2]
      3, -- [3]
      16942, -- [4]
    }, -- [48]
    {
      "Interface\\Icons\\Spell_Shadow_VampiricAura", -- [1]
      4, -- [2]
      1, -- [3]
      16966, -- [4]
    }, -- [49]
    {
      "Interface\\Icons\\Ability_Hunter_Pet_Cat", -- [1]
      4, -- [2]
      2, -- [3]
      16972, -- [4]
    }, -- [50]
    {
      "Interface\\Icons\\Ability_Racial_Cannibalize", -- [1]
      4, -- [2]
      3, -- [3]
      37116, -- [4]
    }, -- [51]
    {
      "Interface\\Icons\\Ability_Druid_Ravage", -- [1]
      5, -- [2]
      1, -- [3]
      16998, -- [4]
    }, -- [52]
    {
      "Interface\\Icons\\Spell_Nature_FaerieFire", -- [1]
      5, -- [2]
      3, -- [3]
      16857, -- [4]
    }, -- [53]
    {
      "Interface\\Icons\\Ability_Druid_HealingInstincts", -- [1]
      5, -- [2]
      4, -- [3]
      33872, -- [4]
    }, -- [54]
    {
      "Interface\\Icons\\Spell_Holy_BlessingOfAgility", -- [1]
      6, -- [2]
      2, -- [3]
      17003, -- [4]
    }, -- [55]
    {
      "Interface\\Icons\\Ability_Druid_Enrage", -- [1]
      6, -- [2]
      3, -- [3]
      33853, -- [4]
    }, -- [56]
    {
      "Interface\\Icons\\Ability_Druid_PrimalTenacity", -- [1]
      7, -- [2]
      1, -- [3]
      33851, -- [4]
    }, -- [57]
    {
      "Interface\\Icons\\Spell_Nature_UnyeildingStamina", -- [1]
      7, -- [2]
      2, -- [3]
      17007, -- [4]
    }, -- [58]
    {
      "Interface\\Icons\\Spell_Nature_UnyeildingStamina", -- [1]
      7, -- [2]
      3, -- [3]
      34297, -- [4]
    }, -- [59]
    {
      "Interface\\Icons\\Ability_Druid_PredatoryInstincts", -- [1]
      8, -- [2]
      3, -- [3]
      33859, -- [4]
    }, -- [60]
    {
      "Interface\\Icons\\Ability_Druid_Mangle2", -- [1]
      9, -- [2]
      2, -- [3]
      33917, -- [4]
    }, -- [61]
    nil, -- [62]
    nil, -- [63]
    nil, -- [64]
    nil, -- [65]
    nil, -- [66]
    nil, -- [67]
    nil, -- [68]
    nil, -- [69]
    nil, -- [70]
    nil, -- [71]
    nil, -- [72]
    nil, -- [73]
    nil, -- [74]
    nil, -- [75]
    nil, -- [76]
    nil, -- [77]
    nil, -- [78]
    nil, -- [79]
    nil, -- [80]
    {
      "Interface\\Icons\\Spell_Nature_Regeneration", -- [1]
      1, -- [2]
      2, -- [3]
      17050, -- [4]
    }, -- [81]
    {
      "Interface\\Icons\\Spell_Holy_BlessingOfStamina", -- [1]
      1, -- [2]
      3, -- [3]
      17056, -- [4]
    }, -- [82]
    {
      "Interface\\Icons\\Spell_Nature_HealingTouch", -- [1]
      2, -- [2]
      1, -- [3]
      17069, -- [4]
    }, -- [83]
    {
      "Interface\\Icons\\Spell_Nature_HealingWaveGreater", -- [1]
      2, -- [2]
      2, -- [3]
      17063, -- [4]
    }, -- [84]
    {
      "Interface\\Icons\\Spell_Nature_WispSplode", -- [1]
      2, -- [2]
      3, -- [3]
      16833, -- [4]
    }, -- [85]
    {
      "Interface\\Icons\\Spell_Frost_WindWalkOn", -- [1]
      3, -- [2]
      1, -- [3]
      17106, -- [4]
    }, -- [86]
    {
      "Interface\\Icons\\Ability_EyeOfTheOwl", -- [1]
      3, -- [2]
      2, -- [3]
      17118, -- [4]
    }, -- [87]
    {
      "Interface\\Icons\\Spell_Nature_CrystalBall", -- [1]
      3, -- [2]
      3, -- [3]
      16864, -- [4]
    }, -- [88]
    {
      "Interface\\Icons\\Spell_Holy_ElunesGrace", -- [1]
      4, -- [2]
      2, -- [3]
      24968, -- [4]
    }, -- [89]
    {
      "Interface\\Icons\\Spell_Nature_Rejuvenation", -- [1]
      4, -- [2]
      3, -- [3]
      17111, -- [4]
    }, -- [90]
    {
      "Interface\\Icons\\Spell_Nature_RavenForm", -- [1]
      5, -- [2]
      1, -- [3]
      17116, -- [4]
    }, -- [91]
    {
      "Interface\\Icons\\Spell_Nature_ProtectionformNature", -- [1]
      5, -- [2]
      2, -- [3]
      17104, -- [4]
    }, -- [92]
    {
      "Interface\\Icons\\Spell_Nature_Tranquility", -- [1]
      5, -- [2]
      4, -- [3]
      17123, -- [4]
    }, -- [93]
    {
      "Interface\\Icons\\Ability_Druid_EmpoweredTouch", -- [1]
      6, -- [2]
      1, -- [3]
      33879, -- [4]
    }, -- [94]
    {
      "Interface\\Icons\\Spell_Nature_ResistNature", -- [1]
      6, -- [2]
      3, -- [3]
      17074, -- [4]
    }, -- [95]
    {
      "Interface\\Icons\\Spell_Nature_GiftoftheWaterSpirit", -- [1]
      7, -- [2]
      1, -- [3]
      34151, -- [4]
    }, -- [96]
    {
      "Interface\\Icons\\INV_Relics_IdolofRejuvenation", -- [1]
      7, -- [2]
      2, -- [3]
      18562, -- [4]
    }, -- [97]
    {
      "Interface\\Icons\\Ability_Druid_NaturalPerfection", -- [1]
      7, -- [2]
      3, -- [3]
      33881, -- [4]
    }, -- [98]
    {
      "Interface\\Icons\\Ability_Druid_EmpoweredRejuvination", -- [1]
      8, -- [2]
      2, -- [3]
      33886, -- [4]
    }, -- [99]
    {
      "Interface\\Icons\\Ability_Druid_TreeofLife", -- [1]
      9, -- [2]
      2, -- [3]
      33891, -- [4]
    }, -- [100]
    nil, -- [101]
    nil, -- [102]
    nil, -- [103]
    nil, -- [104]
    nil, -- [105]
    nil, -- [106]
    nil, -- [107]
    nil, -- [108]
    nil, -- [109]
    nil, -- [110]
    nil, -- [111]
    nil, -- [112]
    nil, -- [113]
    nil, -- [114]
    nil, -- [115]
    nil, -- [116]
    nil, -- [117]
    nil, -- [118]
    nil, -- [119]
    nil, -- [120]
    {
      "DruidBalance", -- [1]
      "DruidFeralCombat", -- [2]
      "DruidRestoration", -- [3]
    }, -- [121]
  },
  ["PALADIN"] = {
    {
      "Interface\\Icons\\Ability_GolemThunderClap", -- [1]
      1, -- [2]
      2, -- [3]
      20262, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\Spell_Nature_Sleep", -- [1]
      1, -- [2]
      3, -- [3]
      20257, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\Spell_Arcane_Blink", -- [1]
      2, -- [2]
      2, -- [3]
      20205, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Ability_ThunderBolt", -- [1]
      2, -- [2]
      3, -- [3]
      20224, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\Spell_Holy_HolyBolt", -- [1]
      3, -- [2]
      1, -- [3]
      20237, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\Spell_Holy_AuraMastery", -- [1]
      3, -- [2]
      2, -- [3]
      31821, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Spell_Holy_LayOnHands", -- [1]
      3, -- [2]
      3, -- [3]
      20234, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Spell_Holy_UnyieldingFaith", -- [1]
      3, -- [2]
      4, -- [3]
      9453, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\Spell_Holy_GreaterHeal", -- [1]
      4, -- [2]
      2, -- [3]
      20210, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Spell_Holy_SealOfWisdom", -- [1]
      4, -- [2]
      3, -- [3]
      20244, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\Spell_Holy_PureOfHeart", -- [1]
      5, -- [2]
      1, -- [3]
      31822, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\Spell_Holy_Heal", -- [1]
      5, -- [2]
      2, -- [3]
      20216, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Spell_Holy_HealingAura", -- [1]
      5, -- [2]
      3, -- [3]
      20359, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Spell_Holy_PurifyingPower", -- [1]
      6, -- [2]
      1, -- [3]
      31825, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\Spell_Holy_Power", -- [1]
      6, -- [2]
      3, -- [3]
      5923, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\Spell_Holy_LightsGrace", -- [1]
      7, -- [2]
      1, -- [3]
      31833, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Spell_Holy_SearingLight", -- [1]
      7, -- [2]
      2, -- [3]
      20473, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Spell_Holy_BlessedLife", -- [1]
      7, -- [2]
      3, -- [3]
      31828, -- [4]
    }, -- [18]
    {
      "Interface\\Icons\\Spell_Holy_HolyGuidance", -- [1]
      8, -- [2]
      2, -- [3]
      31837, -- [4]
    }, -- [19]
    {
      "Interface\\Icons\\Spell_Holy_DivineIllumination", -- [1]
      9, -- [2]
      2, -- [3]
      31842, -- [4]
    }, -- [20]
    nil, -- [21]
    nil, -- [22]
    nil, -- [23]
    nil, -- [24]
    nil, -- [25]
    nil, -- [26]
    nil, -- [27]
    nil, -- [28]
    nil, -- [29]
    nil, -- [30]
    nil, -- [31]
    nil, -- [32]
    nil, -- [33]
    nil, -- [34]
    nil, -- [35]
    nil, -- [36]
    nil, -- [37]
    nil, -- [38]
    nil, -- [39]
    nil, -- [40]
    {
      "Interface\\Icons\\Spell_Holy_DevotionAura", -- [1]
      1, -- [2]
      2, -- [3]
      20138, -- [4]
    }, -- [41]
    {
      "Interface\\Icons\\Ability_Defend", -- [1]
      1, -- [2]
      3, -- [3]
      20127, -- [4]
    }, -- [42]
    {
      "Interface\\Icons\\Ability_Rogue_Ambush", -- [1]
      2, -- [2]
      1, -- [3]
      20189, -- [4]
    }, -- [43]
    {
      "Interface\\Icons\\Spell_Holy_SealOfProtection", -- [1]
      2, -- [2]
      2, -- [3]
      20174, -- [4]
    }, -- [44]
    {
      "Interface\\Icons\\Spell_Holy_Devotion", -- [1]
      2, -- [2]
      4, -- [3]
      20143, -- [4]
    }, -- [45]
    {
      "Interface\\Icons\\Spell_Magic_MageArmor", -- [1]
      3, -- [2]
      1, -- [3]
      20217, -- [4]
    }, -- [46]
    {
      "Interface\\Icons\\Spell_Holy_SealOfFury", -- [1]
      3, -- [2]
      2, -- [3]
      20468, -- [4]
    }, -- [47]
    {
      "Interface\\Icons\\INV_Shield_06", -- [1]
      3, -- [2]
      3, -- [3]
      20148, -- [4]
    }, -- [48]
    {
      "Interface\\Icons\\Spell_Magic_LesserInvisibilty", -- [1]
      3, -- [2]
      4, -- [3]
      20096, -- [4]
    }, -- [49]
    {
      "Interface\\Icons\\Spell_Holy_Stoicism", -- [1]
      4, -- [2]
      1, -- [3]
      31844, -- [4]
    }, -- [50]
    {
      "Interface\\Icons\\Spell_Holy_SealOfMight", -- [1]
      4, -- [2]
      2, -- [3]
      20487, -- [4]
    }, -- [51]
    {
      "Interface\\Icons\\Spell_Holy_MindSooth", -- [1]
      4, -- [2]
      3, -- [3]
      20254, -- [4]
    }, -- [52]
    {
      "Interface\\Icons\\Spell_Holy_ImprovedResistanceAuras", -- [1]
      5, -- [2]
      1, -- [3]
      31846, -- [4]
    }, -- [53]
    {
      "Interface\\Icons\\Spell_Nature_LightningShield", -- [1]
      5, -- [2]
      2, -- [3]
      20911, -- [4]
    }, -- [54]
    {
      "Interface\\Icons\\Spell_Holy_BlessingOfStrength", -- [1]
      5, -- [2]
      3, -- [3]
      20177, -- [4]
    }, -- [55]
    {
      "Interface\\Icons\\Spell_Holy_DivineIntervention", -- [1]
      6, -- [2]
      1, -- [3]
      31848, -- [4]
    }, -- [56]
    {
      "Interface\\Icons\\INV_Sword_20", -- [1]
      6, -- [2]
      3, -- [3]
      20196, -- [4]
    }, -- [57]
    {
      "Interface\\Icons\\Spell_Holy_BlessingOfProtection", -- [1]
      7, -- [2]
      1, -- [3]
      41021, -- [4]
    }, -- [58]
    {
      "Interface\\Icons\\Spell_Holy_BlessingOfProtection", -- [1]
      7, -- [2]
      2, -- [3]
      20925, -- [4]
    }, -- [59]
    {
      "Interface\\Icons\\Spell_Holy_ArdentDefender", -- [1]
      7, -- [2]
      3, -- [3]
      31850, -- [4]
    }, -- [60]
    {
      "Interface\\Icons\\Spell_Holy_WeaponMastery", -- [1]
      8, -- [2]
      3, -- [3]
      31858, -- [4]
    }, -- [61]
    {
      "Interface\\Icons\\Spell_Holy_AvengersShield", -- [1]
      9, -- [2]
      2, -- [3]
      31935, -- [4]
    }, -- [62]
    nil, -- [63]
    nil, -- [64]
    nil, -- [65]
    nil, -- [66]
    nil, -- [67]
    nil, -- [68]
    nil, -- [69]
    nil, -- [70]
    nil, -- [71]
    nil, -- [72]
    nil, -- [73]
    nil, -- [74]
    nil, -- [75]
    nil, -- [76]
    nil, -- [77]
    nil, -- [78]
    nil, -- [79]
    nil, -- [80]
    {
      "Interface\\Icons\\Spell_Holy_FistOfJustice", -- [1]
      1, -- [2]
      2, -- [3]
      20042, -- [4]
    }, -- [81]
    {
      "Interface\\Icons\\Spell_Frost_WindWalkOn", -- [1]
      1, -- [2]
      3, -- [3]
      20101, -- [4]
    }, -- [82]
    {
      "Interface\\Icons\\Spell_Holy_RighteousFury", -- [1]
      2, -- [2]
      1, -- [3]
      25956, -- [4]
    }, -- [83]
    {
      "Interface\\Icons\\Spell_Holy_HolySmite", -- [1]
      2, -- [2]
      2, -- [3]
      20335, -- [4]
    }, -- [84]
    {
      "Interface\\Icons\\Ability_Parry", -- [1]
      2, -- [2]
      3, -- [3]
      20060, -- [4]
    }, -- [85]
    {
      "Interface\\Icons\\Spell_Holy_Vindication", -- [1]
      3, -- [2]
      1, -- [3]
      9452, -- [4]
    }, -- [86]
    {
      "Interface\\Icons\\Spell_Holy_RetributionAura", -- [1]
      3, -- [2]
      2, -- [3]
      20117, -- [4]
    }, -- [87]
    {
      "Interface\\Icons\\Ability_Warrior_InnerRage", -- [1]
      3, -- [2]
      3, -- [3]
      20375, -- [4]
    }, -- [88]
    {
      "Interface\\Icons\\Spell_Holy_PersuitofJustice", -- [1]
      3, -- [2]
      4, -- [3]
      26022, -- [4]
    }, -- [89]
    {
      "Interface\\Icons\\Spell_Holy_EyeforanEye", -- [1]
      4, -- [2]
      1, -- [3]
      9799, -- [4]
    }, -- [90]
    {
      "Interface\\Icons\\Spell_Holy_AuraOfLight", -- [1]
      4, -- [2]
      3, -- [3]
      20091, -- [4]
    }, -- [91]
    {
      "Interface\\Icons\\Spell_Holy_Crusade", -- [1]
      4, -- [2]
      4, -- [3]
      31866, -- [4]
    }, -- [92]
    {
      "Interface\\Icons\\INV_Hammer_04", -- [1]
      5, -- [2]
      1, -- [3]
      20111, -- [4]
    }, -- [93]
    {
      "Interface\\Icons\\Spell_Holy_MindVision", -- [1]
      5, -- [2]
      3, -- [3]
      20218, -- [4]
    }, -- [94]
    {
      "Interface\\Icons\\Spell_Holy_MindVision", -- [1]
      5, -- [2]
      4, -- [3]
      31869, -- [4]
    }, -- [95]
    {
      "Interface\\Icons\\Ability_Racial_Avatar", -- [1]
      6, -- [2]
      2, -- [3]
      20049, -- [4]
    }, -- [96]
    {
      "Interface\\Icons\\Spell_Holy_RighteousFury", -- [1]
      6, -- [2]
      3, -- [3]
      31876, -- [4]
    }, -- [97]
    {
      "Interface\\Icons\\Spell_Holy_HolySmite", -- [1]
      7, -- [2]
      1, -- [3]
      32043, -- [4]
    }, -- [98]
    {
      "Interface\\Icons\\Spell_Holy_PrayerOfHealing", -- [1]
      7, -- [2]
      2, -- [3]
      20066, -- [4]
    }, -- [99]
    {
      "Interface\\Icons\\Spell_Holy_DivinePurpose", -- [1]
      7, -- [2]
      3, -- [3]
      31871, -- [4]
    }, -- [100]
    {
      "Interface\\Icons\\Spell_Holy_Fanaticism", -- [1]
      8, -- [2]
      2, -- [3]
      31879, -- [4]
    }, -- [101]
    {
      "Interface\\Icons\\Spell_Holy_CrusaderStrike", -- [1]
      9, -- [2]
      2, -- [3]
      35395, -- [4]
    }, -- [102]
    nil, -- [103]
    nil, -- [104]
    nil, -- [105]
    nil, -- [106]
    nil, -- [107]
    nil, -- [108]
    nil, -- [109]
    nil, -- [110]
    nil, -- [111]
    nil, -- [112]
    nil, -- [113]
    nil, -- [114]
    nil, -- [115]
    nil, -- [116]
    nil, -- [117]
    nil, -- [118]
    nil, -- [119]
    nil, -- [120]
    {
      "PaladinHoly", -- [1]
      "PaladinProtection", -- [2]
      "PaladinCombat", -- [3]
    }, -- [121]
  },
  ["ROGUE"] = {
    {
      "Interface\\Icons\\Ability_Rogue_Eviscerate", -- [1]
      1, -- [2]
      1, -- [3]
      14162, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\Ability_FiegnDead", -- [1]
      1, -- [2]
      2, -- [3]
      14144, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\Ability_Racial_BloodRage", -- [1]
      1, -- [2]
      3, -- [3]
      14138, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Ability_Druid_Disembowel", -- [1]
      2, -- [2]
      1, -- [3]
      14156, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\Spell_Shadow_DeathScream", -- [1]
      2, -- [2]
      2, -- [3]
      14158, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\Ability_BackStab", -- [1]
      2, -- [2]
      4, -- [3]
      13733, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Ability_Warrior_DecisiveStrike", -- [1]
      3, -- [2]
      1, -- [3]
      14179, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Ability_Warrior_Riposte", -- [1]
      3, -- [2]
      2, -- [3]
      14168, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\Ability_CriticalStrike", -- [1]
      3, -- [2]
      3, -- [3]
      14128, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Ability_Rogue_FeignDeath", -- [1]
      4, -- [2]
      2, -- [3]
      16513, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\Ability_Poisons", -- [1]
      4, -- [2]
      3, -- [3]
      14113, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\Ability_Rogue_FleetFooted", -- [1]
      5, -- [2]
      1, -- [3]
      31208, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Spell_Ice_Lament", -- [1]
      5, -- [2]
      2, -- [3]
      14177, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Ability_Rogue_KidneyShot", -- [1]
      5, -- [2]
      3, -- [3]
      14174, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\Ability_Rogue_QuickRecovery", -- [1]
      5, -- [2]
      4, -- [3]
      31244, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\Spell_Shadow_ChillTouch", -- [1]
      6, -- [2]
      2, -- [3]
      14186, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Ability_Creature_Poison_06", -- [1]
      6, -- [2]
      3, -- [3]
      31226, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Spell_Nature_EarthBindTotem", -- [1]
      7, -- [2]
      2, -- [3]
      14983, -- [4]
    }, -- [18]
    {
      "Interface\\Icons\\Ability_Rogue_DeadenedNerves", -- [1]
      7, -- [2]
      3, -- [3]
      31380, -- [4]
    }, -- [19]
    {
      "Interface\\Icons\\Ability_Rogue_FindWeakness", -- [1]
      8, -- [2]
      3, -- [3]
      31233, -- [4]
    }, -- [20]
    {
      "Interface\\Icons\\Ability_Rogue_ShadowStrikes", -- [1]
      9, -- [2]
      2, -- [3]
      1329, -- [4]
    }, -- [21]
    nil, -- [22]
    nil, -- [23]
    nil, -- [24]
    nil, -- [25]
    nil, -- [26]
    nil, -- [27]
    nil, -- [28]
    nil, -- [29]
    nil, -- [30]
    nil, -- [31]
    nil, -- [32]
    nil, -- [33]
    nil, -- [34]
    nil, -- [35]
    nil, -- [36]
    nil, -- [37]
    nil, -- [38]
    nil, -- [39]
    nil, -- [40]
    {
      "Interface\\Icons\\Ability_Gouge", -- [1]
      1, -- [2]
      1, -- [3]
      13741, -- [4]
    }, -- [41]
    {
      "Interface\\Icons\\Spell_Shadow_RitualOfSacrifice", -- [1]
      1, -- [2]
      2, -- [3]
      13732, -- [4]
    }, -- [42]
    {
      "Interface\\Icons\\Spell_Nature_Invisibilty", -- [1]
      1, -- [2]
      3, -- [3]
      13712, -- [4]
    }, -- [43]
    {
      "Interface\\Icons\\Ability_Rogue_SliceDice", -- [1]
      2, -- [2]
      1, -- [3]
      14165, -- [4]
    }, -- [44]
    {
      "Interface\\Icons\\Ability_Parry", -- [1]
      2, -- [2]
      2, -- [3]
      13713, -- [4]
    }, -- [45]
    {
      "Interface\\Icons\\Ability_Marksmanship", -- [1]
      2, -- [2]
      3, -- [3]
      13705, -- [4]
    }, -- [46]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowWard", -- [1]
      3, -- [2]
      1, -- [3]
      13742, -- [4]
    }, -- [47]
    {
      "Interface\\Icons\\Ability_Warrior_Challange", -- [1]
      3, -- [2]
      2, -- [3]
      14251, -- [4]
    }, -- [48]
    {
      "Interface\\Icons\\Ability_Rogue_Sprint", -- [1]
      3, -- [2]
      4, -- [3]
      13743, -- [4]
    }, -- [49]
    {
      "Interface\\Icons\\Ability_Kick", -- [1]
      4, -- [2]
      1, -- [3]
      13754, -- [4]
    }, -- [50]
    {
      "Interface\\Icons\\INV_Weapon_ShortBlade_05", -- [1]
      4, -- [2]
      2, -- [3]
      13706, -- [4]
    }, -- [51]
    {
      "Interface\\Icons\\Ability_DualWield", -- [1]
      4, -- [2]
      3, -- [3]
      13715, -- [4]
    }, -- [52]
    {
      "Interface\\Icons\\INV_Mace_01", -- [1]
      5, -- [2]
      1, -- [3]
      13709, -- [4]
    }, -- [53]
    {
      "Interface\\Icons\\Ability_Warrior_PunishingBlow", -- [1]
      5, -- [2]
      2, -- [3]
      13877, -- [4]
    }, -- [54]
    {
      "Interface\\Icons\\INV_Sword_27", -- [1]
      5, -- [2]
      3, -- [3]
      13960, -- [4]
    }, -- [55]
    {
      "Interface\\Icons\\INV_Gauntlets_04", -- [1]
      5, -- [2]
      4, -- [3]
      13707, -- [4]
    }, -- [56]
    {
      "Interface\\Icons\\Ability_Rogue_BladeTwisting", -- [1]
      6, -- [2]
      1, -- [3]
      31124, -- [4]
    }, -- [57]
    {
      "Interface\\Icons\\Spell_Holy_BlessingOfStrength", -- [1]
      6, -- [2]
      2, -- [3]
      30919, -- [4]
    }, -- [58]
    {
      "Interface\\Icons\\Ability_Racial_Avatar", -- [1]
      6, -- [2]
      3, -- [3]
      18427, -- [4]
    }, -- [59]
    {
      "Interface\\Icons\\Ability_Warrior_Revenge", -- [1]
      7, -- [2]
      1, -- [3]
      31122, -- [4]
    }, -- [60]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowWordDominate", -- [1]
      7, -- [2]
      2, -- [3]
      13750, -- [4]
    }, -- [61]
    {
      "Interface\\Icons\\Ability_Rogue_NervesOfSteel", -- [1]
      7, -- [2]
      3, -- [3]
      31130, -- [4]
    }, -- [62]
    {
      "Interface\\Icons\\INV_Weapon_Shortblade_38", -- [1]
      8, -- [2]
      3, -- [3]
      35541, -- [4]
    }, -- [63]
    {
      "Interface\\Icons\\Ability_Rogue_SurpriseAttack", -- [1]
      9, -- [2]
      2, -- [3]
      32601, -- [4]
    }, -- [64]
    nil, -- [65]
    nil, -- [66]
    nil, -- [67]
    nil, -- [68]
    nil, -- [69]
    nil, -- [70]
    nil, -- [71]
    nil, -- [72]
    nil, -- [73]
    nil, -- [74]
    nil, -- [75]
    nil, -- [76]
    nil, -- [77]
    nil, -- [78]
    nil, -- [79]
    nil, -- [80]
    {
      "Interface\\Icons\\Spell_Shadow_Charm", -- [1]
      1, -- [2]
      2, -- [3]
      13958, -- [4]
    }, -- [81]
    {
      "Interface\\Icons\\Ability_Warrior_WarCry", -- [1]
      1, -- [2]
      3, -- [3]
      14057, -- [4]
    }, -- [82]
    {
      "Interface\\Icons\\Ability_Rogue_Feint", -- [1]
      2, -- [2]
      1, -- [3]
      30892, -- [4]
    }, -- [83]
    {
      "Interface\\Icons\\Ability_Sap", -- [1]
      2, -- [2]
      2, -- [3]
      14076, -- [4]
    }, -- [84]
    {
      "Interface\\Icons\\Ability_Stealth", -- [1]
      2, -- [2]
      3, -- [3]
      13975, -- [4]
    }, -- [85]
    {
      "Interface\\Icons\\Spell_Shadow_Fumble", -- [1]
      3, -- [2]
      1, -- [3]
      13976, -- [4]
    }, -- [86]
    {
      "Interface\\Icons\\Spell_Shadow_Curse", -- [1]
      3, -- [2]
      2, -- [3]
      14278, -- [4]
    }, -- [87]
    {
      "Interface\\Icons\\Ability_Rogue_Ambush", -- [1]
      3, -- [2]
      3, -- [3]
      14079, -- [4]
    }, -- [88]
    {
      "Interface\\Icons\\Spell_Nature_MirrorImage", -- [1]
      4, -- [2]
      1, -- [3]
      13983, -- [4]
    }, -- [89]
    {
      "Interface\\Icons\\Spell_Magic_LesserInvisibilty", -- [1]
      4, -- [2]
      2, -- [3]
      13981, -- [4]
    }, -- [90]
    {
      "Interface\\Icons\\INV_Sword_17", -- [1]
      4, -- [2]
      3, -- [3]
      14171, -- [4]
    }, -- [91]
    {
      "Interface\\Icons\\Ability_Ambush", -- [1]
      5, -- [2]
      1, -- [3]
      30894, -- [4]
    }, -- [92]
    {
      "Interface\\Icons\\Spell_Shadow_AntiShadow", -- [1]
      5, -- [2]
      2, -- [3]
      14185, -- [4]
    }, -- [93]
    {
      "Interface\\Icons\\Spell_Shadow_SummonSuccubus", -- [1]
      5, -- [2]
      3, -- [3]
      14082, -- [4]
    }, -- [94]
    {
      "Interface\\Icons\\Spell_Shadow_LifeDrain", -- [1]
      5, -- [2]
      4, -- [3]
      16511, -- [4]
    }, -- [95]
    {
      "Interface\\Icons\\Ability_Rogue_MasterOfSubtlety", -- [1]
      6, -- [2]
      1, -- [3]
      31221, -- [4]
    }, -- [96]
    {
      "Interface\\Icons\\INV_Weapon_Crossbow_11", -- [1]
      6, -- [2]
      3, -- [3]
      30902, -- [4]
    }, -- [97]
    {
      "Interface\\Icons\\Ability_Rogue_EnvelopingShadows", -- [1]
      7, -- [2]
      1, -- [3]
      31211, -- [4]
    }, -- [98]
    {
      "Interface\\Icons\\Spell_Shadow_Possession", -- [1]
      7, -- [2]
      2, -- [3]
      14183, -- [4]
    }, -- [99]
    {
      "Interface\\Icons\\Ability_Rogue_CheatDeath", -- [1]
      7, -- [2]
      3, -- [3]
      31228, -- [4]
    }, -- [100]
    {
      "Interface\\Icons\\Ability_Rogue_SinisterCalling", -- [1]
      8, -- [2]
      2, -- [3]
      31216, -- [4]
    }, -- [101]
    {
      "Interface\\Icons\\Ability_Rogue_Shadowstep", -- [1]
      9, -- [2]
      2, -- [3]
      36554, -- [4]
    }, -- [102]
    nil, -- [103]
    nil, -- [104]
    nil, -- [105]
    nil, -- [106]
    nil, -- [107]
    nil, -- [108]
    nil, -- [109]
    nil, -- [110]
    nil, -- [111]
    nil, -- [112]
    nil, -- [113]
    nil, -- [114]
    nil, -- [115]
    nil, -- [116]
    nil, -- [117]
    nil, -- [118]
    nil, -- [119]
    nil, -- [120]
    {
      "RogueAssassination", -- [1]
      "RogueCombat", -- [2]
      "RogueSubtlety", -- [3]
    }, -- [121]
  },
}
