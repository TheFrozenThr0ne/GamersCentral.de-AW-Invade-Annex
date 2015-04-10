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

private ["_enemiesArray","_randomPos","_patrolGroup","_AOvehGroup","_AOveh","_AOmrapGroup","_AOmrap","_pos","_spawnPos","_overwatchGroup","_x","_staticGroup","_static","_aaGroup","_aa","_airGroup","_air","_sniperGroup","_staticDir"];
_pos = getMarkerPos (_this select 0);
_enemiesArray = [grpNull];
_x = 0;

//---------- INFANTRY OVERWATCH
	
for "_x" from 1 to PARAMS_OverwatchSecondary do {
	_overwatchGroup = createGroup east;
	_randomPos = [getMarkerPos currentA, 300, 50, 10] call BIS_fnc_findOverwatch;
	_overwatchGroup = [_randomPos, East, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> [INF_URBANTYPE] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
	[_overwatchGroup, _randomPos, 250] call BIS_fnc_taskPatrol;	
	
	_wp = _overwatchGroup addWaypoint [getMarkerPos currentA, 0, 250];
	
	_enemiesArray = _enemiesArray + [_overwatchGroup];

	{
		_x addCuratorEditableObjects [units _overwatchGroup, false];
	} foreach adminCurators;

};


//---------- INFANTRY PATROLS RANDOM
	
for "_x" from 1 to PARAMS_GroupPatrolSecondary do {
	_patrolGroup = createGroup east;
	_randomPos = [[[getMarkerPos currentA, (PARAMS_AOSizeSecondary / 1.2)],[]],["water","out"]] call BIS_fnc_randomPos;
	_patrolGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> [INF_TYPE] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
	[_patrolGroup, getMarkerPos currentA, 250] call BIS_fnc_taskPatrol;
	
	_wp = _patrolGroup addWaypoint [getMarkerPos currentA, 0, 250];
	
	_enemiesArray = _enemiesArray + [_patrolGroup];
	
	{
		_x addCuratorEditableObjects [units _patrolGroup, false];
	} foreach adminCurators;

};

//=========== ENEMIES IN BUILDINGS

if (PARAMS_EnemiesInBuildings != 0) then {
	_town = _pos nearObjects ["House",300];
	if ((count _town) > 6) then {
		_indArray = getArray (missionConfigFile >> "faction" >> "ind" >> "units");
		_toSpawn = [];
		for [{_i = 0}, {_i < PARAMS_EnemiesInBuildings}, {_i = _i + 1}] do {
			_randomUnit = _indArray select (floor (random (count _indArray)));
			0 = _toSpawn pushBack _randomUnit;
		};
		_AOgarrisonGroup = createGroup resistance;
		_AOgarrisonGroup = [_pos,RESISTANCE,_toSpawn] call BIS_fnc_spawnGroup;
		0 = [_pos,units _AOgarrisonGroup,300,0,[0,20],true,true] call SHK_fnc_buildingPos02;
		[(units _AOgarrisonGroup)] call QS_fnc_setSkill2;
		
		{_x addCuratorEditableObjects [(units _AOgarrisonGroup),FALSE];} count allCurators;	
		
		_enemiesArray set [count _enemiesArray,_AOgarrisonGroup];
	};
};

	
//---------- GARRISON FORTIFICATIONS	
	
{
	_newGrp = [_x] call QS_fnc_garrisonFortEAST;
	if (!isNull _newGrp) then { 
		_enemiesArray = _enemiesArray + [_newGrp]; 
	};
	{
		_x addCuratorEditableObjects [units _newGrp, false];
	} forEach adminCurators;		
} forEach (getMarkerPos currentA nearObjects ["House", 300]);
_enemiesArray;
