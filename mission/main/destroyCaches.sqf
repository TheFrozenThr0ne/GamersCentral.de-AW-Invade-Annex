/*
Author: 

	[GC] MaDmaX
	
Description:

	Spawns Caches on AO.
_______________________________________________________*/

private ["_dtt","_position","_flatPos","_roughPos","_marker1","_marker2","_obj1","_obj2","_objs","_marker3","_marker4","_obj3","_obj4"];

_dtt = createTrigger ["EmptyDetector", getMarkerPos currentAO];
_dtt setTriggerArea [PARAMS_AOSize, PARAMS_AOSize, 0, false];
_dtt setTriggerActivation ["EAST", "PRESENT", false];
_dtt setTriggerStatements ["this","",""];

_caches = ["Box_FIA_Wps_F","Box_FIA_Support_F","Box_FIA_Ammo_F","O_CargoNet_01_ammo_F"];
	
_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dtt],["water","out"]] call BIS_fnc_randomPos;
	_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
	
	while {(count _flatPos) < 1} do {
		_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dtt],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
	};
	
	_roughPos = 
	[
		((_flatPos select 0) - 200) + (random 400),
		((_flatPos select 1) - 200) + (random 400),
		0
	];

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

	_obj2 = _caches call BIS_fnc_selectRandom createVehicle _flatPos;
	waitUntil { sleep 0.5; alive _obj2 };
	_spawnRandomisationcache=900;
	_spwnposNewcache = [(getMarkerPos "aoMarker"),random _spawnRandomisationcache,random 360] call BIS_fnc_relPos;
	_obj2 setpos _spwnposNewcache;

	//{ _x setMarkerPos _roughPos getPos _obj2; } forEach ["cache2", "cache2Circle"];
	_marker2 = createMarker  ["cache2",getpos _obj2];
	_marker2 setMarkerShape "ICON";
	"cache2" setMarkerType "mil_destroy";
	"cache2" setmarkersize [1,1];
	"cache2" setmarkercolor "ColorEAST";
	"cache2" setMarkerText "Cache";
	{
		_x addCuratorEditableObjects [[_obj1], false];
		_x addCuratorEditableObjects [[_obj2], false];
	} foreach allCurators;



/*
_objs = [_obj1, _obj2];
waituntil {sleep 0.3;{alive _x} count _objs == 1;};
hint"1/2 caches destroyed";
if (!alive _obj1) then {deletemarker "cache1"} else {deletemarker "cache2"};
waituntil {sleep 0.3;{alive _x} count _objs == 0;};
if (!alive _obj1) then {deletemarker "cache1"} else {deletemarker "cache2"};
if (!alive _obj2) then {deletemarker "cache2"} else {deletemarker "cache1"};
"2" objStatus "done";
obj_2 = true;
publicvariable "obj_2";
hint"2/2 caches destroyed";*/


//3rd group of objective(s). 2 igla pods that need to die
/*
_marker3 = createMarker ["aa1",getmarkerpos "a1" ];
_marker3 setMarkerShape "ICON";
"aa1" setMarkerType "DESTROY";
"aa1" setmarkersize [1,1];
_obj3 = "Land_TTowerBig_2_F" createVehicle _flatPos;
_marker4 = createMarker ["aa2",getmarkerpos "a2" ];
_marker4 setMarkerShape "ICON";
"aa2" setMarkerType "DESTROY";
"aa2" setmarkersize [1,1];
_obj4 = "Land_TTowerBig_2_F" createVehicle _flatPos;
obj33DText = ["<t color = '#66FF00't/><t size='0.450'>Objective</t>",position _obj3,40,0] spawn Objectives_3DText; 
obj43DText = ["<t color = '#66FF00't/><t size='0.450'>Objective</t>",position _obj4,40,0] spawn Objectives_3DText;

_objs1 = [_obj3, _obj4];

waituntil {sleep 0.3;{alive _x} count _objs1 == 1;};
hint "1/2 AA pods neutralized";
if (!alive _obj3) then {deletemarker "aa1"} else {deletemarker "aa2"};
waituntil {sleep 0.3;{alive _x} count _objs1 == 0;};
if (!alive _obj3) then {deletemarker "aa1"} else {deletemarker "aa2"};
if (!alive _obj4) then {deletemarker "aa2"} else {deletemarker "aa1"};
objcompleted3 = ["Mission", "Complete"] spawn BIS_fnc_infoText;
"3" objStatus "done";
tskobj_3 settaskstate "succeeded";
obj_3 = true;
publicvariable "obj_3";
hint"2/2 AA pods neutralized";
sleep 2;*/