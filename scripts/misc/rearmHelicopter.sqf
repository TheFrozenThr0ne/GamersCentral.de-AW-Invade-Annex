private ["_veh"];
_veh = _this select 0;

if (_veh isKindOf "ParachuteBase" || !alive _veh) exitWith {};

if (!(_veh isKindOf "air")) exitWith { 
	_veh vehicleChat "This pad is for aircraft service only, soldier!"; 
};

			
_veh vehicleChat "Servicing aircraft, please wait ...";

_veh setFuel 0;

//---------- RE-ARMING

sleep 10;

_veh vehicleChat "Re-arming ...";
if(_veh isKindOf "B_Heli_Light_01_armed_F") then {
_veh addmagazine "168Rnd_CMFlare_Chaff_Magazine";
_veh vehicleChat "Flares Added!";
};
if(_veh isKindOf "B_Heli_Light_01_F") then {
_veh addmagazine "168Rnd_CMFlare_Chaff_Magazine";
_veh vehicleChat "Flares Added!";
};

//---------- REPAIRING

sleep 10;

_veh vehicleChat "Repairing ...";

//---------- REFUELING

sleep 10;

_veh vehicleChat "Refueling ...";

//---------- FINISHED

sleep 10;

_veh setDamage 0;
_veh vehicleChat "Repaired (100%).";

_veh setVehicleAmmo 1;
_veh vehicleChat "Re-armed (100%).";

_veh setFuel 1;
_veh vehicleChat "Refuelled (100%).";

sleep 2;

_veh vehicleChat "Service complete.";