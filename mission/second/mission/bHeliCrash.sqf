/*
	Based Of drsubo Mission Scripts
	File: bHeliCrash.sqf
	Author: Cammygames, drsubo
*/
_mPos = getMarkerPos "center";
_pos = [_mPos,0,-1,20,0,4000,0]call BIS_fnc_findSafePos; 
_marker = createMarker ["MarkerH",_pos];  
_marker setMarkerType "mil_objective";  
"MarkerH" setMarkerText "Bandit Heli Crash";  
"MarkerH" setMarkerColor "Colorblue";
sleep 5;

#define INF_URBANTYPE "OIA_GuardSentry","OIA_GuardSquad","OIA_GuardTeam"
_enemiesArraySecond = [grpNull];
_x = 0;
for "_x" from 1 to 2 do {
	_overwatchGroup = createGroup east;
	_randomPos = [getMarkerPos "MarkerH", 50, 50, 10] call BIS_fnc_findOverwatch;
	_overwatchGroup = [_randomPos, East, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> [INF_URBANTYPE] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
	[_overwatchGroup, _randomPos, 50] call BIS_fnc_taskPatrol;
	
	_wp = _overwatchGroup addWaypoint [getMarkerPos "MarkerH", 0, 50];
	
	_enemiesArraySecond = _enemiesArraySecond + [_overwatchGroup];

	{
		_x addCuratorEditableObjects [units _overwatchGroup, false];
	} foreach adminCurators;

};

_ogjstr = "<t align='center' size='2.0' color='#ff0000'>Mission<br/>Heli Crash</t><br/><t size='1.25' color='#ffff00'>______________<br/><br/>
A heli with supplies and bandit troops has crashed<br/>
You have our permission to confiscate any property you find as payment for eliminating the threat!";

GlobalHint = _ogjstr;
publicVariable "GlobalHint";

_centerpos = getmarkerpos "MarkerH";

_wreck = createVehicle ["Land_Wreck_Heli_Attack_02_F",_pos,[], 0, "NONE"];

sleep 1500;
deleteMarker "MarkerH"; 
deleteVehicle  _wreck; 
[_enemiesArraySecond] spawn QS_fnc_AOdelete;
sleep 10;
[]execVM "mission\second\initMPlus.sqf";
