private ["_eh1","_inArea","_pos","_unit","_zone1","_zone2","_dis"];
_unit = _this select 0;

_zone1 = getMarkerPos "respawn_west"; // marker name for the areas you want to protect
_zone2 = getMarkerPos "respawn_west";
_dis = 800;                             // distance from area safe zone starts



if ((_zone1 distance _unit > _dis) or (_zone2 distance _unit > _dis)) then {        //check if unit is in zone when script starts
   _inArea = false;
}else{
   _inArea = true;
   _eh1 = _unit addEventHandler ["fired", {deleteVehicle (_this select 6);}];
};



while {true} do {


   if (((_zone1 distance _unit < _dis) or (_zone2 distance _unit < _dis)) && (!_inArea)) then {      // check if unit enters

      _eh1 = _unit addEventHandler ["fired", {deleteVehicle (_this select 6);}];
      _inArea = true;
      hint "safe zone";
	  _unit allowDamage false;
   };


   if (((_zone1 distance _unit > _dis) or (_zone2 distance _unit > _dis)) && (_inArea)) then {       // check if unit exits

      _unit removeEventHandler ["fired", _eh1];
      _inArea = false;
      hint "You just left the safe zone";
	  _unit allowDamage true;
   };

sleep 1;

};