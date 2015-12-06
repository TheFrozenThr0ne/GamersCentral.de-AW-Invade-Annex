/*
Author:

	Quiksilver (credit Rarek [AW] for initial design)
	
Last modified:

	25/04/2014
	
Description:

	Secure explosives crate on coastal HQ.
	Destroying the HQ first yields failure.
	Securing the weapons first yields success.
	
_________________________________________________________________________________________*/

private ["_flatPos","_accepted","_position","_randomDir","_x","_briefing","_enemiesArray","_unitsArray","_c4Message","_object","_secondary1","_secondary2","_secondary3","_secondary4","_secondary5","_boatPos","_sideobj","_trawlerPos","_assaultBoatPos"];

//-------------------- FIND SAFE POSITION FOR MISSION

	_flatPos = [0,0,0];
	_accepted = false;
	while {!_accepted} do {
		_position = [[[] call BIS_fnc_worldArea],["water"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [2,0,0.3,2,1,true];

		while {(count _flatPos) < 2} do {
			_position = [[[] call BIS_fnc_worldArea],["water"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [2,0,0.3,2,1,true];
		};

		if ((_flatPos distance (getMarkerPos "respawn")) > 1700 && (_flatPos distance (getMarkerPos currentAO)) > 500) then {
			_accepted = true;
		};
	};
	
//------------------------------------------- SPAWN OBJECTIVE AND AMBIENCE 
	
	_smuggleGroup = createGroup east;
	_smuggleGroupSideobj = createGroup east;
	_smuggleGroupAssault = createGroup east;
	_smuggleGroupCivi = createGroup east;
	
	// _object = [crate3,crate4] call BIS_fnc_selectRandom;
	// _object setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) + 5)];
	
	//--------- BOAT POSITIONS
	_sideobj = [_flatPos, 200, 4850, 10, 2, 1, 0] call BIS_fnc_findSafePos;
	_boatPos = [_flatPos, 200, 3850, 10, 2, 1, 0] call BIS_fnc_findSafePos;
	_trawlerPos = [_flatPos, 200, 3850, 10, 2, 1, 0] call BIS_fnc_findSafePos;
	_assaultBoatPos = [_flatPos, 200, 3800, 10, 0, 1, 0] call BIS_fnc_findSafePos;
	_randomDir = (random 360);
	sideObj = "O_Boat_Armed_01_hmg_F" createVehicle _sideobj;
	waitUntil {alive sideObj};
	"O_diver_TL_F" createUnit [_sideobj,_smuggleGroupSideobj]; "O_diver_F" createUnit [_sideobj,_smuggleGroupSideobj]; "O_diver_F" createUnit [_sideobj,_smuggleGroupSideobj]; "O_diver_F" createUnit [_sideobj,_smuggleGroupSideobj]; "O_diver_F" createUnit [_sideobj,_smuggleGroupSideobj];
		((units _smuggleGroupSideobj) select 0) assignAsCommander sideObj; ((units _smuggleGroupSideobj) select 0) moveInCommander sideObj; ((units _smuggleGroupSideobj) select 1) assignAsDriver sideObj; ((units _smuggleGroupSideobj) select 1) moveInDriver sideObj; ((units _smuggleGroupSideobj) select 2) assignAsGunner sideObj; ((units _smuggleGroupSideobj) select 2) moveInGunner sideObj; ((units _smuggleGroupSideobj) select 3) assignAsCargo sideObj; ((units _smuggleGroupSideobj) select 3) moveInCargo sideObj; ((units _smuggleGroupSideobj) select 4) assignAsCargo sideObj; ((units _smuggleGroupSideobj) select 4) moveInCargo sideObj;
	[(units _smuggleGroupSideobj)] call QS_fnc_setSkill2;
	sideObj setDir _randomDir;
	sideObj setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2))];
	sideObj setVectorUp [0,0,1];
	_unitsArray = [_smuggleGroupSideobj];
	
	//--------- ENEMY HMG BOAT (SEEMS RIGHT SINCE ITS BY THE COAST)
	
	boat = "O_Boat_Armed_01_hmg_F" createVehicle _boatPos;	
	waitUntil {sleep 0.3; alive boat};
	boat setDir random 360;
		"O_diver_TL_F" createUnit [_boatPos,_smuggleGroup]; "O_diver_F" createUnit [_boatPos,_smuggleGroup]; "O_diver_F" createUnit [_boatPos,_smuggleGroup]; "O_diver_F" createUnit [_boatPos,_smuggleGroup]; "O_diver_F" createUnit [_boatPos,_smuggleGroup];
		((units _smuggleGroup) select 0) assignAsCommander boat; ((units _smuggleGroup) select 0) moveInCommander boat; ((units _smuggleGroup) select 1) assignAsDriver boat; ((units _smuggleGroup) select 1) moveInDriver boat; ((units _smuggleGroup) select 2) assignAsGunner boat; ((units _smuggleGroup) select 2) moveInGunner boat; ((units _smuggleGroup) select 3) assignAsCargo boat; ((units _smuggleGroup) select 3) moveInCargo boat; ((units _smuggleGroup) select 4) assignAsCargo boat; ((units _smuggleGroup) select 4) moveInCargo boat;
	[(units _smuggleGroup)] call QS_fnc_setSkill2;
	
	_unitsArray = [_smuggleGroup];
	
	//---------- SHIPPING TRAWLER AND INFLATABLE BOAT FOR AMBIENCE
	
	trawler = "C_Boat_Civil_04_F" createVehicle _trawlerPos;
	trawler setDir random 360;
	trawler allowDamage true;
	
	"O_diver_TL_F" createUnit [_trawlerPos,_smuggleGroupCivi]; "O_diver_F" createUnit [_trawlerPos,_smuggleGroupCivi]; "O_diver_F" createUnit [_trawlerPos,_smuggleGroupCivi]; "O_diver_F" createUnit [_trawlerPos,_smuggleGroupCivi]; "O_diver_F" createUnit [_trawlerPos,_smuggleGroupCivi];
		((units _smuggleGroupCivi) select 0) assignAsCommander trawler; ((units _smuggleGroupCivi) select 0) moveInCommander trawler; ((units _smuggleGroupCivi) select 1) assignAsDriver trawler; ((units _smuggleGroupCivi) select 1) moveInDriver trawler; ((units _smuggleGroupCivi) select 2) assignAsGunner trawler; ((units _smuggleGroupCivi) select 2) moveInGunner trawler; ((units _smuggleGroupCivi) select 3) assignAsCargo trawler; ((units _smuggleGroupCivi) select 3) moveInCargo trawler; ((units _smuggleGroupCivi) select 4) assignAsCargo trawler; ((units _smuggleGroupCivi) select 4) moveInCargo trawler;
	[(units _smuggleGroupCivi)] call QS_fnc_setSkill2;
	
	_unitsArray = [_smuggleGroupCivi];
	
	
	assaultBoat = "O_Boat_Armed_01_hmg_F" createVehicle _assaultBoatPos;
	waitUntil {sleep 0.3; alive assaultBoat};
	assaultBoat setDir random 360;
	assaultBoat allowDamage true;
	
	"O_diver_TL_F" createUnit [_assaultBoatPos,_smuggleGroupAssault]; "O_diver_F" createUnit [_assaultBoatPos,_smuggleGroupAssault]; "O_diver_F" createUnit [_assaultBoatPos,_smuggleGroupAssault]; "O_diver_F" createUnit [_assaultBoatPos,_smuggleGroupAssault]; "O_diver_F" createUnit [_assaultBoatPos,_smuggleGroupAssault];
		((units _smuggleGroupAssault) select 0) assignAsCommander assaultBoat; ((units _smuggleGroupAssault) select 0) moveInCommander assaultBoat; ((units _smuggleGroupAssault) select 1) assignAsDriver assaultBoat; ((units _smuggleGroupAssault) select 1) moveInDriver assaultBoat; ((units _smuggleGroupAssault) select 2) assignAsGunner assaultBoat; ((units _smuggleGroupAssault) select 2) moveInGunner assaultBoat; ((units _smuggleGroupAssault) select 3) assignAsCargo assaultBoat; ((units _smuggleGroupAssault) select 3) moveInCargo assaultBoat; ((units _smuggleGroupAssault) select 4) assignAsCargo assaultBoat; ((units _smuggleGroupAssault) select 4) moveInCargo assaultBoat;
	[(units _smuggleGroupAssault)] call QS_fnc_setSkill2;
	
	_unitsArray = [_smuggleGroupAssault];
	
	{ _x lock 3 } forEach [boat,assaultBoat];
	
//------- POS FOR SECONDARY EXPLOSIONS, create a function for this?
	
		_secondary1 = [sideObj, random 30, random 360] call BIS_fnc_relPos;
		_secondary2 = [sideObj, random 30, random 360] call BIS_fnc_relPos;
		_secondary3 = [sideObj, random 30, random 360] call BIS_fnc_relPos;
		_secondary4 = [sideObj, random 50, random 360] call BIS_fnc_relPos;
		_secondary5 = [sideObj, random 70, random 360] call BIS_fnc_relPos;
	
//-------------------- SPAWN FORCE PROTECTION
	
	{
		_x addCuratorEditableObjects [[sideObj], false];
		_x addCuratorEditableObjects [[trawler], false];
		_x addCuratorEditableObjects [[assaultBoat], false];
		_x addCuratorEditableObjects [[boat], false];
		_x addCuratorEditableObjects [units _smuggleGroup, false];
		_x addCuratorEditableObjects [units _smuggleGroupSideobj, false];
		_x addCuratorEditableObjects [units _smuggleGroupAssault, false];
	} foreach adminCurators;
	//_enemiesArray = [sideObj] call QS_fnc_SMenemyEAST;
	
//-------------------- BRIEFING
	
	//_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];

	//{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	"sideMarker" setMarkerPos getpos sideObj;
	"sideCircle" setMarkerPos getpos sideObj;
	
	_spawnRandomisationcachee=350;
	_spwnposNewcachee = [(getMarkerPos "sideMarker"),random _spawnRandomisationcachee,random 360] call BIS_fnc_relPos;
	sideObj setpos _spwnposNewcachee;
	
	_spawnRandomisationcacheee=350;
	_spwnposNewcacheee = [(getMarkerPos "sideMarker"),random _spawnRandomisationcacheee,random 360] call BIS_fnc_relPos;
	trawler setpos _spwnposNewcacheee;
	
	_spawnRandomisationcacheeee=350;
	_spwnposNewcacheeee = [(getMarkerPos "sideMarker"),random _spawnRandomisationcacheeee,random 360] call BIS_fnc_relPos;
	assaultBoat setpos _spwnposNewcacheeee;
	
	_spawnRandomisationcacheeeee=350;
	_spwnposNewcacheeeee = [(getMarkerPos "sideMarker"),random _spawnRandomisationcacheeeee,random 360] call BIS_fnc_relPos;
	boat setpos _spwnposNewcacheeeee;
	
	//_wp = _smuggleGroupAssault addWaypoint [getMarkerPos "sideMarker", 0, 400];
	//_wp2 = _smuggleGroupSideobj addWaypoint [getMarkerPos "sideMarker", 0, 400];
	//_wp3 = _smuggleGroup addWaypoint [getMarkerPos "sideMarker", 0, 400];
	//[_smuggleGroupAssault, getMarkerPos "sideMarker", 400] call BIS_fnc_taskPatrol;
	//[_smuggleGroupSideobj, getMarkerPos "sideMarker", 400] call BIS_fnc_taskPatrol;
	//[_smuggleGroup, getMarkerPos "sideMarker", 400] call BIS_fnc_taskPatrol;
	
	sideMarkerText = "Destroy Smuggled Weapons Boat"; publicVariable "sideMarkerText";
	"sideMarker" setMarkerText "Side Mission Sea: Destroy Smuggled Weapons Boat";
	publicVariable "sideMarker";
	publicVariable "sideObj";
			
	_c4Message = ["Enemy Weapon Shipment Neutralized!","Enemy Weapon delivery has been destroyed!"] call BIS_fnc_selectRandom;

	_briefing = "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Destroy Smuggled Weapons</t><br/>____________________<br/>The OPFOR have been smuggling weapons onto the island over the sea and hiding them in a Mobile HQ. Fint out which boat transport the Weapon delivery.<br/><br/>We've marked the specified area on your map; head over there and destroy the current shipment. Keep well back when you blow it; there's a lot of stuff in that heavy armed boat.</t>";
	GlobalHint = _briefing; publicVariable "GlobalHint"; hint parseText GlobalHint;
	showNotification = ["NewSideMission", "Destroy Smuggled Weapons"]; publicVariable "showNotification";
	sideMarkerText = "Destroy Smuggled Weapons"; publicVariable "sideMarkerText";
	
//-------------------- [ CORE LOOPS ]----------------------- [CORE LOOPS]

	sideMissionUp = true; publicVariable "sideMissionUp";
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";

while { sideMissionUp } do {

		waitUntil {sleep 3; !alive sideObj};
	
	
	//------------------------------------------------------ IF WEAPONS ARE DESTROYED [SUCCESS]
		
	
		//-------------------- BOOM!
	
		hqSideChat = _c4Message; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		sleep 12;											// ghetto bomb timer
		"Bo_GBU12_LGB" createVehicle getPos sideObj; 		// default "Bo_Mk82"
		sleep 0.1;
		//_object setPos [-10000,-10000,0];					// hide objective
	
		//-------------------- DE-BRIEFING

		sideMissionUp = false; publicVariable "sideMissionUp";
		[] call QS_fnc_SMhintSUCCESS;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];
		publicVariable "sideMarker";
		
		//--------------------- SECONDARY EXPLOSIONS, create a function for this?
		
		sleep 10 + (random 10);
		"SmallSecondary" createVehicle _secondary1;
		"SmallSecondary" createVehicle _secondary2;
		sleep 5 + (random 5);
		"SmallSecondary" createVehicle _secondary3;
		sleep 2 + (random 2);
		"SmallSecondary" createVehicle _secondary4;
		"SmallSecondary" createVehicle _secondary5;
	
		//--------------------- DELETE, DESPAWN, HIDE and RESET
		
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,boat,trawler,assaultBoat];
		//deleteVehicle nearestObject [getPos sideObj,"Land_Cargo_HQ_V1_ruins_F"];
		{ [_x] spawn QS_fnc_SMdelete } forEach [_unitsArray];
	
	//----------------------------------------------------- IF HQ IS DESTROYED [FAIL]
		
	/*if (!alive sideObj) exitWith {
		
		//-------------------- DE-BRIEFING
		
		sideMissionUp = false; publicVariable "sideMissionUp";
		hqSideChat = "Objective destroyed! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		[] spawn QS_fnc_SMhintFAIL;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];
		publicVariable "sideMarker";
		
		//-------------------- DELETE
		
		_object setPos [-10000,-10000,0];			// hide objective
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,boat,trawler,assaultBoat];
		deleteVehicle nearestObject [getPos sideObj,"Land_Cargo_HQ_V1_ruins_F"];
		{ [_x] spawn QS_fnc_SMdelete } forEach [_unitsArray,_enemiesArray];
	};*/
};