//AIrespawnInit 1.0 by SPUn
if(!isServer)exitWith{};
private["_defaultCleanUp","_diag"];

AIRS_respawn_delay = 1800; //AI respawn delay (if not defined in squad leaders init)
_defaultCleanUp = true; //cleanUp script [WIP] (removes corpses & wrecks > 300m of player(s) every 60 secs)
_diag = false; //if true, script hints live unit amount statistics during editor testing, helps you to adjust group amounts & sizes better)

//You can set respawning off side related by changing these variables from your mission:
AIRS_respawn_WEST = true; //respawn WEST groups
AIRS_respawn_EAST = true; //respawn EAST groups
AIRS_respawn_INDE = true; //respawn INDEPENDENT groups

//Just to make sure it's safe to spawn units
WESTcenter = createCenter west;
EASTcenter = createCenter east;
INDEcenter = createCenter resistance;

//Prepare some AIRS functions
AIRS_SpawnGroup = compile preprocessFile "AIRS\spawnGroup.sqf";
AIRS_StartTask = compile preprocessFile "AIRS\startAItask.sqf";
AIRS_buildingPatrol = compile preprocessFile "AIRS\buildingPatrol.sqf";
AIRS_taskPatrol = compile preprocessFile "AIRS\BIS_fnc_taskpatrol2.sqf";
AIRS_taskDefend = compile preprocessFile "AIRS\BIS_fnc_taskdefend2.sqf";
AIRS_fnc_spawnVehicle = compile preprocessFile "AIRS\BIS_fnc_spawnVehicle2.sqf";
AIRS_fnc_spawnGroup = compile preprocessFile "AIRS\BIS_fnc_spawnGroup2.sqf";
AIRS_DestroyEmptyVehicle = compile preprocessFile "AIRS\destroyEmptyVehicle.sqf";
//Start monitoring AI groups
execVM "AIRS\monitorAIgroups.sqf";
//Prepare some LV functions
LV_GetPlayers = compile preprocessFile "LV\LV_functions\LV_fnc_getPlayers.sqf";
LV_NearestBuilding = compile preprocessFile "LV\LV_functions\LV_fnc_nearestBuilding.sqf";
LV_RemoveDead = compile preprocessFile "LV\LV_functions\LV_fnc_removeDead.sqf";
LV_VehicleInit = compile preprocessFile "LV\LV_functions\LV_fnc_vehicleInit.sqf";
LV_Follow = compile preprocessFile "LV\LV_functions\LV_fnc_follow.sqf";
LV_InMarker = compile preprocessFile "LV\LV_functions\LV_fnc_isInMarker.sqf";
//Cleanup:
if(_defaultCleanUp)then{execVM "AIRS\cleanUp.sqf"};
if(_diag)then{execVM "AIRS\diag.sqf"};

AIRS_Initialized = true;