private ["_caller","_attackHelis","_transportHelis"];
_caller = _this select 1;
_caller removeAction SUPMEN_actions;
_attackHelis = ((_this select 3) select 0);
_transportHelis = ((_this select 3) select 1);

if (count _attackHelis > 0) then {
    SUPMEN_cas = _caller addAction["<t color='#F07422'>Call for CAS</t>", "scripts\supportMenu\callMenu.sqf", ["attackHelis", _attackHelis], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
};
if (count _transportHelis > 0) then {
    SUPMEN_trans = _caller addAction["<t color='#F07422'>Call for Transport</t>", "scripts\supportMenu\callMenu.sqf", ["transportHelis", _transportHelis], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
};
SUPMEN_exit = _caller addAction["<t color='#F07422'>Exit Support Menu</t>", "scripts\supportMenu\exitMenu.sqf", nil, -101, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];

if true exitWith {};