zbe_deleteunitsnotleaderfnc = {
	{deleteVehicle _x;
	} forEach units _this - [leader _this];
};

zbe_deleteunitsnotleader = {
	{_x call zbe_deleteunitsnotleaderfnc;
	} forEach allGroups;
};

zbe_cache = {
	_toCache = (units _group) - [(_leader)];
	{if (!(isPlayer _x) && {!("driver" in assignedVehicleRole _x)}) then {
		_x enablesimulationglobal false;
		_x hideobjectglobal true;};
	} forEach _toCache;
	};

zbe_unCache = {
	{if (!(isPlayer _x) && {!("driver" in assignedVehicleRole _x)}) then {
		_x enablesimulationglobal true;
		_x hideobjectglobal false;};
	} forEach _toCache;
};

zbe_closestUnit = {
	private["_units", "_unit", "_dist", "_udist"];
	_units = _this select 0;
	_unit = _this select 1;
	_dist = 10^5;
	{_udist = _x distance _unit;
		if (_udist < _dist) then {
			_dist = _udist;};
		} forEach _units;
	_dist;
};

/* = {
	private ["_zbe_leader","_trigUnits"];
	_zbe_leader = _this select 0;
	_trigUnits = [];
		{if ((((side _x) getFriend (side _zbe_leader)) <= 0.6)) then {
		_trigUnits set [count _trigUnits, leader _x];
                };
        } forEach allGroups;
        _trigUnits = _trigUnits + ([] call BIS_fnc_listPlayers);
        _trigUnits;
};Old function that is no longer used, left here for reference*/

zbe_setPosLight = {
	{_testpos = (formationPosition _x);
		if (!(isNil "_testpos") && (count _testpos > 0)) then {
		if (!(isPlayer _x) && (vehicle _x == _x)) then {
			_x setPos _testpos;
				};
		};
	} forEach _toCache;
};

zbe_setPosFull = {
	{_testpos = (formationPosition _x);
	if (!(isNil "_testpos") && (count _testpos > 0)) then {
		if (!(isPlayer _x) && (vehicle _x == _x)) then {
				_x setPos _testpos;
				_x allowDamage false;
				[_x]spawn {sleep 3;(_this select 0) allowDamage true;};
			};
		};
	} forEach _toCache;
};

zbe_removeDead = {
	{if !(alive _x) then {
		_x enablesimulation true;
		_x hideobject false;
		if (zbe_debug) then {
			diag_log format ["ZBE_Cache %1 died while cached from group %2, uncaching and removing from cache loop",_x,_group];
		};
	_toCache = _toCache - [_x];
	};
	} forEach _toCache;
};

zbe_cacheEvent = {
	({_x distance _leader < _distance} count zbe_players > 0) || !isNull (_leader findNearestEnemy _leader)
};

zbe_vehicleCache = {
	_ex = [
	"Land_Pod_Heli_Transport_04_medevac_F", 
	"Land_Pod_Heli_Transport_04_covered_F", 
	"Land_Pod_Heli_Transport_04_repair_F", 
	"Land_Pod_Heli_Transport_04_fuel_F", 
	"Land_Pod_Heli_Transport_04_ammo_F",  
	"Land_Pod_Heli_Transport_04_box_F", 
	"Land_Pod_Heli_Transport_04_bench_F",
	"I_Heli_light_03_F", 
	"B_Heli_Transport_01_F",
	"O_Heli_Light_02_unarmed_F",
	"B_Heli_Light_01_F",
	"O_Heli_Transport_04_covered_F",
	"B_Heli_Transport_03_F",
	"I_Heli_Transport_02_F",
	"B_Heli_Transport_03_F", 
	"O_Heli_Transport_04_F", 
	"B_Quadbike_01_F", 
	"B_Truck_01_transport_F",
	"B_Truck_01_covered_F",
	"B_Truck_01_repair_F",
	"B_Truck_01_fuel_F",
	"B_Truck_01_medical_F",
	"I_APC_Wheeled_03_cannon_F",
	"I_APC_tracked_03_cannon_F",
	"B_APC_Tracked_01_rcws_F",
	"B_MBT_01_TUSK_F",
	"B_APC_Tracled_01_CRV_F",
	"B_APC_Wheeled_01_cannon_F",
	"O_MBT_02_cannon_F",
	"B_Heli_Attack_01_F",
	"B_Heli_Light_01_armed_F",
	"O_Heli_Attack_02_black_F",
	"O_Plane_CAS_02_F",
	"I_Plane_Fighter_03_CAS_F",
	"B_Plane_CAS_01_F",
	"I_Plane_Fighter_03_AA_F",
	"B_UGV_01_rcws_F",
	"B_UAV_02_F",
	"B_UAV_02_CAS_F",
	"I_MRAP_03_hmg_F", 
	"I_MRAP_03_gmg_F", 
	"B_MRAP_01_F", 
	"B_MRAP_01_hmg_F",
	"B_G_Offroad_01_armed_F",
	"O_Plane_CAS_02_F", 
	"B_APC_Tracked_01_AA_F", 
	"B_MBT_01_TUSK_F", 
	"B_UGV_01_rcws_F"
	];
	
	if !((typeOf _vehicle) in _ex) then {
		_vehicle enablesimulationglobal false;
	};
}; 

zbe_vehicleUncache = {
	_vehicle enablesimulationglobal true;
};