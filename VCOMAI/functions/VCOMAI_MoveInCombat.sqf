private ["_Unit", "_UnitGroup", "_index", "_wPos", "_NearestEnemy", "_unit","_GuessLocation"];

_Unit = _this;

if (_Unit getVariable "VCOM_MovedRecentlyCover" || {_Unit getVariable "VCOMAI_ActivelyClearing"} || {_Unit getVariable "VCOMAI_StartedInside"} || {_Unit getVariable "VCOM_GARRISONED"}) exitWith {};
_UnitGroup = group _Unit;

//_index = currentWaypoint _UnitGroup;
//_wPos = waypointPosition [_UnitGroup, _index];
//_wPos = getpos (leader _Unit);
_NearestEnemy = _Unit call VCOMAI_ClosestEnemy;
if ((typeName _NearestEnemy isEqualTo "ARRAY") || {_NearestEnemy isEqualTo []}) exitWith {};
_GuessLocation = _Unit getHideFrom _NearestEnemy;		

_wPos = [_GuessLocation, ((leader _Unit) distance _NearestEnemy) + 2, ([_GuessLocation, (leader _Unit)] call BIS_fnc_dirTo)] call BIS_fnc_relPos;
//hint format ["%1",_wPos];

_Unit setVariable ["VCOM_MovedRecently",true,false];


/*
_Unit forceSpeed 0;

_NearestEnemy = _Unit call VCOMAI_ClosestEnemy;
_Unit lookAt (getposATL _NearestEnemy);
_Unit setUnitPos "AUTO";


*/

_Unit forceSpeed -1;

//dostop _Unit;
_Unit moveTo _wPos;
_Unit lookAt (getposATL _NearestEnemy);

waitUntil {_unit getVariable "VCOM_VisuallyCanSee"};
_Unit forceSpeed 0;
sleep 0.25;
_Unit forceSpeed -1;

_Unit spawn
{
	sleep 10;
	_this setVariable ["VCOM_MovedRecently",false,false];
};