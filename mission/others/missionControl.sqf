/*
Author: 

	Quiksilver

Last modified: 

	12/05/2014

Description:

	Main AO mission control
		
______________________________________________*/

private ["_missionOthers","_missionListOthers","_currentMissionOthers","_nextMissionOthers","_loopTimeoutOthers"];

_loopTimeoutOthers = 20;

_missionListOthers = [
	"regionN",
	"regionE",
	"regionS",
	"regionW"
];


while { true } do {	
	
	hqSideChat = "Secondary objective (Infantry Only) assigned, stand-by for orders."; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	
		sleep 3;
		
	_missionOthers = _missionListOthers call BIS_fnc_selectRandom;
	_currentMissionOthers = execVM format ["mission\others\region\%1.sqf", _missionOthers];
	
	waitUntil {
		sleep 5;
		scriptDone _currentMissionOthers
	};
	sleep _loopTimeoutOthers;
};
	
	
