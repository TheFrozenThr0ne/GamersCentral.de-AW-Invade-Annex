private ["_type", "_message"];
_array = _this select 1;
_type = _this select 0;
[_type, [_array]] call BIS_fnc_showNotification;