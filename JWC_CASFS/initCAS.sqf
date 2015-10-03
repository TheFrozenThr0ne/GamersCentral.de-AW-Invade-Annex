///////////////// user settings ////////////////////////////////////////////////////////////////////////////////////

JWC_MaxD = 800;                                // Max distance in meters allowed between requester and target
JWC_lock = true;                               // If true CAS can only be called in by the unit the addAction is tied to.
JWC_num  = 20;                                 // Set number of CAS calls available for per unit
JWC_napalmExpire = 500;                       // Time in seconds the napalm fire will live
JWC_disallowedMunition = ["CBU"];              // Add names of disallowed munition: "JDAM", "CBU" or "NAPALM"
JWC_restrictedZones = [nobomb2];       // Add triggers as objects which defines disallowed CAS zones, like bases in TDM etc. leave empty [] if there is no restrictions.
JWC_CASarray = ["CAS1"];         // Add CAS init names to this array. 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



"JWC_serverDamage" addPublicVariableEventHandler
{
  _arr = _this select 1;
  JWC_pos1 = _arr select 0;
  JWC_expire1 = _arr select 1;

  [JWC_pos1, JWC_expire1] spawn
  {
    _pos = _this select 0;
    _expire = _this select 1;
    _obj = createAgent ["Logic", [_pos select 0, _pos select 1, 0], [] , 0 , "CAN_COLLIDE"];

    while{_expire >= time}do
    {
      {
        if (_x distance _obj <= 50) then {_x setdammage 1 + (getdammage _x)};
        if (_x distance _obj <= 70) then {_x setdammage .07 + (getdammage _x)};
        if (_x distance _obj <= 100) then {_x setdammage .04 + (getdammage _x)};
      } forEach nearestObjects [_obj, ["Man"], 100];
      {
        if (_x distance _obj <= 50) then {_x setdammage .08 + (getdammage _x)};
        if (_x distance _obj <= 70) then {_x setdammage .03 + (getdammage _x)};
        if (_x distance _obj <= 100) then {_x setdammage .01 + (getdammage _x)};
      } forEach nearestObjects [_obj, ["Motorcycle"], 100];
      {
        if (_x distance _obj <= 30) then {_x setdammage .2 + (getdammage _x)};
        if (_x distance _obj <= 50) then {_x setdammage .05 + (getdammage _x)};
        if (_x distance _obj <= 70) then {_x setdammage .01 + (getdammage _x)};
        if (_x distance _obj <= 100) then {_x setdammage .005 + (getdammage _x)};
      } forEach nearestObjects [_obj, ["CAR"], 100];
      {
        if (_x distance _obj <= 30) then {_x setdammage .2 + (getdammage _x)};
        if (_x distance _obj <= 50) then {_x setdammage .05 + (getdammage _x)};
        if (_x distance _obj <= 70) then {_x setdammage .01 + (getdammage _x)};
        if (_x distance _obj <= 100) then {_x setdammage .005 + (getdammage _x)};
      } forEach nearestObjects [_obj, ["Air"], 100];
      {
        if (_x distance _obj <= 30) then {_x setdammage .02 + (getdammage _x)};
        if (_x distance _obj <= 50) then {_x setdammage .01 + (getdammage _x)};
        if (_x distance _obj <= 70) then {_x setdammage .005 + (getdammage _x)};
      } forEach nearestObjects [_obj, ["Tank"], 100];
      sleep 0.5;
    };
  };
};

if !(vehicleVarName player in JWC_CASarray) exitWith {};

waitUntil {!isNull player};
waitUntil {player == player};

JWC_abortCAS    = false;
JWC_waitCAS     = false;
JWC_doSnap      = false;
JWC_firstRun    = true;
JWC_onKeyPress  = compile preprocessFile "JWC_CASFS\snap.sqf";

if (isMultiplayer) exitWith {};

[JWC_MaxD, JWC_lock, JWC_num] execVM "JWC_CASFS\addAction.sqf";