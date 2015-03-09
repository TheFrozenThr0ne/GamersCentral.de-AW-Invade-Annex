/*
	Based Of drsubo Mission Scripts
	File: bPlaneCrash.sqf
	Author: Cammygames, drsubo
*/
["Mission: Bandit Plane Crash","BIS_fnc_log"] call BIS_fnc_MP;
_mPos = getMarkerPos "center";
_pos = [_mPos,0,-1,20,0,4000,0]call BIS_fnc_findSafePos; 
_marker = createMarker ["MarkerP",_pos];  
_marker setMarkerType "mil_objective";  
"MarkerP" setMarkerText "Bandit Plane Crash";  
"MarkerP" setMarkerColor "Colorgreen";
sleep 5;
[_pos] execVM "mission\second\scripts\ai.sqf";

_ogjstr = "<t align='center' size='2.0' color='#ff0000'>Mission<br/>Supply Plane</t><br/><t size='1.25' color='#ffff00'>______________<br/><br/>
A supply plane has crashed<br/>
You have our permission to confiscate any property you find as payment for eliminating the threat!";

GlobalHint = _ogjstr;
publicVariable "GlobalHint";

_centerpos = getmarkerpos "MarkerP";
_wreck = createVehicle ["Land_UWreck_MV22_F",_pos,[], 0, "NONE"];

sleep 1500;
deleteMarker "MarkerP"; 
deleteVehicle  _wreck; 
sleep 10;
[]execVM "mission\second\initMPlus.sqf";
