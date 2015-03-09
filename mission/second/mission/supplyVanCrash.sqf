/*
	Based Of drsubo Mission Scripts
	File: supplyVanCrash.sqf
	Author: Cammygames, drsubo
*/
["Mission: Supply Van Crash","BIS_fnc_log"] call BIS_fnc_MP;
_mPos = getMarkerPos "center";
_pos = [_mPos,0,-1,20,0,4000,0]call BIS_fnc_findSafePos; 
_marker = createMarker ["MarkerS",_pos];  
_marker setMarkerType "mil_objective";  
"MarkerS" setMarkerText "Supply Van Crash";  
"MarkerS" setMarkerColor "ColorRed";
sleep 5;
[_pos] execVM "mission\second\scripts\ai.sqf";

_ogjstr = "<t align='center' size='2.0' color='#ff0000'>Mission<br/>Supply Van Crash</t><br/><t size='1.25' color='#ffff00'>______________<br/><br/>
Our radar has picked up a supply van crash!<br/>
You have our permission to confiscate any property you find as payment for eliminating the threat!";

GlobalHint = _ogjstr;
publicVariable "GlobalHint";

_centerpos = getmarkerpos "MarkerS";

_wreck = createVehicle ["Land_Wreck_Van_F",_pos,[], 0, "NONE"];
_wreck1 = createVehicle ["Land_Wreck_Ural_F",_pos,[], 0, "NONE"];

sleep 1500;
deleteMarker "MarkerS"; 
deleteVehicle  _wreck; 
deleteVehicle  _wreck1;

sleep 10;
[]execVM "mission\second\initMPlus.sqf";
