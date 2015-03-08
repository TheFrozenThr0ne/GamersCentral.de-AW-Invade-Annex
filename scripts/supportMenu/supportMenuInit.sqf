private ["_caller"];
_caller = _this select 0;
SUPMEN_attackHelis = _this select 1;
SUPMEN_transportHelis = _this select 2;
SUPMEN_ACTIONS = _caller addAction ["<t color='#F07422'>Support Menu</t>", "scripts\supportMenu\supportMenu.sqf", [SUPMEN_attackHelis, SUPMEN_transportHelis], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];

player addEventHandler ["Respawn", {
        SUPMEN_ACTIONS = player addAction ["<t color='#F07422'>Support Menu</t>", "scripts\supportMenu\supportMenu.sqf", [SUPMEN_attackHelis, SUPMEN_transportHelis], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
    }
];