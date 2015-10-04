/*
Author: 

	Quiksilver

Last modified: 

	2/05/2014

Description:

	Central Theater
	
Notes:
	
	
______________________________________________*/

private ["_obj1","_obj2","_objs","_cacheDown","_cacheDown2","_target1","_target2","_target3","_targetArray","_pos","_i","_position","_positiona","_flatPos","_flatPosa","_roughPos","_roughPosa","_targetStartText","_targets","_targetsLeft","_dt","_enemiesArray","_unitsArray","_radioTowerDownText","_targetCompleteText","_regionCompleteText","_null","_mines","_chance","_tower4","_tower5","_tower6"];
eastSide = createCenter east;

//---------------------------------------------- AO location marker array

_targets = ["Pyrsos","Factory","Syrta","Aristi Turbines","Dump","Negades","Abdera","Kore","Oreokastro","Galati Outpost","Fotia Turbines","Agios Konstantinos","Faros","Krya Nera Airfield","Krya Nera Turbines"];

//----------------------------------------------- SELECT A FEW RANDOM AOs

_target1 = _targets call BIS_fnc_selectRandom;
_targets = _targets - [_target1];
_target2 = _targets call BIS_fnc_selectRandom;
_targets = _targets - [_target2];
_target3 = _targets call BIS_fnc_selectRandom;

_targetArray = [_target1,_target2,_target3];

		
//----------------------------------------------- AO MAIN SEQUENCE

