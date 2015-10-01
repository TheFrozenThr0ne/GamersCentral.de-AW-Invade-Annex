private ["_velocityZ"];

JWC_waitCAS = true;

_object = _this select 0;
_distance = _this select 1;
_doLock = _this select 2;
_num = _this select 3;
_casType = _this select 4;
_loc = getMarkerPos (_this select 5);
_id = _this select 6;

player removeAction _id;
_str = format["<t color='#FF1000'>Cancel CAS</t>"];
_cancel = player addAction [_str, "JWC_CASFS\cancelCAS.sqf", nil, -1, false, true, ""];


_lockobj = createAgent ["Logic", [(_loc select 0), (_loc select 1), 0], [] , 0 , "CAN_COLLIDE"];
_lockobj setPos _loc;

_lck = getPosASL _lockobj select 2;

_loc = visiblePosition _lockobj;

_dir = random 360;
_dis = 4000;
_ranPos = [(_loc select 0) + _dis * sin _dir, (_loc select 1) + _dis * cos _dir, 350];


_grp = createGroup west;
_buzz = createVehicle ["I_Plane_Fighter_03_CAS_F", _ranPos, [], 0, "FLY"];


[_buzz] execVM "JWC_CASFS\track.sqf";
_buzz setVectorDir [(_loc select 0)-(getPos _buzz select 0),(_loc select 1)-(getPos _buzz select 1),0];
sleep 0.2;
_dir = getDir _buzz;
_buzz setVelocity [sin(_dir)*200,cos(_dir)*200,0];
_pilot = _grp createUnit ["B_Pilot_F", _ranPos, [], 0, "FORM"];
_pilot moveinDriver _buzz;


_buzz setCaptive true;
_buzz allowDamage false;

(leader _grp) sideChat "Cordinates recieved, CAS inbound";

_grp setBehaviour "STEALTH";
_grp setSpeedMode "FULL";
_grp setCombatMode "BLUE";

(driver _buzz) doMove [_loc select 0, _loc select 1, 350];

doCounterMeasure =
{
  _plane = _this select 0;
  for "_i" from 1 to 4 do
  {
    _bool = _plane fireAtTarget [_plane,"CMFlareLauncher"];
    sleep 0.3;
  };
  sleep 3;
  _plane = _this select 0;
  for "_i" from 1 to 4 do
  {
    _bool = _plane fireAtTarget [_plane,"CMFlareLauncher"];
    sleep 0.3;
  };
};

while {true} do
{
  if (_buzz distance _lockobj <= 580) exitwith {};
  if (!alive _buzz) exitwith {};
  if (JWC_abortCAS) exitWith {};
  sleep 0.01;
};

if (!alive _buzz) exitwith
{
  casRequest = false;
  deleteMarker "JWC_CAS_TARGET";
};

JWC_waitCAS = false;

if (JWC_abortCAS) exitWith
{
  _buzz move _ranPos;
  (leader _grp) sideChat "CAS mission aborted";
  JWC_abortCAS = false;
  waitUntil{_buzz distance _object >= 2000 || !alive _buzz};
  {
    deleteVehicle vehicle _x;
    deleteVehicle _x;
  } forEach units _grp;
};

_vehName = vehicleVarName player;
_variables = varHolder getVariable _vehName;
_maxDist = _variables select 0;
_lock = _variables select 1;
_num = _variables select 2;

_num = _num - 1;

settingsCAS = [_maxDist,_lock,_num,_vehName];
varHolder setVariable [_vehName, settingsCAS, true];

player removeAction _cancel;

if (alive player && _num > 0) then
{
  _str = format["<t color='#FF9000'>Open CAS Field System (%1)</t>",_num];
  player addAction [_str, "JWC_CASFS\casMenu.sqf", [_maxDist, _lock, _num], -1, false, true, ""];
};

[_buzz] spawn doCounterMeasure;

(leader _grp) sideChat "Bomb dropped";


if ((alive _buzz) && (_casType == "JDAM")) then
{
  _drop = createAgent ["Logic", [getPos _buzz select 0, getPos _buzz select 1, 0], [] , 0 , "CAN_COLLIDE"]; 
  _height = 225 + _lck;
  _ASL = getPosASL _drop select 2;
  _height = _height - _ASL;
  _bomb = "Bo_GBU12_LGB" createvehicle [getPos _drop select 0, getPos _drop select 1, _height];
  _bomb setDir ((_loc select 0)-(getPos _bomb select 0)) atan2 ((_loc select 1)-(getPos _bomb select 1));
  _dist = _bomb distance _loc;
  if (_dist >= 536) then
  {
    _diff = _dist - 536;
    _diff = _diff * 0.150;   
    _velocityZ = 85 - _diff;
  };
  if (_dist < 536) then
  {
    _diff = 536 - _dist;
    _diff = _diff * 0.150;   
    _velocityZ = 85 + _diff;
  };
  _bDrop = sqrt(((getPosASL _bomb select 2)-_lck)/4.9);
  _bVelX = ((_loc select 0)-(getPos _bomb select 0))/_bDrop;
  _bVelY = ((_loc select 1)-(getPos _bomb select 1))/_bDrop;
  _bomb setVelocity [_bVelX,_bVelY,(velocity _bomb select 2) - _velocityZ];
  deleteVehicle _drop;
};

