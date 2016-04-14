/*
| Author: 
|
|	BACONMOP
|_____
|
|   Description:	FOB stuffs
|	
|	Created: 20 October 2015
|	Last modified:
|	Coded for AhoyWorld.
*/
_FOB_mission_List = [
	"BasicSupply",
	"MedicalSupply",
	"AmmoSupply",
	"SpareParts",
	"FuelSupply"
];
Fob_missions = True;
_stillFob = true;
_missionsRuntime = _FOB_mission_List;

currentFOB = _this select 0;
vicPos1 = _this select 1;
vicPos2 = _this select 2;
heliPad1 = _this select 3;
repPad1 = _this select 4;
medPad1 = _this select 5;
fuelPad1 = _this select 6;
ammoPad1 = _this select 7;
apcPad1 = _this select 8;
supPad1 = _this select 9;


"FOB_Marker" setMarkerPos (getMarkerPos currentFOB);
_vicDir1 = (markerDir vicPos1);
_vicDir2 = (markerDir vicPos2);
	
_randomVehicles1 = ["B_MRAP_01_hmg_F","I_APC_Wheeled_03_cannon_F","B_MBT_01_cannon_F"];
_lightvic1 = (_randomVehicles1 call BIS_fnc_selectRandom) createVehicle getMarkerPos vicPos1;
_randomVehicles2 = ["B_MRAP_01_gmg_F","B_APC_Wheeled_01_cannon_F"];
_lightvic2 = (_randomVehicles2 call BIS_fnc_selectRandom) createVehicle getMarkerPos vicPos2;
//_lightvic1 = "B_MRAP_01_hmg_F" createVehicle (getMarkerPos vicPos1);
_lightvic1 setDir _vicDir1;
//_lightvic2 = "B_MRAP_01_hmg_F" createVehicle (getMarkerPos vicPos2);
_lightvic2 setDir _vicDir2;
_heliPadLz = "Land_HelipadSquare_F" createVehicle (getMarkerPos heliPad1);
deleteMarker "respawn_west1";
_respawnMarker2 = createMarker ["respawn_west1", _lightvic2];
_respawnMarker2 setMarkerShape "ICON";
_briefing = "<t align='center'><t size='2.2'>FOB created</t><br/><t size='1.5' color='#00B2EE'></t><br/>____________________<br/>We have created a FOB for you to use. Missions to supply it will soon be assigned.</t>";
[_briefing] remoteExec ["AW_fnc_globalHint",0,false];

sleep 60;
while{Fob_missions} do{
	
	while {_stillFob} do {
		_mission = _missionsRuntime  select (floor (random (count _missionsRuntime)));
		_missionsRuntime = _missionsRuntime - [_mission];
		_currentMission = execVM format["mission\Fob\%1.sqf", _mission]; 							
		waitUntil {sleep 5; (scriptDone _currentMission) || (!Fob_missions)};
		If ((count _missionsRuntime < 1) || (!Fob_missions)) then {
			_stillFob = false;
			Fob_missions = false;
			_briefing = "<t align='center'><t size='2.2'>FOB is stocked</t><br/><t size='1.5' color='#00B2EE'>Supplies delivered</t><br/>____________________<br/>All of the resources that we can spare have been used. Now use the FOB to it's full effect.</t>";
			[_briefing] remoteExec ["AW_fnc_globalHint",0,false];
		};
		_delay = 100 + (random 600);
		sleep _delay;
	};
};
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["FOB_Marker"];