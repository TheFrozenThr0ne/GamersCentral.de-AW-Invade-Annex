private ["_Unit", "_NoFlanking", "_myNearestEnemy", "_GroupUnit", "_myEnemyPos", "_ResetWaypoint", "_OverWatch", "_unit", "_rnd", "_dist", "_dir", "_positions", "_myPlaces", "_RandomArray", "_RandomLocation", "_index", "_waypoint0", "_waypoint1", "_waypoint2", "_index2", "_wPos", "_UnitPosition", "_x1", "_y1", "_x2", "_y2", "_Midpoint", "_group_array", "_GroupCount", "_CoverCount", "_RandomUnit"];
//AI Waypoint Mock up using select best.
_Unit = _this;
if (_this getVariable "VCOM_MovedRecentlyCover" || {_this getVariable "VCOMAI_ActivelyClearing"} || {_this getVariable "VCOMAI_StartedInside"} || {_this getVariable "VCOM_GARRISONED"}) exitWith {};
if !(side _unit in VCOM_SideBasedMovement) exitWith {};

_NoFlanking = _Unit getVariable "VCOM_NOPATHING_Unit";
if (_NoFlanking) exitWith {};

_myNearestEnemy = _Unit call VCOMAI_ClosestEnemy;
if ((typeName _myNearestEnemy) isEqualTo "ARRAY") exitWith {};
 

if (_Unit getVariable "VCOM_FLANKING") exitWith {};
_Unit setVariable ["VCOM_FLANKING",true,false];


if (_Unit getVariable "VCOM_GARRISONED") exitWith {};


//Check to see if the AI should just press the advantage!
_GroupUnit = group _Unit;
_EnemyGroup = count (units (group _myNearestEnemy));
_GroupCount = count units _GroupUnit;
_myEnemyPos = (getposATL _myNearestEnemy);

if ((_EnemyGroup/_GroupCount) <= 0.5) exitWith
{ 
	while {(count (waypoints _GroupUnit)) > 0} do
	{
	deleteWaypoint ((waypoints _GroupUnit) select 0);
	sleep 0.25;
	};
	_waypoint2 = _GroupUnit addwaypoint[_myEnemyPos,0];
	_waypoint2 setwaypointtype "MOVE";
	_waypoint2 setWaypointSpeed "FULL";
	_waypoint2 setWaypointBehaviour "COMBAT";
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

sleep 0.25;
if (_myEnemyPos isEqualTo [0,0,0]) exitWith {_Unit setVariable["VCOM_FLANKING",false,false];_Unit spawn VCOMAI_FlankManeuver;};

while {(count (waypoints _GroupUnit)) > 0} do
{
 deleteWaypoint ((waypoints _GroupUnit) select 0);
 sleep 0.25;
};
_ResetWaypoint = _GroupUnit addwaypoint [getPosATL _Unit,0];

//_OverWatch = [_myEnemyPos] call BIS_fnc_findOverwatch;

//[_unit] call BIS_fnc_threat;

_rnd = random 100;
_dist = (_rnd + 100);
_dir = random 360;
_positions = [(_myEnemyPos select 0) + (sin _dir) * _dist, (_myEnemyPos select 1) + (cos _dir) * _dist, 0];

_myPlaces = selectBestPlaces [position _Unit, 500,"(4*hills + 4*forest + 4*houses) - (1000*deadBody) - sea + (2*trees)", 100, 5];
_RandomArray = _myPlaces call BIS_fnc_selectrandom;
_RandomLocation = _RandomArray select 0;



_group	= group _Unit;
_index = currentWaypoint _group;


_waypoint0 = _group addwaypoint[_RandomLocation,0];
_waypoint0 setwaypointtype "MOVE";
_waypoint0 setWaypointSpeed "NORMAL";
_waypoint0 setWaypointBehaviour "COMBAT";
_group setCurrentWaypoint [_group,(_waypoint0 select 1)];
_waypoint1 = _group addwaypoint[_positions,0];
_waypoint1 setwaypointtype "MOVE";
_waypoint1 setWaypointSpeed "NORMAL";
_waypoint1 setWaypointBehaviour "COMBAT";
_waypoint2 = _group addwaypoint[_myEnemyPos,0];
_waypoint2 setwaypointtype "MOVE";
_waypoint2 setWaypointSpeed "NORMAL";
_waypoint2 setWaypointBehaviour "COMBAT";

/*
_index2 = currentWaypoint _group;
_wPos = waypointPosition [_group, _index2];

_UnitPosition = getPosATL _Unit;


_x1 = _wPos select 0;
_y1 = _wPos select 1;
_x2 = _UnitPosition select 0;
_y2 = _UnitPosition select 1;
_Midpoint = [((_x1 + _x2)/2),((_y1 + _y2)/2),1];


//Individual Commands. To get the AI to move around more. While some cover.

_group_array = units _group;
_GroupCount = count _group_array;
_CoverCount = (round(_GroupCount * .33)); //10 -> 3
for "_i" from 1 to _CoverCount do {
	_group_array spawn {
	_RandomUnit = _this call BIS_fnc_selectRandom;
	_this = _this - [_RandomUnit];
	_RandomUnit suppressFor 5;
};
};
*/
