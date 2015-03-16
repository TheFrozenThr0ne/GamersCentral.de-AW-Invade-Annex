private ["_caller","_taskState","_taskName","_taskTaker"];
_caller = _this select 1;
_taskName = (_this select 3) select 0;
_taskState = (_this select 3) select 1;
_taskTaker = (_this select 3) select 2;

deleteVehicle smokeRed;
deleteVehicle smokeGreen;
deleteVehicle smokeYellow;

_caller removeAction SUPMEN_succeed;
_caller removeAction SUPMEN_fail;
_caller removeAction SUPMEN_cancel;
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
_caller removeAction SUPMEN_attackH6;
_caller removeAction SUPMEN_attackH6Map;
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
_caller removeAction SUPMEN_tHeli7;
_caller removeAction SUPMEN_tHeli7Map;
_caller removeAction SUPMEN_cas;
_caller removeAction SUPMEN_trans;
_caller removeAction SUPMEN_exit;

[_taskName, _taskState] call lamptaskUpdateAll;

hint parsetext format ["Task assigned to <t color='#ECF70C'>%2</t> %3", _taskName, name _taskTaker, _taskState];

SUPMEN_ACTIONS = _caller addAction ["<t color='#F07422'>Support Menu</t>", "scripts\supportMenu\supportMenu.sqf", [SUPMEN_attackHelis, SUPMEN_transportHelis], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];

if true exitWith {};