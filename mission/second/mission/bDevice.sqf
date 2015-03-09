/*
	Based Of drsubo Mission Scripts
	File: bCamp.sqf
	Author: Cammygames, drsubo
*/
["Mission: Bandit Plane Crash","BIS_fnc_log"] call BIS_fnc_MP;
_mPos = getMarkerPos "center";
_pos = [_mPos,0,-1,20,0,4000,0]call BIS_fnc_findSafePos; 
_marker = createMarker ["MarkerD",_pos];  
_marker setMarkerType "mil_objective";  
"MarkerD" setMarkerText "Strange Device";  
"MarkerD" setMarkerColor "ColorRed";
sleep 5;
[_pos] execVM "mission\second\scripts\ai.sqf";

_ogjstr = "<t align='center' size='2.0' color='#ff0000'>Mission<br/>Device discovered!</t><br/><t size='1.25' color='#ffff00'>______________<br/><br/>
A nuclear device has been discovered<br/>
Remove the device and enemies as soon as possible!!!";

GlobalHint = _ogjstr;
publicVariable "GlobalHint";

_centerpos = getmarkerpos "MarkerD";
_wreck = createVehicle ["Land_Device_disassembled_F",_pos,[], 0, "NONE"];

sleep 1500;
deleteMarker "MarkerD"; 
deleteVehicle  _wreck;
 
sleep 10;
[]execVM "mission\second\initMPlus.sqf";
