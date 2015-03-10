/*
	Based Of drsubo Mission Scripts
	File: initMplus.sqf
	Author: Cammygames, drsubo, drsubo
*/

_minTime = 10*60; //5 minutes 
_maxTime = 25*60; //30 minutes

_sleepTime = (random (_maxTime - _minTime)) + _minTime;
sleep _sleepTime;

_n1 = floor(random 5);		

switch (_n1) do
{
	case 0:
		{
			execVM "mission\second\mission\supplyVanCrash.sqf";
		};
	case 1:
		{
			execVM "mission\second\mission\bCamp.sqf";
		};
	case 2:
		{
			execVM "mission\second\mission\bDevice.sqf";
		};
	case 3:
		{
			execVM "mission\second\mission\bHeliCrash.sqf";
		};
	case 4:
		{
			execVM "mission\second\mission\bPlaneCrash.sqf";
		};
};


