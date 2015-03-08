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
#define STATIC_TYPE "O_HMG_01_F","O_HMG_01_high_F"
#define STATIC_TYPE_MG "O_HMG_01_F","O_HMG_01_high_F"

private ["_enemiesArray","_randomPos","_patrolGroup","_AOvehGroup","_AOveh","_AOmrapGroup","_AOmrap","_pos","_spawnPos","_overwatchGroup","_x","_staticGroup","_static","_aaGroup","_aa","_airGroup","_air","_sniperGroup","_staticDir"];
_pos = getMarkerPos (_this select 0);
_enemiesArray = [grpNull];
_x = 0;


//---------- STATIC WEAPONS

for "_x" from 1 to 1 do {
	_staticGroup = createGroup east;
	_randomPos = [getPos _obj1, 50, 10, 10] call BIS_fnc_findOverwatch;
	_static = [STATIC_TYPE] call BIS_fnc_selectRandom createVehicle _randomPos;
	waitUntil{!isNull _static};	
	_static setDir random 360;
		"O_support_MG_F" createUnit [_randomPos,_staticGroup];
		((units _staticGroup) select 0) assignAsGunner _static;
		((units _staticGroup) select 0) moveInGunner _static;
	_staticGroup setBehaviour "COMBAT";
	_staticGroup setCombatMode "RED";
	_static setVectorUp [0,0,1];
	_static lock 3;
	
	_enemiesArray = _enemiesArray + [_staticGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_static];

	{
		_x addCuratorEditableObjects [[_static], false];
		_x addCuratorEditableObjects [units _staticGroup, false];
	} foreach adminCurators;
};

for "_x" from 1 to 1 do {
	_staticGroup = createGroup east;
	_randomPos = [getPos _obj2, 50, 10, 10] call BIS_fnc_findOverwatch;
	_static = [STATIC_TYPE] call BIS_fnc_selectRandom createVehicle _randomPos;
	waitUntil{!isNull _static};	
	_static setDir random 360;
		"O_support_MG_F" createUnit [_randomPos,_staticGroup];
		((units _staticGroup) select 0) assignAsGunner _static;
		((units _staticGroup) select 0) moveInGunner _static;
	_staticGroup setBehaviour "COMBAT";
	_staticGroup setCombatMode "RED";
	_static setVectorUp [0,0,1];
	_static lock 3;
	
	_enemiesArray = _enemiesArray + [_staticGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_static];

	{
		_x addCuratorEditableObjects [[_static], false];
		_x addCuratorEditableObjects [units _staticGroup, false];
	} foreach adminCurators;
};

//=========== ENEMIES IN BUILDINGS

if (PARAMS_EnemiesInBuildings != 0) then {
	_town = _pos nearObjects ["House",500];
	if ((count _town) > 6) then {
		_indArray = getArray (missionConfigFile >> "faction" >> "ind" >> "units");
		_toSpawn = [];
		for [{_i = 0}, {_i < PARAMS_EnemiesInBuildings}, {_i = _i + 1}] do {
			_randomUnit = _indArray select (floor (random (count _indArray)));
			0 = _toSpawn pushBack _randomUnit;
		};
		_AOgarrisonGroup = createGroup resistance;
		_AOgarrisonGroup = [_pos,RESISTANCE,_toSpawn] call BIS_fnc_spawnGroup;
		0 = [_pos,units _AOgarrisonGroup,500,0,[0,20],true,true] call SHK_fnc_buildingPos02;
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
} forEach (getMarkerPos currentAO nearObjects ["House", 800]);
_enemiesArray;