while { count _targetArray > 0 } do {
	
	sleep 1;

	//------------------------------------------- Set new current AO

	currentAO = _targetArray call BIS_fnc_selectRandom;

	//------------------------------------------ Edit and place markers for new target
	
	{_x setMarkerPos (getMarkerPos currentAO);} forEach ["aoCircle","aoMarker"];
	"aoMarker" setMarkerText format["Take %1",currentAO];
	sleep 1;
	
	//------------------------------------------ Create AO detection trigger
	
	_dt = createTrigger ["EmptyDetector", getMarkerPos currentAO];
	_dt setTriggerArea [PARAMS_AOSize, PARAMS_AOSize, 0, false];
	_dt setTriggerActivation ["EAST", "PRESENT", false];
	_dt setTriggerStatements ["this","",""];
	
	//------------------------------------------ Spawn enemies
	
	if (isServer) then {
		if (isNil "HeadlessVariable") then {

			_aoPos = getMarkerpos currentAO;
			sleep 5;
			
			_enemiesArray = [currentAO] call QS_fnc_AOenemy;
			//_enemiesArray = [currentAO] call QS_fnc_AOenemyB;
			sleep 5;
			
			if (PARAMS_AOReinforcementParaDrop == 1) then {
				[] spawn {
					sleep (120 + (random 500));
					if ((random 1) > 0.60) then {
						if (alive radioTower) then {
							//nul = [currentAO,2,true,true,2000,0,true,225,70,10,1,305,false,false,false,false,radioTower,true,0.2,nil,nil,nil,false] execVM "LV\heliParadrop.sqf";
							nul = ['paraDrop','aoMarker',east,15,'empty',100,'O_Heli_Transport_04_covered_F','SmokeShell','empty'] execVM 'ETG_ReinforcementsScript.sqf';};
					};
				};
			};
			
			
		};
	};
	
	//------------------------------------------ Spawn Caches
	
	_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
	_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
	
	while {(count _flatPos) < 1} do {
		_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
	};
	
	_positiona = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
	_flatPosa = _positiona isFlatEmpty[3, 1, 0.3, 30, 0, false];
	
	while {(count _flatPosa) < 1} do {
		_positiona = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
		_flatPosa = _positiona isFlatEmpty[3, 1, 0.3, 30, 0, false];
	};
	
	_roughPos = 
	[
		((_flatPos select 0) - 50) + (random 100),
		((_flatPos select 1) - 50) + (random 100),
		0
	];
	_roughPosa = 
	[
		((_flatPosa select 0) - 50) + (random 100),
		((_flatPosa select 1) - 50) + (random 100),
		0
	];

	_caches = ["Box_FIA_Wps_F","Box_FIA_Support_F","Box_FIA_Ammo_F"];
	
	_obj1 = _caches call BIS_fnc_selectRandom createVehicle _flatPos;
	waitUntil { sleep 0.5; alive _obj1 };
	{ _x setMarkerPos _roughPos; } forEach ["cache11", "cache1Circle"];
	//_marker1 = createMarker ["cache1",getpos _obj1];
	//_marker1 setMarkerShape "ICON";
	//"cache1" setMarkerType "mil_destroy";
	//"cache1" setmarkersize [1,1];
	//"cache1" setmarkercolor "ColorEAST";
	//"cache1" setMarkerText "Cache";
	
	sleep 5;

	_obj2 = _caches call BIS_fnc_selectRandom createVehicle _flatPosa;
	waitUntil { sleep 0.5; alive _obj2 };
	{ _x setMarkerPos _roughPosa; } forEach ["cache22", "cache2Circle"];
	_spawnRandomisationcache=100;
	_spwnposNewcache = [(getMarkerPos "cache22"),random _spawnRandomisationcache,random 360] call BIS_fnc_relPos;
	_obj2 setpos _spwnposNewcache;
	
	
	
	//{ _x setMarkerPos _roughPos getPos _obj2; } forEach ["cache2", "cache2Circle"];
	//_marker2 = createMarker  ["cache2",getpos _obj2];
	//_marker2 setMarkerShape "ICON";
	//"cache2" setMarkerType "mil_destroy";
	//"cache2" setmarkersize [1,1];
	//"cache2" setmarkercolor "ColorEAST";
	//"cache2" setMarkerText "Cache";
	{
		_x addCuratorEditableObjects [[_obj1], false];
		_x addCuratorEditableObjects [[_obj2], false];
	} foreach allCurators;
	
	if (isServer) then {
		if (isNil "HeadlessVariable") then {
				
			_enemiesArray = [currentAO] call QS_fnc_AOenemyCaches;
			
			if (PARAMS_AOReinforcementParaDrop == 1) then {
				[] spawn {
					sleep (120 + (random 500));
					if ((random 1) > 0.60) then {
							//nul = [currentAO,2,true,true,2000,0,true,225,70,10,1,305,false,false,false,false,radioTower,true,0.2,nil,nil,nil,false] execVM "LV\heliParadrop.sqf";
							nul = ['paraDrop','aoMarker',east,15,'empty',100,'O_Heli_Transport_04_covered_F','SmokeShell','empty'] execVM 'ETG_ReinforcementsScript.sqf';
						};
				};
			};
		};
	};
	
	//------------------------------------------- Set target start text
	
	_targetStartText = format
	[
		"<t align='center' size='2.2'>New Target</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>We did a good job with the last target, lads. I want to see the same again. Get yourselves over to %1 and take 'em all down!<br/><br/>Seek for enemy caches and destroy them.",
		currentAO
	];

	//-------------------------------------------- Show global target start hint
	
	GlobalHint = _targetStartText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	showNotification = ["NewMain", currentAO]; publicVariable "showNotification";
	showNotification = ["NewSub", "Destroy the enemy caches."]; publicVariable "showNotification";	
	
	//-------------------------------------------- CORE LOOP
	
	currentAOUp = true; publicVariable "currentAOUp";
	
	if (PARAMS_AOReinforcementJet == 1) then {
		[] spawn {
		sleep (180 + (random 500));
			while {true} do {
					[] call QS_fnc_enemyCAS;
					sleep (480 + (random 480));
			};
		};
	};
	
	_objs = [_obj1, _obj2];

	waituntil {sleep 0.3;{alive _x} count _objs == 1;};
	//hint"1/2 caches destroyed";
	
	_cacheDown = "<t align='center' size='2.2'>1/2 Caches</t><br/><t size='1.5' color='#08b000' align='center'>DESTROYED</t><br/>____________________<br/>The enemy cache has been destroyed! One Cache left, seek and destroy it!<br/>";
	GlobalHint = _cacheDown; hint parseText GlobalHint; publicVariable "GlobalHint";
	
	if (!alive _obj1) then {{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["cache1Circle","cache11"];} else {{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["cache2Circle","cache22"];};
	waituntil {sleep 0.3;{alive _x} count _objs == 0;};
	if (!alive _obj1) then {{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["cache1Circle","cache11"];} else {{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["cache2Circle","cache22"];};
	if (!alive _obj2) then {{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["cache2Circle","cache22"];} else {{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["cache1Circle","cache11"];};
	//hint"2/2 caches destroyed";
	
	_cacheDown2 = "<t align='center' size='2.2'>2/2 Caches</t><br/><t size='1.5' color='#08b000' align='center'>DESTROYED</t><br/>____________________<br/>The enemy cache has been destroyed!<br/>";
	GlobalHint = _cacheDown2; hint parseText GlobalHint; publicVariable "GlobalHint";
	
	sleep 5;
	
	//--------------------------------------------- CACHES DESTROYED
	
	_radioTowerDownText = "<t align='center' size='2.2'>Enemy Caches</t><br/><t size='1.5' color='#08b000' align='center'>DESTROYED</t><br/>____________________<br/>The enemy caches has been destroyed! Fantastic job, lads!<br/>";
	GlobalHint = _radioTowerDownText; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["CompletedSub", "Enemy caches destroyed."]; publicVariable "showNotification";
	
	//---------------------------------------------- WHEN ENEMIES KILLED

	waitUntil {sleep 5; count list _dt < PARAMS_EnemyLeftThreshhold};
	
	//----------------------------------------------------- Spawn Evac Teleporter
	_spawnRandomisation=200;
	_spwnposNew = [(getMarkerPos "aoMarker"),random _spawnRandomisation,random 360] call BIS_fnc_relPos;
	aoflag setpos _spwnposNew;
	"aoteleport" setMarkerPos getPos aoflag;
	
	currentAOUp = false; publicVariable "currentAOUp";
	
	_targetArray = _targetArray - [currentAO];

	//---------------------------------------------- DE-BRIEF 1
	
	sleep 3;
	_targetCompleteText = format ["<t align='center' size='2.2'>Target Taken</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/><t align='left'>Fantastic job taking %1, boys! Give us a moment here at HQ and we'll line up your next target for you.</t>",currentAO];
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["aoCircle","aoMarker","radioCircle","aoMines"];
	GlobalHint = _targetCompleteText; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["CompletedMain", currentAO]; publicVariable "showNotification";

	//------------------------------------------------- DELETE
	
	deleteVehicle _dt;
	deleteVehicle _obj1;
	deleteVehicle _obj2;
	[_enemiesArray] spawn QS_fnc_AOdelete;
	["Main_AO"] call DAC_fDeleteZone;
	if (_chance < PARAMS_RadioTowerMineFieldChance) then {[_unitsArray] spawn QS_fnc_AOdelete;};

	//------------------------------------------------- DEFEND AO
	
	if (PARAMS_DefendAO == 1) then {
		_aoUnderAttack = [] execVM "mission\main\AOdefend.sqf";
		waitUntil {scriptDone _aoUnderAttack};
	};
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["aoCircle_2","aoMarker_2"];
	
	//----------------------------------------------------- DE-BRIEF
	
	_targetCompleteText = format ["<t align='center' size='2.2'>AO Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Fantastic job at %1, boys! Give us a moment here at HQ and we'll line up your next target.</t>",currentAO];
	GlobalHint = _targetCompleteText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	
	if ((random 1) > 0.25) then {
		if (PARAMS_CasFixedWingSupport != 0) then {
			[] call QS_fnc_casRespawn;
		};
	};
	
	//----------------------------------------------------- MAINTENANCE
	
	_aoClean = [] execVM "scripts\misc\clearItemsAO.sqf";
	waitUntil {
		scriptDone _aoClean
	};
	sleep 20;
};