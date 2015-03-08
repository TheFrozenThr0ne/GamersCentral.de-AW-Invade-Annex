_timer = 300;

while { true } do
{		
	sleep 1;
	artyVehiclee vehicleChat "Artillery Rockets reload in 10 minutes.";
	sleep _timer;
	artyVehiclee vehicleChat "Artillery Rockets reload in 5 minutes.";
	sleep _timer;
	artyVehiclee removeMagazines "12Rnd_230mm_rockets";
	artyVehiclee vehicleChat "Artillery Rockets Magazines Removed.";
	sleep 1;
	artyVehiclee addMagazines ["12Rnd_230mm_rockets", 1];
	artyVehiclee vehicleChat "Artillery Rockets Magazines Reloaded.";
};