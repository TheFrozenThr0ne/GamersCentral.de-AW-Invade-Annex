/*
@filename: initServer.sqf
Author:
	
	Quiksilver

Last modified:

	23/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Server scripts such as missions, modules, third party and clean-up.
	
______________________________________________________*/


//------------------------------------------------ Handle parameters

for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};

//-------------------------------------------------- Server scripts
if !(hasInterface or isServer) then {
  HeadlessVariable = true;
  publicVariable "HeadlessVariable";

};

masterClassArray = ["B_MBT_01_mlrs_F","O_Plane_CAS_02_F","O_Heli_Attack_02_black_F"]; //whitelist vehicles
allowed = call compile preprocessFileLineNumbers "\InvadeAnnex_settings\memberIds.txt"; //whitelist
publicVariable "masterClassArray";
publicVariable "allowed";

["Initialize"] call BIS_fnc_dynamicGroups;

if (PARAMS_AO == 1) then { _null = [] execVM "mission\main\missionControl.sqf"; };						// Main AO
if (PARAMS_SideObjectives == 1) then { _null = [] execVM "mission\side\missionControl.sqf";};			// Side objectives		
_null = [] execVM "mission\others\missionControl.sqf"; 													// Secondary Infantry Only Objective 
_null = [] execVM "scripts\eos\OpenMe.sqf";																// EOS (urban mission and defend AO)
_null = [] execVM "scripts\misc\airbaseDefense.sqf";													// Airbase air defense
_null = [] execVM "scripts\misc\cleanup.sqf";															// cleanup
_null = [] execVM "scripts\misc\islandConfig.sqf";														// prep the island for mission
_null = [] execVM "scripts\misc\zeusupdater.sqf";														// zeus unit updater loop
if (PARAMS_EasterEggs == 1) then {_null = [] execVM "scripts\easterEggs.sqf";};							// Spawn easter eggs around the island
[] execVM "scripts\real_weather.sqf";
adminCurators = allCurators;
enableEnvironment FALSE;
BACO_ammoSuppAvail = true; publicVariable "BACO_ammoSuppAvail";