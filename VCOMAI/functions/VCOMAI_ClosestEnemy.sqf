private ["_Unit", "_UnitSide", "_Array1", "_ReturnedEnemy"];
//Created on ???
// Modified on : 8/19/14 - 8/3/15

_Unit = _this;
_UnitSide = (side _Unit);
_Array1 = [];
{
	if ((side _x) != (_UnitSide) && !((side _x) isEqualTo CIVILIAN)) then {_Array1 pushback _x;};
} forEach allUnits;

_ReturnedEnemy = [_Array1,_Unit] call BIS_fnc_nearestPosition;

//_Unit setVariable ["VCOM_CLOSESTENEMY",_ReturnedEnemy,false];
_ReturnedEnemy