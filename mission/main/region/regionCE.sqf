/*
Author: 

	Quiksilver

Last modified: 

	2/05/2014

Description:

	Central Theater
	
Notes:
	
	
______________________________________________*/

private ["_target1","_target2","_target3","_targetArray","_pos","_i","_position","_flatPos","_roughPos","_targetStartText","_targets","_targetsLeft","_dt","_enemiesArray","_unitsArray","_radioTowerDownText","_targetCompleteText","_regionCompleteText","_null","_mines","_chance","_tower4","_tower5","_tower6"];
eastSide = createCenter east;

//---------------------------------------------- AO location marker array

_targets = ["Frini","Rodopoli","Alikampos","Neochori","Agios Dionysios","Frini Woodlands","Athira","Lakka","Orino","Koroni","Poliakko"];

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
	
	//------------------------------------------ Spawn radiotower
	
	_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
	_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
	
	while {(count _flatPos) < 1} do {
		_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
	};
	
	_roughPos = 
	[
		((_flatPos select 0) - 200) + (random 400),
		((_flatPos select 1) - 200) + (random 400),
		0
	];

	radioTower = "Land_TTowerBig_2_F" createVehicle _flatPos;
	waitUntil { sleep 0.5; alive radioTower };
	radioTower setVectorUp [0,0,1];
	
	radioTowerAlive = true; publicVariable "radioTowerAlive";
	{ _x setMarkerPos _roughPos; } forEach ["radioMarker", "radioCircle"];
	
	//------------------------------------------ Spawn Tower around Radio Tower
	
	_tower4 = [radioTower, PARAMS_TowerRadioTower, 0] call BIS_fnc_relPos;
	_tower5 = [radioTower, PARAMS_TowerRadioTower, 120] call BIS_fnc_relPos;
	_tower6 = [radioTower, PARAMS_TowerRadioTower, 240] call BIS_fnc_relPos;
	sleep 0.3;
	tower4 = "Land_Cargo_Patrol_V2_F" createVehicle _tower4;
	tower5 = "Land_Cargo_Patrol_V2_F" createVehicle _tower5;
	tower6 = "Land_Cargo_Patrol_V2_F" createVehicle _tower6;
	sleep 0.3;
	tower4 setDir 180;
	tower5 setDir 300;
	tower6 setDir 60;
	{ _x allowDamage false } forEach [tower4,tower5,tower6];
	{
		_x addCuratorEditableObjects [[tower4], false];
		_x addCuratorEditableObjects [[tower5], false];
		_x addCuratorEditableObjects [[tower6], false];
	} foreach allCurators;
	
	//-----------------------------------------------Spawn minefield
	
	_chance = random 10;
	if (_chance < PARAMS_RadioTowerMineFieldChance) then {
	
		_unitsArray = [_flatPos] call QS_fnc_AOminefield;
	
		"radioMarker" setMarkerText "Radiotower (Minefield)";
	} else {
		_unitsArray = [_flatPos] call QS_fnc_AOminefieldAO;
		
		"aoMines" setMarkerPos (getMarkerPos currentAO);
		{_x setMarkerPos (getMarkerPos currentAO);} forEach ["aoMines"];
		"aoMarker" setMarkerText format["Take %1 (Mines)",currentAO];
		
		"radioMarker" setMarkerText "Radiotower";
	};
	publicVariable "radioTower";

	{
		_x addCuratorEditableObjects [[radioTower], false];
	} foreach allCurators;
	
	//------------------------------------------ Spawn enemies

	/*if (isServer) then {
		if (isNil "HeadlessVariable") then {
			
		_chanceEnemy = random 10;
	if (_chanceEnemy < PARAMS_EnemySpawn) then {
	
			_aoPos = getMarkerpos currentAO;
			sleep 5;
			
			waituntil{DAC_NewZone == 0};
			_DACvalues = ["Main_AO",[2,0,0],[14,4,50,5],[5,2,30,5],[4,1,20,5],[],[0,0,0,0]];
			[_aoPos,PARAMS_AOSize,PARAMS_AOSize,0,0,_DACvalues] call DAC_fNewZone;
			waituntil{DAC_NewZone == 0};
			_enemiesArray = [currentAO] call QS_fnc_AOenemyB;
	} else {
		_enemiesArray = [currentAO] call QS_fnc_AOenemy;
	};
			
			
			if (PARAMS_AOReinforcementParaDrop == 1) then {
				[] spawn {
					sleep (300 + (random 600));
					if ((random 1) > 0.60) then {
						if (alive radioTower) then {
							nul = [currentAO,2,true,true,2000,0,true,225,70,6,1,105,false,false,false,true,currentAO,true,0.2,nil,nil,nil,false] execVM "LV\heliParadrop.sqf";
						};
					};
				};
			};
			
	
		};
	};*/
	
	if (isServer) then {
		if (isNil "HeadlessVariable") then {
				
			_aoPos = getMarkerpos currentAO;
			sleep 5;
			
			_enemiesArray = [currentAO] call QS_fnc_AOenemy;
			//_enemiesArray = [currentAO] call QS_fnc_AOenemyB;
			sleep 5;
			
			//waituntil{DAC_NewZone == 0};
			//_DACvalues = ["Main_AO",[2,0,0],[14,4,50,5],[5,2,30,5],[4,1,20,5],[],[0,0,0,0]];
			//[_aoPos,PARAMS_AOSize,PARAMS_AOSize,0,0,_DACvalues] call DAC_fNewZone;
			//waituntil{DAC_NewZone == 0};
			
			
			if (PARAMS_AOReinforcementParaDrop == 1) then {
				[] spawn {
					sleep (120 + (random 500));
					if ((random 1) > 0.60) then {
						if (alive radioTower) then {
							//nul = [currentAO,2,true,true,2000,0,true,225,70,10,1,305,false,false,false,false,radioTower,true,0.2,nil,nil,nil,false] execVM "LV\heliParadrop.sqf";
							nul = ['paraDrop','aoMarker',east,15,'empty',100,'O_Heli_Transport_04_covered_F','SmokeShell','empty'] execVM 'ETG_ReinforcementsScript.sqf';
						};
					};
				};
			};
			
	
		};
	};
	
	//------------------------------------------- Set target start text
	
	_targetStartText = format
	[
		"<t align='center' size='2.2'>New Target</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>We did a good job with the last target, lads. I want to see the same again. Get yourselves over to %1 and take 'em all down!<br/><br/>Remember to take down that radio tower to stop the enemy from calling in CAS.",
		currentAO
	];

	//-------------------------------------------- Show global target start hint
	
	GlobalHint = _targetStartText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	showNotification = ["NewMain", currentAO]; publicVariable "showNotification";
	showNotification = ["NewSub", "Destroy the enemy radio tower."]; publicVariable "showNotification";	
	
	//-------------------------------------------- CORE LOOP
	
	currentAOUp = true; publicVariable "currentAOUp";
	
	if (PARAMS_AOReinforcementJet == 1) then {
		[] spawn {
			sleep (180 + (random 500));
			if (alive radioTower) then {
				while {(alive radioTower)} do {
					[] call QS_fnc_enemyCAS;
					sleep (480 + (random 480));
				};
			};
		};
	};
	
	waitUntil {sleep 3; !alive radioTower};
	
	//--------------------------------------------- RADIO TOWER DESTROYED
	
	radioTowerAlive = false; publicVariable "radioTowerAlive";
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["radioMarker","radioCircle"];
	_radioTowerDownText = "<t align='center' size='2.2'>Radio Tower</t><br/><t size='1.5' color='#08b000' align='center'>DESTROYED</t><br/>____________________<br/>The enemy radio tower has been destroyed! Fantastic job, lads!<br/><br/><t size='1.2' color='#08b000' align='center'> The enemy cannot call in air support now!</t><br/>";
	GlobalHint = _radioTowerDownText; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["CompletedSub", "Enemy radio tower destroyed."]; publicVariable "showNotification";
	
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
	[_enemiesArray] spawn QS_fnc_AOdelete;
	["Main_AO"] call DAC_fDeleteZone;
	{ deleteVehicle _x } forEach [tower4,tower5,tower6];
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