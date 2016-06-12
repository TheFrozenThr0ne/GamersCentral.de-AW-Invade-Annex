//spawnGroup  1.0 by SPUn
if(!isServer)exitWith{};
private ["_array","_faction","_group","_side","_base","_grp","_tempGrp","_lifes","_setBase","_task","_delay","_air","_azi","_basePos"];

_array = _this select 0;
_faction = _this select 1;
_group = _this select 2;

_group setVariable ["state", "spawning"];

_delay = _group getVariable "delay";
sleep _delay;

switch(_faction)do{
	case "BLU_F":{
		_side = west;
	};
	case "BLU_G_F":{
		_side = west;
	};
	case "OPF_F":{
		_side = east;
	};
	default {
		_side = resistance;
	};
};
if((_side == west)&&(!AIRS_respawn_WEST))exitWith{};
if((_side == east)&&(!AIRS_respawn_EAST))exitWith{};
if((_side == resistance)&&(!AIRS_respawn_INDE))exitWith{};

_setBase = _group getVariable "base";
if(isNil("_setBase"))then{
	if(_side == resistance)then{
		_base = "respawn_guerrila";
	}else{
		_base = "respawn_" + (str _side);
	};
	_basePos = getMarkerPos _base;
}else{
	if((typeName _setBase) == "ARRAY")then{
		if((_setBase select 0) in allMapMarkers)then{
			_base = _setBase call BIS_fnc_selectRandom;
			_basePos = getMarkerPos _base;
		}else{
			_basePos = _setBase;
		};
	}else{
		_basePos = getMarkerPos _setBase;
	};
};
_air = _group getVariable "air";
_azi = _group getVariable "azi";
_grp = [_basePos, _side, _array,nil,nil,nil,nil,nil,_azi,_air] call AIRS_fnc_spawnGroup;

_tempGrp = [];
{ _tempGrp set[(count _tempGrp),_x] }forEach units _grp;

_tempGrp joinSilent _group;
deleteGroup _grp;

_lifes = _group getVariable "lifes";
if(_lifes > 0)then{
	if(_lifes > 1)then{
		_lifes = _lifes - 1;
		_group setVariable ["lifes", _lifes];
	}else{
		_group setVariable ["classnames", nil];
		_group setVariable ["lifes", nil];
		_group setVariable ["task", nil];
		_group setVariable ["base", nil];
		_group setVariable ["state", nil];
		_group setVariable ["delay", nil];
		_group setVariable ["air", nil];
		_group setVariable ["azi", nil];
	};
};
_group setVariable ["state", "alive"];
_task = _group getVariable "task";
if(!isNil("_task"))then{ [_group] call AIRS_StartTask; };