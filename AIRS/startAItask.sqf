//startAItask  1.0 by SPUn
if(!isServer)exitWith{};
private["_grp","_task","_target","_type","_targetPos","_wp","_buildings"];

_grp = _this select 0;
_task = _grp getVariable "task";

_target = _task select 0;
_type = _task select 1;

if(_target in allMapMarkers)then{
	_targetPos = getMarkerPos _target;
}else{
	if (typeName _target == "ARRAY") then{
		_targetPos = _target;
	}else{
		_targetPos = getPos _target;
	};
};

switch(_type)do{
	case "attack":{
		[_grp, _targetPos] call bis_fnc_taskAttack;
	};
	case "defend":{
		//[_grp, _targetPos] call bis_fnc_taskDefend;
		[_grp, _targetPos] call AIRS_taskDefend;
	};
	case "patrol":{
		//[_grp, _targetPos, 100] call bis_fnc_taskPatrol;
		[_grp, _targetPos, 20] call AIRS_taskPatrol;
	};
	case "waypoint":{
		_wp = _grp addWaypoint [_targetPos, 0];
		_wp setWaypointType "SAD";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointSpeed "FULL";
	};
	case "domove":{
		{ _x doMove _targetPos } forEach units _grp;
	};
	case "building":{
		_buildings = ["nearest one",_targetPos,50] call LV_nearestBuilding;
		[_grp,_buildings] call AIRS_buildingPatrol;
	};
	case "buildings":{
		_buildings = ["all in radius",_targetPos,100] call LV_nearestBuilding;
		[_grp,_buildings] call AIRS_buildingPatrol;
	};
};