//Parameters

if (loadFile ("userconfig\VCOM_AI\AISettingsV2.sqf") != "") then
{
    call {[] execVM "userconfig\VCOM_AI\AISettingsV2.sqf";};
}else{
    call {[] execVM "VCOMAI\Functions\VCOMAI_DefaultSettings.sqf";};
};

waitUntil {!(isNil "VCOM_SideBasedExecution")};
 
//Compile all scripts that might be used
VcomAI_UnitInit = compile preprocessFileLineNumbers "VCOMAI\Functions\VcomAI_UnitInit.sqf";
VCOMAI_DetermineLeader = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_DetermineLeader.sqf";
VcomAI_QueueHandle = compile preprocessFileLineNumbers "VCOMAI\Functions\VcomAI_QueueHandle.sqf";
VcomAI_DetermineRank = compile preprocessFileLineNumbers "VCOMAI\Functions\VcomAI_DetermineRank.sqf";
VcomAI_DefaultSetup = compile preprocessFileLineNumbers "VCOMAI\Functions\VcomAI_DefaultSetup.sqf";
VcomAI_FormationChange = compile preprocessFileLineNumbers "VCOMAI\Functions\VcomAI_FormationChange.sqf";
VCOMAI_DriverCheck = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_DriverCheck.sqf";
VCOMAI_ClosestAllyWarn = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_ClosestAllyWarn.sqf";
VCOMAI_ClosestEnemy = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_ClosestEnemy.sqf";
VCOMAI_MoveToCover = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_MoveToCover.sqf";
VCOMAI_FlankManeuver = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_FlankManeuver.sqf";
VCOMAI_MoveInCombat = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_MoveInCombat.sqf";
VCOMAI_ThrowGrenade = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_ThrowGrenade.sqf";
VCOMAI_Garrison = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_Garrison.sqf";
VCOMAI_SuppressingShots = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_SuppressingShots.sqf";
VCOMAI_HearingAids = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_HearingAids.sqf";
VCOMAI_LightGarrison = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_LightGarrison.sqf";
VCOMAI_CheckBag = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_CheckBag.sqf";
VCOMAI_HasMine = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_HasMine.sqf";
VCOMAI_Classvehicle = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_Classvehicle.sqf";
VCOMAI_UnpackStatic = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_UnpackStatic.sqf";
VCOMAI_PackStatic = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_PackStatic.sqf";
VCOMAI_DestroyBuilding = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_DestroyBuilding.sqf";
VCOMAI_ArtilleryCalled = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_ArtilleryCalled.sqf";
VCOMAI_Artillery = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_Artillery.sqf";
VCOMAI_RankAndSkill = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_RankAndSkill.sqf";
VCOMAI_FocusedAccuracy = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_FocusedAccuracy.sqf";
VCOMAI_ArmEmptyStatic = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_ArmEmptyStatic.sqf";
VCOMAI_AIHit = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_AIHit.sqf";
VCOMAI_PlaceMine = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_PlaceMine.sqf";
VCOMAI_MapMarkers = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_MapMarkers.sqf";
VCOM_EraseMarkers = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOM_EraseMarkers.sqf";
VCOMAI_EnemyArray = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_EnemyArray.sqf";
VCOMAI_FriendlyArray = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_FriendlyArray.sqf";
VCOMAI_CheckStatic = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_CheckStatic.sqf";
VCOMAI_DeployUAV = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_DeployUAV.sqf";
VCOMAI_VehicleHandle = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_VehicleHandle.sqf";
VCOMAI_GarrisonClear = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_GarrisonClear.sqf";
VCOMAI_BuildingCheck = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_BuildingCheck.sqf";
VCOMAI_GarrisonClearPatrol = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_GarrisonClearPatrol.sqf";
VCOMAI_StanceModifier = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_StanceModifier.sqf";
VCOMAI_BuildingSpawnCheck = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_BuildingSpawnCheck.sqf";
VCOMAI_CombatMode = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_CombatMode.sqf";
VCOMAI_ReGroup = compile preprocessFileLineNumbers "VCOMAI\Functions\VCOMAI_ReGroup.sqf";

//Danger FSM
VCOMAI_RecentEnemyDetected = compile preprocessFileLineNumbers "VCOMAI\functions\DangerCauses\VCOMAI_RecentEnemyDetected.sqf";
VCOMAI_CurrentStance = compile preprocessFileLineNumbers "VCOMAI\functions\DangerCauses\VCOMAI_CurrentStance.sqf";
VCOMAI_SetCombatStance = compile preprocessFileLineNumbers "VCOMAI\functions\DangerCauses\VCOMAI_SetCombatStance.sqf";
VCOMAI_MoveToCoverGroup = compile preprocessFileLineNumbers "VCOMAI\functions\DangerCauses\VCOMAI_MoveToCoverGroup.sqf";
VCOMAI_DeadBodyDetection = compile preprocessFileLineNumbers "VCOMAI\functions\DangerCauses\VCOMAI_DeadBodyDetection.sqf";
VCOMAI_CombatMovement = compile preprocessFileLineNumbers "VCOMAI\functions\DangerCauses\VCOMAI_CombatMovement.sqf";
VCOMAI_Explosiondetection = compile preprocessFileLineNumbers "VCOMAI\functions\DangerCauses\VCOMAI_Explosiondetection.sqf";
VCOMAI_VehicleHandleDanger = compile preprocessFileLineNumbers "VCOMAI\functions\DangerCauses\VCOMAI_VehicleHandle.sqf";


//Global actions compiles
playMoveEverywhere = compileFinal "_this select 0 playMoveNow (_this select 1);";
switchMoveEverywhere = compileFinal "_this select 0 switchMove (_this select 1);";
DisableCollisionALL = compileFinal "_this select 0 disableCollisionWith player";


//Below is loop to check for new AI spawning in to be added to the list
if !(isDedicated) then 
{
	waitUntil {!isNil "BIS_fnc_init"};
	waitUntil {!(isnull (findDisplay 46))};
};

//Lets gets the queue handler going
[] spawn VcomAI_QueueHandle;


VcomAI_UnitQueue = [];
VcomAI_ActiveList = [];
while {true} do 
{
	{
		if (local _x) then 
		{
				if (!(_x in VcomAI_ActiveList) && {!(_x in VcomAI_UnitQueue)}) then
				{
					VcomAI_UnitQueue pushback _x;
				};
		};
	} forEach allUnits;
	sleep 1;
};



//null = [_x] execFSM "\VCOM_AI\AIBEHAVIORNEW.fsm";