/*
Author: 

	Quiksilver

Last modified: 

	2/05/2014

Description:

	Central Theater
	
Notes:
	
	
______________________________________________*/

private ["_targetSecondary1","_targetSecondary2","_targetSecondary3","_targetArrayOthers","_posOthers","_iOthers","_positionOthers","_flatPosOthers","_roughPosOthers","_targetStartTextOthers","_targetsOthers","_targetsLeftOthers","_dtt","_enemiesArrayOthers","_unitsArrayOthers","_radioTowerDownTextOthers","_targetCompleteTextOthers","_regionCompleteTextOthers","_nullOthers","_minesOthers","_chanceOthers","_tower1Others","_tower2Others","_tower3Others"];
eastSide = createCenter east;

//---------------------------------------------- AO location marker array

_targetsOthers = ["Krya Nera Hills","Thronos","Agia Stemma","Magos","Military Factory","Agios Minas","Amoni","Agia Stemma"];

//----------------------------------------------- SELECT A FEW RANDOM AOs

_targetSecondary1 = _targetsOthers call BIS_fnc_selectRandom;
_targetsOthers = _targetsOthers - [_targetSecondary1];
_targetSecondary2 = _targetsOthers call BIS_fnc_selectRandom;
_targetsOthers = _targetsOthers - [_targetSecondary2];

_targetArrayOthers = [_targetSecondary1,_targetSecondary2];

		
//----------------------------------------------- AO MAIN SEQUENCE

while { count _targetArrayOthers > 0 } do {
	
	sleep 1;

	//------------------------------------------- Set new current AO

	currentA = _targetArrayOthers call BIS_fnc_selectRandom;

	//------------------------------------------ Edit and place markers for new target
	
	{_x setMarkerPos (getMarkerPos currentA);} forEach ["aoCircle2","aoMarker2"];
	"aoMarker2" setMarkerText format["Secondary Objective: Clear %1 (Infantry Only)",currentA];
	sleep 1;
	
	//------------------------------------------ Create AO detection trigger
	
	_dtt = createTrigger ["EmptyDetector", getMarkerPos currentA];
	_dtt setTriggerArea [PARAMS_AOSizeSecondary, PARAMS_AOSizeSecondary, 0, false];
	_dtt setTriggerActivation ["EAST", "PRESENT", false];
	_dtt setTriggerStatements ["this","",""];
	
	
	//------------------------------------------ Spawn enemies

	if (isServer) then {
		if (isNil "HeadlessVariable") then {
		
		_aPos = getMarkerpos currentA;
			sleep 5;
	
			_enemiesArrayOthers = [currentA] call QS_fnc_AOenemyS;
			
			
		//_enemiesArrayOthers = [currentA] call QS_fnc_AOenemyO;
	
		};
	};
	
	//------------------------------------------- Set target start text
	
	_targetStartTextOthers = format
	[
		"<t align='center' size='2.2'>Clear Target</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>We did a good job with the last target, lads. I want to see the same again. Get yourselves over to %1 and take 'em all down! This is for Infantry Only.<br/>",
		currentA
	];

	//-------------------------------------------- Show global target start hint
	
	GlobalHint = _targetStartTextOthers; publicVariable "GlobalHint"; hint parseText GlobalHint;
	showNotification = ["NewMainSecondary", currentA]; publicVariable "showNotification";
	

	
	//---------------------------------------------- WHEN ENEMIES KILLED

	waitUntil {sleep 5; count list _dtt < PARAMS_EnemyLeftThreshholdSecondary};
	
	
	//---------------------------------------------- DE-BRIEF 1
	
	sleep 3;
	_targetCompleteTextOthers = format ["<t align='center' size='2.2'>Target Cleared</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/><t align='left'>Fantastic job taking %1, boys! Give us a moment here at HQ and we'll line up your next target for you.</t>",currentA];
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["aoCircle2","aoMarker2"];
	GlobalHint = _targetCompleteTextOthers; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["CompletedSecondary", currentA]; publicVariable "showNotification";

	//------------------------------------------------- DELETE
	
	deleteVehicle _dtt;
	[_enemiesArrayOthers] spawn QS_fnc_AOdelete;
	//----------------------------------------------------- DE-BRIEF
	
	_targetCompleteTextOthers = format ["<t align='center' size='2.2'>Secondary Objective Complete</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Fantastic job at %1, boys! Give us a moment here at HQ and we'll line up your next target.</t>",currentA];
	GlobalHint = _targetCompleteTextOthers; publicVariable "GlobalHint"; hint parseText GlobalHint;
	
	sleep 4;
	
	// Get the current credits of my_factory
	_creditsSmall = my_factory_small getVariable "R3F_LOG_CF_credits";
	_creditsMedium = my_factory_medium getVariable "R3F_LOG_CF_credits";
	_creditsBig = my_factory_big getVariable "R3F_LOG_CF_credits";
	
	// Add 15 000 to the value
	_creditsSmall = _creditsSmall + 65000;
	_creditsMedium = _creditsMedium + 65000;
	_creditsBig = _creditsBig + 65000;
	
	// Set the new credits
	my_factory_small setVariable ["R3F_LOG_CF_credits", _creditsSmall, true];
	my_factory_medium setVariable ["R3F_LOG_CF_credits", _creditsMedium, true];
	my_factory_big setVariable ["R3F_LOG_CF_credits", _creditsBig, true];
	
	showNotification = ["GetCredits", "65000 Credits added to Factory"]; publicVariable "showNotification";
	
	//----------------------------------------------------- MAINTENANCE
	
	/*_aoClean = [] execVM "scripts\misc\clearItemsAO.sqf";
	waitUntil {
		scriptDone _aoClean
	};*/
	sleep 20;
};