if ((alive _buzz) && (_casType == "CBU")) then
{
  _drop = createAgent ["Logic", [getPos _buzz select 0, getPos _buzz select 1, 0], [] , 0 , "CAN_COLLIDE"]; 
  _height = 225 + _lck;
  _ASL = getPosASL _drop select 2;
  _height = _height - _ASL;
  _height = _height + 40;
  _cbu = "Bo_GBU12_LGB" createvehicle [getPos _drop select 0, getPos _drop select 1, _height];
  _cbu setDir ((_loc select 0)-(getPos _cbu select 0)) atan2 ((_loc select 1)-(getPos _cbu select 1));
  _dist = _cbu distance _loc;
  if (_dist > 536) then
  {
    _diff = _dist - 536;
    _diff = _diff * 0.150;   
    _velocityZ = 85 - _diff;
  };
  if (_dist < 536) then
  {
    _diff = 536 - _dist;
    _diff = _diff * 0.150;   
    _velocityZ = 85 + _diff;
  };
  _bDrop = sqrt(((getPosASL _cbu select 2)-_lck)/4.9);
  _bVelX = ((_loc select 0)-(getPos _cbu select 0))/_bDrop;
  _bVelY = ((_loc select 1)-(getPos _cbu select 1))/_bDrop;
  _cbu setVelocity [_bVelX,_bVelY,(velocity _cbu select 2) - _velocityZ];
  waitUntil{getPos _cbu select 2 <= 40};
  _pos = getPos _cbu;
  _effect = "SmallSecondary" createvehicle _pos;
  deleteVehicle _cbu;
  for "_i" from 1 to 35 do
  {
    _explo = "G_40mm_HEDP" createvehicle _pos;
    _explo setVelocity [-35 + (random 70),-35 + (random 70),-50];
    sleep 0.025;
  };
  deleteVehicle _drop;
};

if ((alive _buzz) && (_casType == "NAPALM")) then
{
  _drop = createAgent ["Logic", [getPos _buzz select 0, getPos _buzz select 1, 0], [] , 0 , "CAN_COLLIDE"]; 
  _height = 225 + _lck;
  _ASL = getPosASL _drop select 2;
  _height = _height - _ASL;
  _bomb = "bomb_04_f" createvehicle [getPos _drop select 0, getPos _drop select 1, _height];
  _bomb setDir ((_loc select 0)-(getPos _bomb select 0)) atan2 ((_loc select 1)-(getPos _bomb select 1));
  _dist = _bomb distance _loc;
  if (_dist >= 536) then
  {
    _diff = _dist - 536;
    _diff = _diff * 0.150;   
    _velocityZ = 85 - _diff;
  };
  if (_dist < 536) then
  {
    _diff = 536 - _dist;
    _diff = _diff * 0.150;   
    _velocityZ = 85 + _diff;
  };
  _bDrop = sqrt(((getPosASL _bomb select 2)-_lck)/4.9);
  _bVelX = ((_loc select 0)-(getPos _bomb select 0))/_bDrop;
  _bVelY = ((_loc select 1)-(getPos _bomb select 1))/_bDrop;
  _bomb setVelocity [_bVelX,_bVelY,(velocity _bomb select 2) - _velocityZ];
  deleteVehicle _drop;

  private['_pos'];

  while {alive _bomb} do
  {
    _pos = getposASL _bomb;
    sleep .01;
  };

  _napalmExpire = time + JWC_napalmExpire;

  [[[_pos, _napalmExpire],"JWC_CASFS\napalm.sqf"],"BIS_fnc_execVM",true,true] call BIS_fnc_MP;

  JWC_serverDamage = [_pos, JWC_napalmExpire];
  publicVariableServer "JWC_serverDamage";
};

deleteVehicle _lockobj;

casRequest = false;

deleteMarker "JWC_CAS_TARGET";

_grp = group _buzz;

waitUntil{_buzz distance _object >= 2000 || !alive _buzz};

{
  deleteVehicle vehicle _x;
  deleteVehicle _x;
} forEach units _grp;
