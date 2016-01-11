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
depotTruck = "B_Truck_01_medical_F" createVehicle getMarkerPos "FOB_Depot";
_truckDir1 = (markerDir "FOB_Depot");
depotTruck setDir _truckDir1;
//depotTruck enableRopeAttach False;

[] spawn {
			while{not isnull depotTruck} do {"fobMissionMarker" setmarkerpos getpos depotTruck; sleep 0.5;};
			while{sleep 3;!alive depotTruck} do {
			"fobMissionMarker" setMarkerPos [-20000,-20000,-20000];
			};
};

_briefing = "<t align='center'><t size='2.2'>New Supply Mission</t><br/><t size='1.5' color='#00B2EE'>Medical Supplies</t><br/>____________________<br/>We have provided a truck with some medical resources for the FOB<br/><br/>Get the supplies to the FOB and watch out for OPFOR ambushes</t>";
[_briefing] remoteExec ["AW_fnc_globalHint",0,false];


while {(alive depotTruck) && (depotTruck distance (getMarkerPos "FOB_Marker") > 20) && (Fob_missions)} do {
	_distance = 250 + (random 250);
	_dir = getDir depotTruck;
	_targetPos = [depotTruck, _distance, _dir] call BIS_fnc_relPos;
	_attackPos = getPos depotTruck;
	
	if ((_targetPos distance (getMarkerPos "respawn_west")) > 1500 && (_targetPos distance (getMarkerPos "FOB_Marker")) > 100) then { 
		sleep 1;
		//_GRP1 = [_targetPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
		//[_GRP1,_attackPos] call BIS_fnc_taskAttack;
		waitUntil {(depotTruck distance _attackPos > 1000) || !(Fob_missions) || !(alive depotTruck) || (depotTruck distance (getMarkerPos "FOB_Marker") < 20)};
		//{deleteVehicle _x} forEach units _GRP1;
		//deleteGroup _GRP1;
	};
	sleep 3;
};
waitUntil {!(Fob_missions) || !(alive depotTruck) || (depotTruck distance (getMarkerPos "FOB_Marker") < 21)};

if (depotTruck distance (getMarkerPos "FOB_Marker") < 21) then {
	_medVic = "B_Truck_01_medical_F" createVehicle (getMarkerPos medPad1);
	_vicDir1 = (markerDir medPad1);
	_medVic setDir _vicDir1;
	call AW_fnc_fobReward;
	hqSideChat = "Good job getting the supplies to the FOB. We have provided you with some assets.";
	[hqSideChat] remoteExec ["AW_fnc_globalSideChat",0,false];
};

if (!(alive depotTruck)) then {
	hqSideChat = "What are you doing. The truck was destroyed.";
	[hqSideChat] remoteExec ["AW_fnc_globalSideChat",0,false];
	_failedText = "<t align='center'><t size='2.2'>FOB Mission</t><br/><t size='1.5' color='#b60000'>FAILED</t><br/>____________________<br/>
	You'll have to do better than that next time!<br/><br/><br/>Focus on the main objective for now; we'll relay the bad news to HQ, with some luck we'll have another objective lined up. 
	We'll get back to you in 5 - 10 minutes.</t>";
	
};
if (!(Fob_missions)) then {
	hqSideChat = "Operations in the region have ceased. The resources are no longer needed.";
	_briefing = "<t align='center'><t size='2.2'>FOB Mission</t><br/><t size='1.5' color='#00B2EE'>Medical Supplies</t><br/>____________________<br/>Operations in the area have ceased.<br/><br/>The resources are no longer needed.</t>";
	[_briefing] remoteExec ["AW_fnc_globalHint",0,false];
	[hqSideChat] remoteExec ["AW_fnc_globalSideChat",0,false];
};
if ((depotTruck distance (getMarkerPos "respawn_west")) < 250 || (depotTruck distance (getMarkerPos "FOB_Marker")) < 100) then { 
	deleteVehicle depotTruck;
};