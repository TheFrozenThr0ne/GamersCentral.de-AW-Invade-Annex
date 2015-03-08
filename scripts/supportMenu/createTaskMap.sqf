private ["_caller","_taskName","_driver","_type","_taskLetterArray","_taskLetter","_taskLetter2","_taskNumber","_taskNumber2","_taskTaker","_taskState","_mapClicked","_pos"];
_caller = _this select 1;

_driver = (_this select 3) select 0;
_type = (_this select 3) select 1;

_caller removeAction SUPMEN_attackH1;
_caller removeAction SUPMEN_attackH1Map;
_caller removeAction SUPMEN_attackH2;
_caller removeAction SUPMEN_attackH2Map;
_caller removeAction SUPMEN_attackH3;
_caller removeAction SUPMEN_attackH3Map;
_caller removeAction SUPMEN_attackH4;
_caller removeAction SUPMEN_attackH4Map;
_caller removeAction SUPMEN_attackH5;
_caller removeAction SUPMEN_attackH5Map;
_caller removeAction SUPMEN_tHeli1;
_caller removeAction SUPMEN_tHeli1Map;
_caller removeAction SUPMEN_tHeli2;
_caller removeAction SUPMEN_tHeli2Map;
_caller removeAction SUPMEN_tHeli3;
_caller removeAction SUPMEN_tHeli3Map;
_caller removeAction SUPMEN_tHeli4;
_caller removeAction SUPMEN_tHeli4Map;
_caller removeAction SUPMEN_tHeli5;
_caller removeAction SUPMEN_tHeli5Map;
_caller removeAction SUPMEN_tHeli6;
_caller removeAction SUPMEN_tHeli6Map;
_caller removeAction SUPMEN_cas;
_caller removeAction SUPMEN_trans;
_caller removeAction SUPMEN_exit;

openMap true;

titleText["Click on Map for Target","PLAIN"];

mapClicked = false;
onMapSingleClick "mapTarget = _pos; mapClicked = true;onMapSingleClick {}";

waitUntil {sleep 1; mapClicked};

_taskLetterArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S","T", "U", "V", "W", "X", "Y", "Z"];
_taskLetter = _taskLetterArray select (floor(random(count _taskLetterArray)));
_taskLetter2 = _taskLetterArray select (floor(random(count _taskLetterArray)));
_taskNumber = round (random 100);
_taskNumber2 = round (random 100);
_taskName = format ["%1%2%3%4", _taskLetter, _taskLetter2, _taskNumber, _taskNumber2];
_taskTaker = _driver;

if (isNull _taskTaker || !alive _taskTaker) exitWith {
    hint format ["%1 is not available for tasking", _tasktaker];
    SUPMEN_ACTIONS = _caller addAction ["<t color='#F07422'>Support Menu</t>", "scripts\supportMenu\supportMenu.sqf", [SUPMEN_attackHelis, SUPMEN_transportHelis], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
};

hint parsetext format ["Task <t color='#EB1EB8'>%1</t> Assigned to <t color='#ECF70C'>%2</t>", _taskName, name _taskTaker];

if (_type == "Attack") then {
    [_taskName, _caller, _tasktaker, mapTarget] call lampcreateTaskAttackAll;
    SUPMEN_succeed = _caller addAction["<t color='#F07422'>Close Air Support Request Successful</t>", "scripts\supportMenu\endTask.sqf", [_taskName,"Succeeded", _taskTaker], -998, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
    SUPMEN_fail = _caller addAction["<t color='#F07422'>Close Air Support Request Failed</t>", "scripts\supportMenu\endTask.sqf", [_taskName,"Failed", _taskTaker], -998, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
    SUPMEN_cancel = _caller addAction["<t color='#F07422'>Close Air Support Request Canceled</t>", "scripts\supportMenu\endTask.sqf", [_taskName,"Canceled", _taskTaker], -998, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
};

if (_type == "Transport") then {
    [_taskName, _caller, _taskTaker, mapTarget] call lampcreateTaskTransportAll;
    SUPMEN_succeed = _caller addAction["<t color='#F07422'>Transport Successful</t>", "scripts\supportMenu\endTask.sqf", [_taskName,"Succeeded", _taskTaker], -998, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
    SUPMEN_fail = _caller addAction["<t color='#F07422'>Transport Failed</t>", "scripts\supportMenu\endTask.sqf", [_taskName,"Failed", _taskTaker], -998, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
    SUPMEN_cancel = _caller addAction["<t color='#F07422'>Transport Canceled</t>", "scripts\supportMenu\endTask.sqf", [_taskName,"Canceled", _taskTaker], -998, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
};

waitUntil {sleep 1; _tasktaker distance mapTarget < 1500 || (!alive _caller) || "Failed" == _taskName call SHK_Taskmaster_getState || "Succeeded" == _taskName call SHK_Taskmaster_getState || "Canceled" == _taskName call SHK_Taskmaster_getState || !alive _tasktaker};

if (_type == "Attack") then {
    smokeRed = "SmokeShellRed" createVehicle mapTarget;
    smokeGreen = "SmokeShellGreen" createVehicle (getPos _caller);
};
if (_type == "Transport") then {
    smokeYellow = "SmokeShellYellow" createVehicle mapTarget;
};

waitUntil {sleep 1; (!alive _caller) || "Failed" == _taskName call SHK_Taskmaster_getState || "Succeeded" == _taskName call SHK_Taskmaster_getState || "Canceled" == _taskName call SHK_Taskmaster_getState || !alive _tasktaker};

if (!alive _caller || !alive _taskTaker) then {
    _taskState = "canceled";
    [_taskName, _taskState] call lamptaskUpdateAll;
};

if true exitWith {};