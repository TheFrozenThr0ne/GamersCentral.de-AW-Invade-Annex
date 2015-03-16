private ["_caller"];
_caller = _this select 1;

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

SUPMEN_ACTIONS = _caller addAction ["<t color='#F07422'>Support Menu</t>", "scripts\supportMenu\supportMenu.sqf", [SUPMEN_attackHelis, SUPMEN_transportHelis], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];

if true exitWith {};