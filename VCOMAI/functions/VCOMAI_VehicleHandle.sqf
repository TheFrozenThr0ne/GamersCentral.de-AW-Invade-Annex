//Created on ???
// Modified on : 8/19/14 - 8/3/15 - 9/1/15

_Unit = _this select 0;

_myNearestEnemy = _this select 1;
if (_myNearestEnemy isEqualTo []) exitWith {};

_UnitSide = side _Unit;
_SideCheck = _Unit call VCOMAI_FriendlyArray;

_UnitGroup = group _Unit;
_GroupUnits = units _UnitGroup;
_Vehicle = (vehicle _Unit);
_CargoList = assignedCargo _Vehicle;
_CargoGroup = [];

if ((count _CargoList) isEqualTo 0) exitWith {};

_CargoListSelection = _CargoList call BIS_fnc_selectRandom;
_CargoGroup = group _CargoListSelection;



	
	if ((_myNearestEnemy distance _Unit) < 400) then {
	{
	if ((getPos _Vehicle select 2) < 3) then 
	{
		unassignVehicle _x;
		commandGetOut _x;
		doGetOut _x;
		_x action ["eject", _Vehicle];
	}
	else
	{
	//(driver (vehicle _Unit)) setBehaviour "Careless"; // He stays relaxed, even if enemies are around
	//(driver (vehicle _Unit)) setCombatMode "Blue"; // He won't attack anything, anymore 
	//(driver (vehicle _Unit)) setCaptive true;
	(driver (vehicle _Unit)) land "LAND";
	_Vehicle land "LAND";
	waitUntil {(getPos _Vehicle select 2) < 15;};
	_Vehicle engineOn false;
	waitUntil {(getPos _Vehicle select 2) < 1.5;};
	_myNearestEnemy = [_Unit] call VCOM_fnc_ClosestEnemy;
		if (isNil "_myNearestEnemy") exitWith {};

	unassignVehicle _x;
	commandGetOut _x;
	doGetOut _x;
	_x orderGetIn [false];
	_x action ["eject", _Vehicle];
	
	_waypoint0 = (group _x) addwaypoint[(getPosASL _myNearestEnemy),0];
	_waypoint0 setwaypointtype "MOVE";
	_waypoint0 setWaypointSpeed "NORMAL";
	_waypoint0 setWaypointBehaviour "AWARE";
	(group _x) setCurrentWaypoint [(group _x),(_waypoint0 select 1)];
	
	sleep 0.5;

	
	};
	
	} foreach _CargoList;
	

	_ClosestUnit = [_SideCheck,_Unit] call BIS_fnc_nearestPosition;
	
	//Delete Vehicles current waypoints
	while {(count (waypoints _UnitGroup)) > 0} do
	{
	deleteWaypoint ((waypoints _UnitGroup) select 0);
	sleep 0.25;
	};
	//Get vehicle to stop moving
	_ResetWaypoint = _UnitGroup addwaypoint [getPosATL _Unit,0];
	
	doStop _Unit;
	doStop _Vehicle;
	_Unit doMove (getPosATL _ClosestUnit);
	_Vehicle doMove (getPosATL _ClosestUnit);
	_Vehicle engineOn true;
};


