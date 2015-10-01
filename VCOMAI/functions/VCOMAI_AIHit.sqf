_Unit = _this select 0;
if (isPlayer _Unit) exitWith {};
if ((vehicle _Unit) != _Unit) exitWith {};


//Lay down
_Unit setUnitPos "DOWN";

_Unit spawn VCOMAI_MoveToCover;