private ["_Unit", "_coverObjects", "_startingdistance", "_class", "_return", "_parents", "_BoundingArray", "_p1", "_p2", "_maxWidth", "_maxLength", "_GroupLeader", "_unit", "_NearestEnemy", "_GuessLocation", "_coverObjectsClosest", "_Closestobject", "_coverObjectspos", "_arrow", "_UnitGroup", "_OriginalSpeed", "_WaitTime"];

_Unit = _this;

if (_Unit getVariable "VCOM_MovedRecentlyCover" || {_Unit getVariable "VCOMAI_ActivelyClearing"} || {_Unit getVariable "VCOMAI_StartedInside"} || {_Unit getVariable "VCOM_GARRISONED"}) exitWith {};
_Unit setVariable ["VCOM_MovedRecentlyCover",true,false];

_this spawn {
sleep 10;
	_this setVariable ["VCOM_MovedRecentlyCover",false,false];
};

_coverObjects = [];
_startingdistance = 20;
while {count _coverObjects < 20} do
{
	_coverObjects = nearestobjects [position _Unit,[],_startingdistance];
	sleep 0.1;
	_startingdistance = _startingdistance + 5;
};

if ((count _coverObjects) < 1) exitWith {};

//Lets filter these objects
{
	_class = typeof _x;
	if (!(isNil ("_class"))) then {
	_return = (configFile >> "cfgVehicles" >> _class);
	if (!(isNil ("_return"))) then {
	_parents = [_return,true] call BIS_fnc_returnParents;
	if ("Man" in _parents) then {_coverObjects = _coverObjects - [_x];};
	if ("Logic" in _parents) then {_coverObjects = _coverObjects - [_x];};
	if ("Helper_Base_F" in _parents) then {_coverObjects = _coverObjects - [_x];};
	};
	};
	
	_BoundingArray = boundingBoxReal _x;
	_p1 = _BoundingArray select 0;
	_p2 = _BoundingArray select 1;
	_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
	_maxLength = abs ((_p2 select 1) - (_p1 select 1));
	_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
	
	if ((_maxWidth < 2) && ((_maxLength) < 2) && (_maxHeight < 2)) then {_coverObjects = _coverObjects - [_x];};
	
} foreach _coverObjects;


if ((count _coverObjects) < 1) exitWith 
{

};
	
		
_NearestEnemy = _Unit findNearestEnemy _Unit;
_GuessLocation = _Unit getHideFrom _NearestEnemy;		

if (isNull _NearestEnemy) exitWith
{
	//Throw grenades and seek for any kind of cover
	_Unit spawn VCOMAI_ThrowGrenade;
};

_coverObjectsClosest = [];

for "_i" from 0 to 20 do 
	{
		_coverObjectsClosest pushback (_coverObjects call BIS_fnc_selectRandom);
	};

	_Closestobject = _coverObjectsClosest call BIS_fnc_selectRandom;

	_BoundingArray = boundingBoxReal _Closestobject;
	_p1 = _BoundingArray select 0;
	_p2 = _BoundingArray select 1;
	_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
	
	_coverObjectspos = [_GuessLocation, (_Closestobject distance _NearestEnemy) + 2, ([_GuessLocation, _Closestobject] call BIS_fnc_dirTo)] call BIS_fnc_relPos;
	//_arrow = "Sign_Arrow_Pink_F" createVehicle [0,0,0];
	//_arrow setposATL _coverObjectspos;
	//player setposATL _coverObjectspos;
	//_Unit disableAI "SUPPRESSION";
	//_Unit disableAI "TARGET";
	//_Unit disableAI "AUTOTARGET";
	//_Unit disableAI "FSM";
	//(group _Unit) lockwp true;
	_Unit setUnitPosWeak "MIDDLE";
	//_Unit doWatch objNull;
	if (_Unit distance _coverObjectspos > 10) then {_Unit spawn VCOMAI_ThrowGrenade;};
	
	[_Unit,_coverObjectspos] spawn 
	{
		_Unit = _this select 0;
		_coverObjectspos = _this select 1;
		
		doStop _Unit;
		_WaitTime = diag_ticktime + 5;
		_Unit doMove _coverObjectspos;
		_Unit setVariable ["VCOM_InCover",false,false];
		waitUntil {!alive _Unit || {diag_ticktime > _WaitTime} || {_Unit distance _coverObjectspos < 1}};
		//_Unit enableAI "SUPPRESSION";
		//_Unit enableAI "TARGET";
		//_Unit enableAI "AUTOTARGET";
		//_Unit enableAI "SUPPRESSION";
		//(group _Unit) lockwp false;
		_Unit setUnitPos "AUTO";
		_Unit setVariable ["VCOM_InCover",true,false];
		//_Unit disableAI "FSM";
	};