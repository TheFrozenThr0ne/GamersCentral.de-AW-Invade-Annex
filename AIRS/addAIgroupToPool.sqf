/*addAIgroupToPool  1.0 by SPUn
	nul = [this,[target,style],lifes,base,delay,air] execVM "AIRS\addAIgroupToPool.sqf";
		0:	this or leader of group			[mandatory]
		1:	[target,style] (waypoint & task)[optional] default: nothing
			0:	object or "marker"
			1:	"attack" / "defend" / "patrol" / "waypoint" / "domove" / "building" / "buildings"
		2:	number of lifes (0 = unlimited)	[optional] default: 0
		3:	marker (where units will spawn) [optional] default: respawn_west / respawn_east / respawn_guerrila
			array  (multiple markers, one is picked randomly on every spawn)
			"original" = position where unit spawns the very first time
		4:	delay  (spawn delay)			[optional] default: the one defined at AIrespawnInit.sqf
		5:	air    (vehicle spawns flying)	[optional] default: false
*/
if(!isServer)exitWith{};
waitUntil{!isNil("AIRS_Initialized")};
private["_grp","_classnames","_lifes","_task","_base","_delay","_vehicles","_air","_azi"];

_grp = group (_this select 0);
_task = if(count _this > 1)then{_this select 1}else{nil};
_lifes = if(count _this > 2)then{_this select 2}else{0};
_base = if(count _this > 3)then{_this select 3}else{nil};
_delay = if(count _this > 4)then{_this select 4}else{AIRS_respawn_delay};
_air = if(count _this > 5)then{_this select 5}else{false};
_classnames = [];
_vehicles = [];
{
	if(vehicle _x != _x)then{
		if(_x == (driver (vehicle _x)))then{ 
			_classnames set[(count _classnames),(typeOf (vehicle _x))];
		};
		if(!((vehicle _x) in _vehicles))then{_vehicles set[(count _vehicles),(vehicle _x)]};
		_azi = direction (vehicle _x);
	}else{
		_classnames set[(count _classnames),(typeOf _x)];
	};
}forEach units _grp;
_grp setVariable ["classnames", _classnames];
_grp setVariable ["lifes", _lifes];
_grp setVariable ["state", "alive"];
_grp setVariable ["delay", _delay];
_grp setVariable ["air", _air];
if(isNil("_azi"))then{_azi = (random 360)};
_grp setVariable ["azi", _azi];
if(!isNil("_base"))then{
	if(_base == "original")then{
		_grp setVariable ["base", (getPos (leader _grp))];
	}else{
		_grp setVariable ["base", _base];
	};
};
if(!isNil("_task"))then{_grp setVariable ["task", _task]; [_grp] call AIRS_StartTask;};
{ [_x] spawn AIRS_DestroyEmptyVehicle }forEach _vehicles;