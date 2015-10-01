_id = _this select 2;
JWC_abortCAS = true;
player removeAction _id;

deleteMarker "JWC_CAS_TARGET";

_vehName = vehicleVarName player;
_variables = varHolder getVariable _vehName;
_maxDist = _variables select 0;
_lock = _variables select 1;
_num = _variables select 2;

if (alive player && _num > 0) then
{
  _str = format["<t color='#FF9000'>Open CAS Field System (%1)</t>",_num];
  player addAction [_str, "JWC_CASFS\casMenu.sqf", [_maxDist, _lock, _num], -1, false, true, ""];
};