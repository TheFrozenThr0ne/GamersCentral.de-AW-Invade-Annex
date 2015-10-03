/*
@file: QS_fnc_AOenemy.sqf
Author:

	Quiksilver (credits: Ahoyworld.co.uk. Rarek et al for AW_fnc_spawnUnits.)
	
Last modified:

		24/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	AO enemies
__________________________________________________________________*/

//---------- CONFIG

#define INF_TYPE "OIA_InfSentry","OIA_InfSquad","OIA_InfSquad_Weapons","OIA_InfTeam","OIA_InfTeam_AA","OIA_InfTeam_AT","OI_reconPatrol","OI_reconSentry","OI_reconTeam"
#define INF_URBANTYPE "OIA_GuardSentry","OIA_GuardSquad","OIA_GuardTeam"
#define MRAP_TYPE "O_MRAP_02_gmg_F","O_MRAP_02_hmg_F"
#define VEH_TYPE "O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F"
#define AIR_TYPE "O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","I_Heli_light_03_F","O_Heli_Light_02_F"
#define STATIC_TYPE "O_HMG_01_F","O_HMG_01_high_F","O_Mortar_01_F"
#define STATIC_TYPE_MG "O_HMG_01_F","O_HMG_01_high_F"

private ["_AOrandom","_enemiesArray","_randomPos","_patrolGroup","_AOvehGroup","_AOveh","_AOmrapGroup","_AOmrap","_pos","_spawnPos","_overwatchGroup","_x","_staticGroup","_static","_aaGroup","_aa","_airGroup","_air","_sniperGroup","_staticDir"];
_pos = getMarkerPos (_this select 0);
_enemiesArray = [grpNull];
_x = 0;

	AOnord = "Nothing";
	AOost = "Nothing";
	AOsued = "Nothing";
	AOwest = "Nothing";
	AOnord = [getMarkerPos currentAO select 0,(getMarkerPos currentAO select 1)-800 + (random 200)];
	AOost = [(getMarkerPos currentAO select 0)+850 + (random 200),getMarkerPos currentAO select 1];
	AOsued = [getMarkerPos currentAO select 0,(getMarkerPos currentAO select 1)+850 + (random 200)];
	AOwest = [(getMarkerPos currentAO select 0)-800 + (random 200),getMarkerPos currentAO select 1];
	AOwestrand = [(getMarkerPos currentAO select 0)-500 + (random 200),getMarkerPos currentAO select 1];
	_AOrandom = [AOnord, AOost, AOsued, AOwest, AOwestrand] call BIS_fnc_selectRandom;
	
	
//---------- INFANTRY PATROLS RANDOM
	
for "_x" from 1 to 6 do {
	_patrolGroup = createGroup east;
	_randomPos = [AOnord, AOost, AOsued, AOwest] call BIS_fnc_selectRandom;
	//_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.2)],[]],["water","out"]] call BIS_fnc_randomPos;
	_patrolGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> [INF_TYPE] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;	
	"O_Soldier_AA_F" createUnit [AOrandom, spawnGroup];
	"O_Soldier_AA_F" createUnit [AOrandom, spawnGroup];
	_wp = _patrolGroup addWaypoint [getMarkerPos currentAO, 0, 50];
	[_patrolGroup, 2] setWaypointType "MOVE";
	_patrolGroup setBehaviour "COMBAT";
	_patrolGroup setCombatMode "RED";
	_patrolGroup setWaypointSpeed "FULL";
	_enemiesArray = _enemiesArray + [_patrolGroup];
	
	{
		_x addCuratorEditableObjects [units _patrolGroup, false];
	} foreach adminCurators;

};

//---------- INFANTRY OVERWATCH
	
for "_x" from 1 to 6 do {
	_overwatchGroup = createGroup east;
	_randomPos = [AOnord, AOost, AOsued, AOwest] call BIS_fnc_selectRandom;
	//_randomPos = [getMarkerPos currentAO, 650, 50, 10] call BIS_fnc_findOverwatch;
	_overwatchGroup = [_randomPos, East, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> [INF_URBANTYPE] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
	
	_wp = _overwatchGroup addWaypoint [getMarkerPos currentAO, 0, 50];
	[_patrolGroup, 2] setWaypointType "MOVE";
	_overwatchGroup setBehaviour "COMBAT";
	_overwatchGroup setCombatMode "RED";
	_overwatchGroup setWaypointSpeed "FULL";
	_enemiesArray = _enemiesArray + [_overwatchGroup];

	{
		_x addCuratorEditableObjects [units _overwatchGroup, false];
	} foreach adminCurators;

};

//---------- GROUND VEHICLE RANDOM
	
for "_x" from 0 to 3 do {
	_AOvehGroup = createGroup east;
	_randomPos = [AOnord, AOost, AOsued, AOwest] call BIS_fnc_selectRandom;
	//_randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize],[]],["water","out"]] call BIS_fnc_randomPos;
	_AOveh = [VEH_TYPE] call BIS_fnc_selectRandom createVehicle _randomPos;
	waitUntil{!isNull _AOveh};
	if (random 1 >= 0.25) then {
		_AOveh allowCrewInImmobile true;
	};
		"O_engineer_F" createUnit [_randomPos,_AOvehGroup];
		"O_engineer_F" createUnit [_randomPos,_AOvehGroup];
		"O_engineer_F" createUnit [_randomPos,_AOvehGroup];
		((units _AOvehGroup) select 0) assignAsDriver _AOveh;
		((units _AOvehGroup) select 0) moveInDriver _AOveh;
		((units _AOvehGroup) select 1) assignAsGunner _AOveh;
		((units _AOvehGroup) select 1) moveInGunner _AOveh;
		((units _AOvehGroup) select 2) assignAsCommander _AOveh;
		((units _AOvehGroup) select 2) moveInCommander _AOveh;
	_AOveh lock 3;
	
	_wp = _AOvehGroup addWaypoint [getMarkerPos currentAO, 0, 50];
	[_patrolGroup, 2] setWaypointType "MOVE";
	_AOvehGroup setBehaviour "COMBAT";
	_AOvehGroup setCombatMode "RED";
	_AOvehGroup setWaypointSpeed "FULL";
	_enemiesArray = _enemiesArray + [_AOvehGroup,_AOveh];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_AOveh];

	{
		_x addCuratorEditableObjects [[_AOveh], false];
		_x addCuratorEditableObjects [units _AOvehGroup, false];
	} foreach adminCurators;

};
	
	
//---------- COMMON

[(units _patrolGroup)] call QS_fnc_setSkill1;
[(units _overwatchGroup)] call QS_fnc_setSkill2;
[(units _AOvehGroup)] call QS_fnc_setSkill2;

_enemiesArray;
