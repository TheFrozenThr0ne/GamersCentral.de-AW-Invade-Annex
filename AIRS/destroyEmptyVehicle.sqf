//destroyEmptyVehicle 1.0 by SPUn
private["_vehicle"];

_vehicle = _this select 0;

while{true}do{
	if({alive _x} count crew _vehicle == 0)then{
		sleep 120;
		if({alive _x} count crew _vehicle == 0)exitWith{ _vehicle setDamage 1 };
	};
	sleep 20;
};
