_uid = _this select 0;
_name = _this select 1;

// get a reference of the current object (unit) being connected
_unit = objNull;
{
	if ((isPlayer _x) and (_uid == getPlayerUID _x)) then {
		_unit = _x;
	};
}forEach playableUnits;

//list of units (editor placed)
_slotsA = [CommunitySlot,CommunitySlot1,CommunitySlot2,CommunitySlot3,CommunitySlot4,CommunitySlot5,CommunitySlot6,CommunitySlot7,CommunitySlot8,CommunitySlot9,CommunitySlot10];
//_slotsB = [wslot41];


//list of UIDs on A slots
_masterUIDArray = [
"76561198001220177", // MaDmaX
"76561198052066770", // Bens
"76561198014083847", // Conlly
"76561198085131553", // Saif
"76561197970635121", // Supergrover
"76561198038859952", // Inc
"76561198041032176", // Bearcage
"76561198024647478", // Warzin
"76561198059631680", // Dodge
"76561197970674234", // TeddyTornado
"76561197970331362", // Albert
"76561198091308379", // mad-rooky
"76561198027719822", // Mr.Max
"76561198087042085", // Sgt.Hudson
"76561198041095355", // xEaZzYx
"76561198047136273", // ManAtArmZ
"76561197993149332", // Dette
"76561197963632012", // mmda
"76561197987221249", // ForgottenOne
"76561198015582009", // BioEnigma
"76561198082556360", // Tallakah
"76561198010814947", // CeTe
"76561198059755146", // DarkStar
"76561197990154182", // [SFW]MiNdFlY
"76561197968900935", // [SFW]Leopard
"76561198011075362", // OF-10.Fumaffu
"76561197961307405", // sn4p
"76561198082717130", // Sophia
"76561198065712815", // Amer WF
"76561198016580433", // DaBoss985 160th~SOAR
"76561198050255265", // Anton
"76561198023377688", // jnm
"76561198040386322", // ZnakeEYE
"76561198049595715", // Vaulter
"76561198027095650", // Dazen Ti
"76561198103414142", // SuperOldboy
"76561198000243935", // ToMaSoN
"76561198045219363", // Branko
"76561198027172485", // Xamber
"76561197994446874", // Genistu
"76561198049407668", // Valetudo
"76561198001492406", // Kaiii3
"76561197961292252", // Niago
"76561198069983976", // xXFallingDeathXx
"76561197976933895", // Smoky
"76561197997586232", // Mitt
"76561197960516140", // Snake
"76561197979449322", // Hallutoxic
"76561198054418283", // TheFork1337
"76561198001014887", // Fabian
"76561198012174053", // King Crimson
"76561198090153937", // Eico
"76561198056952251", // King-Squad
"76561198038082301", // Rkay
"76561198104772680", // fLUFF
"76561197979787938", // Teugata NL
"76561198037843869", // Replax
"76561198055375034", // Irreversible
"76561198020338616", // stef 
"76561198077620751", // He4deX
"76561197966620466", // Wofu
"76561197972462692", // Rikko
"76561198056952251", // King-Squad
"76561197995468109", // Livedeath
"76561197981756455", // SPIKE
"76561198022708761", // NayJi
"76561197996704853", // Cylon2
"76561197980228989", // Rachmaniaroff
"76561197960370731", // Bannock
"76561198072967368", // GunnerySgt.Hardmen
"76561198059340945", // Baronbierbauch
"76561197992476233", // Organner
"76561198034148614", // Ustas
"76561198002890764", // Keketzo
"76561198039374960", // gil_1
"76561198019198314", // graa
"76561198026536474", // SgtMeidera
"76561198015598620", // RaptorX
"76561198018341721", // Gnertzl
"76561198016922458", // qcumba
"76561198041394771", // NekoSteamBoy
"76561198081700932", // Dominik
"76561197990172019", // Kolondor
"76561198111349016", // Michl
"76561197961354349", // Bossen
"76561198086804261", // Breed1012
"76561197999686179", // Phil Wilkinson
"76561197999163682", // Mush
"76561198012613122", // Ace_Of_Cakes
"76561198046640675", // Harrigan
"76561198086804261", // Breed1012
"76561197993776953", // PaxonXXL
"76561198061048677", // SkullXT
"76561197971059609", // shadN
"76561198035467279", // Galadir
"76561197960369568", // Delco
"76561198044119983", // Ajax
"76561197970362636", // Michael
"76561198049625615", // Woki
"76561198069937433", // Sam
"76561197992764137", // IzrodGaden
"76561198095804976", // PFC IZZO
"76561197998399880", // Hank Moody
"76561197991581477", // DooMRunneR
"76561198052750892", // gecco69
"76561198094832188", // NitroKeks
"76561197971340740", // Jan
"76561198112672668", // Windows
"76561197964728202", // Impaktus Maximus
"76561198091190490", // Tenderkaj
"76561197979855445", // Jasta
"76561198036369653", // Mirage
"76561198033162272", // E.Wilson
"76561198020059473", // Bigbluepolice
"76561198072357560", // The Catastrophe Maker
"76561198032509585", // Dwarfex
"76561198001008363", // N0mak
"76561198023708792", // Master Sgt. Warpig
"76561198018897268", // Rakete
"76561197981234157", // Rheinfels
"76561197982995739", // Djbac_000
"76561197966275122", // seler
"76561198091380518", // Ivan
"76561198027137281", // Goose
"76561198116821355", // Scorch 6-2
"76561198088572088", // fatcat422
"76561198068516187", // Matus
"76561198065406981", // SentinelGER
"76561197980707470", // DofD
"76561198074491018", // Peging
"76561198029886036", // Kanonenfutter
"76561198014771409", // ShoTaXx
"76561198106896997", // Stefan01
"76561198068434638", // Flenix
"76561198088156576", // Benny
"76561198004208896", // [KV13] Wuzi
"76561198035912740", // ApokalypsaA
"76561198058179520", // celec
"76561198014431889", // PATROL
"76561198007681532", // Kruger
"76561197990980605", // Tibrys
"76561198013244438", // Luis
"76561198033907699", // Daniel
"76561198020193133", // Walter 0229
"76561198063526026", // Lawrence
"76561197961622287", // Amir
"76561197970839342", // Francois
"76561198089965520", // McDave
"76561198016412853", // J.Thompson
"76561197986223568", // S.Zona
"76561197977860764", // Sharkys
"76561197965748860", // Nightwolf
"76561198015602070", // Logan
"76561197962690980", // gallax
"76561198013403808", // Kuli
"76561198069759374", // Alex
"76561197963445035", // SolidStrike
"76561198020034152", // Scapa
"76561197962766542", // csathdfw
"76561198024938276", // VeRsUs
"76561198042470174", // M3XiCN
"76561197995236104", // ChristianVanDell
"76561198022174262", // Jehuty
"76561198097325606", // William Gfeller
"76561198035672009", // bread
"76561198028701048", // Victor
"76561198042319643", // JohnDoe_Gin
"76561197961424300", // Vodnik the Chav
"76561197974184949", // Bontakun
"76561198034119222", // GonZoHD
"76561198027912181", // [DE]Mario
"76561197986585119", // Schax
"76561197989931811", // Signor Valmano
"76561198053027283", // Wolf1510
"76561198033783014", // Imperator71
"76561198060946770", // Nico
"76561198055224183", // MukeMukem
"76561198067046360", // Dovahkiihn
"76561198018478276", // 007
"76561198059488643", // Blacky
"76561198090868659", // Robin
"76561197966249666", // Mads
"76561197991585689", // Brian
"76561198061899011", // Hacx
"76561198062704203", // tecHunt
"76561198064494062", // leon
"76561198035293905", // [o_o] infi
"76561198116033450", // AnonMous
"76561197960293825", // Mac
"76561198017680861", // Frederik
"76561198033610071" // GraveDigga-D
];


//list of UIDs on B slots
//_allowedBUIDs = ["987654","456789"];

{
	if ((isPlayer _x) and (_unit == _x)) then {
		{
			if (_uid != _x) then {
				hint "Attention!\nYou using an Member Slot! Join our Community - visit our Steam Community Group - GamersCentral!";
				titleText ["Attention! You using an Member Slot! Join our Community - visit our Steam Community Group - GamersCentral!","BLACK FADED"];
				sleep 5;
				endMission "LOSER";
			};
		}forEach _masterUIDArray;
	};
}forEach _slotsA;

/*
{
	if ((isPlayer _x) and (_unit == _x)) then {
		{
			if (_uid != _x) then {
				hint "Attention!\nYou using an Member Slot! Join our Community - visit our Steam Community Group - GamersCentral!";
				titleText ["Attention! You using an Member Slot! Join our Community - visit our Steam Community Group - GamersCentral!","BLACK FADED"];
				sleep 5;
				endMission "LOSER";
			};
		}forEach _allowedBUIDs;
	};
}forEach _slotsB;*/