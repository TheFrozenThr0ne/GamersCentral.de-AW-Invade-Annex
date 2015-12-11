/*
@filename: init.sqf
Author:
	
	Quiksilver

Last modified:

	12/05/2014
	
Description:

	Things that may run on both server and client.
	Deprecated initialization file, still using until the below is correctly partitioned between server and client.
______________________________________________________*/

/*if (isServer) then {
  externalConfigFolder = "\InvadeAnnex_settings";
  [] execVM (externalConfigFolder + "\init.sqf");
};*/

// Werthles Headless Script Parameters v2.3
// 1. Repeating - true/Once - false,
// 2. Time between repeats (seconds),
// 3. Debug available for all - true/Just available for admin/host - false,
// 4. Advanced balancing - true/Simple balancing - false,
// 5. Delay before executing (seconds),
// 6. Additional syncing time between groups transferred to try to reduce bad unit transfer caused by desyncs (seconds)
// 7. Display an initial setup report after the first cycle, showing the number of units moved to HCs,
// 8. Addition phrases to look for when checking whether to ignore.
// Unit names, group names, unit's current transport vehicle, modules synced to units and unit class names will all be checked for these phrases
// Format:
// ["UnitName","GroupCallsignName","SupportProviderModule1","TypeOfUnit"]
// E.g. ["BLUE1","AlphaSquad","B_Heli_Transport_01_camo_F"] (including ""s)
// Specifying "B_Heli" would stop all units with that class type from transferring to HCs
// However, if you specify "BLUE1", "NAVYBLUE10" will also be ignored

//[true,30,false,true,30,3,true,[]] execVM "WerthlesHeadless.sqf";

null = [] execVM "auxslingloading.sqf";

_null = [] execVM "members\communityList.sqf";

_IntroMusic            = true; // Welcome Intro Song
if (_IntroMusic) then { playMusic "intro";};

// [player] execVM "welcome.sqf";

["Initialize"] call BIS_fnc_dynamicGroups;


ETG_Reinforcements = 0;
// [] execVM "VCOMAI\init.sqf";

//Execute scripts
[] execVM "VCOM_Driving\init.sqf";

CHHQ_showMarkers = true; // Set 'true' if you want real time map markers for all HQs on your side. (Default: true)

execVM "JWC_CASFS\initCAS.sqf";

waitUntil { !isNull player }; // Wait for player to initialize

// Compile scripts
getLoadout = compile preprocessFileLineNumbers 'get_loadout.sqf';
setLoadout = compile preprocessFileLineNumbers 'set_loadout.sqf';

// Lets wait 10 seconds, hopefully all crates will spawn by then
sleep 10;

// Save default loadout
loadout = [player] call getLoadout;

// Add save/load loadout actions to all ammo boxes
{
_x addAction ["<t color='#ff1111'>Save loadout</t>", "get_loadout.sqf"];
_x addAction ["<t color='#00cc00'>Load loadout</t>", "set_loadout.sqf"];
} forEach nearestObjects [getpos player,["ReammoBox","ReammoBox_F","B_Soldier_VR_F"],15000];

// Load saved loadout on respawn
player addEventHandler ["Respawn", {
[player,loadout] spawn setLoadout;
}
];

squad_mgmt_action = player addaction ["<t color='#CCCC00'>Group Management</t>","disableserialization; ([] call BIS_fnc_displayMission) createDisplay 'RscDisplayDynamicGroups'",nil,1,false,true,"",""];

player addEventHandler ["Respawn", {
squad_mgmt_action = player addaction ["<t color='#CCCC00'>Group Management</t>","disableserialization; ([] call BIS_fnc_displayMission) createDisplay 'RscDisplayDynamicGroups'",nil,1,false,true,"",""];
}
];

// Admin reserved slot
// You can reserve admin slot	
//INS_REV_CFG_reserved_slot = true;
//INS_REV_CFG_reserved_slot_units = ["bis_curatorUnit_1","bis_curatorUnit_2","bis_curatorUnit_3"];
//[] execVM "scripts\reserved_slot\reserved_slot.sqf";

// if (isServer) then {OnPlayerConnected "[_uid,_name] execVM ""members\checkslot.sqf""";};

// DAC_Basic_Value = 0;execVM "DAC\DAC_Config_Creator.sqf";
//call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";		// revive
call compile preprocessFile "=BTC=_TK_punishment\=BTC=_tk_init.sqf"; 

execVM "R3F_LOG\init.sqf";

if (isServer) then {[1000,-1,true,100,1000,1000]execvm "zbe_cache\main.sqf"};
//execFSM "core\fsm\ZBE_HCCache.fsm";

[] execVM "scripts\DOM_repair\init.sqf";
//[] execVM "scripts\DOM_squad\init.sqf";
//0 = [] execVM "scripts\DOM_squad\group_manager.sqf";
_null = [] execVM "scripts\units\tankCheck.sqf";
[] execVM "scripts\clean.sqf";	

addMissionEventHandler ["HandleDisconnect", { 
    _unit  = _this select 0;
    _pos = getPosATL _unit;
    
    _wholder = nearestObjects [_pos, ["weaponHolderSimulated", "weaponHolder"], 2];
    
    {
        deleteVehicle _x;
    }forEach _wholder + [_unit];
    
    false
}];  


taskmasterLoaded = false;
call compile preprocessFileLineNumbers "scripts\ascomBackEnd.sqf";
call compile preprocessFileLineNumbers "scripts\ascomFunctions.sqf";
[] execVM "scripts\shk_taskmaster.sqf";
waitUntil {taskmasterLoaded};
if (isServer) then {
    waitUntil { !isNil "ASCOM_Initialized" };
};
waitUntil {!isNull player};
//Change the 2 arrays below for your heli names, eg ["aHeli1", "aHeli2"], ["tHeli1", "tHeli2"]
//Helicopter Names MUST BE IN "QUOTES!"
[player, ["aHeli1", "aHeli2", "aHeli3", "aHeli4", "aHeli5", "aHeli6"], ["tHeli1", "tHeli2", "tHeli3", "tHeli4", "tHeli5", "tHeli6", "tHeli7"]] execVM "scripts\supportMenu\supportMenuInit.sqf";

[] spawn {
	// No fatigue
	while {true} do {
player enableStamina false;
		uiSleep 6;
	};
};

waitUntil {alive player};
if (playerSide == west) then {
_handle=createdialog "AW_INTRO";
sleep 5;
"Information" hintC ["HALO Jump not available? Use the MHQ Vehicle, deploy it near red Objectives to set a Teleport Point","Everyone can Revive by holding space","Lift script broken after update use Ctrl + B to hook or Sling Load vehicles/objects","Join a Squad - be a Team Player by pressing U key or open Squad Management","You can deploy Bipod with C ArmA Version and or Shift + H Mission Version"];
};