/*/////////////////////////////////////////
//Filename : ETG_ReinforcementsScript.sqf//
//Author : Kellojo/////////////////////////
//Version : 1.4 ///////////////////////////
///////////////////////////////////////////

/////////
//Usage//
/////////

To call in one insertion of units and or a vehicle call the script like this in a trigger or something else wherever you need it.
This script works best with a mod that implements some cargo planes as it looks just awsome...

/////////
//Notes//
/////////

If you have any ideas for the script feel free to add me on Steam. My name is "Kellojo" ;).

//////////////
//Known Bugs//
//////////////
Here I will list every know bug that im currently working on. If you have any ideas how to fix them writing a comment or a private message would be nice ;).
-Sometimes (rarly) the helicopter crashes without any reason...

////////////////////////////////////////////////
//Can I use this script for my mission/server?//
////////////////////////////////////////////////

Yes, you can use this script for your server aswell as you can modify it however you want.
Its not necessary to give credit to me but it would be appreciated. :)

//////////////////////////////////////////////
//How can i run the script?---> Installation//
//////////////////////////////////////////////
First add this somewhere in your init.sqf :

ETG_Reinforcements = 0;

Second step is put the ETG_ReinforcementsScript.sqf into your mission folder.
Then you can run this script by calling it in a trigger, in a script or with an action added to the player or any other object.
Examples:

Adds a scroll action that can be uses to call in reinforcements:
player AddAction ["<t color=""#7CFC00"">" +"-Call in reinforcements (Bluefor CH67 - Marshall)-", "nul = ['spawn','drop',west,10,'B_APC_Wheeled_01_cannon_F',100,'B_Heli_Transport_03_F','SmokeShell',''] execVM 'ETG_ReinforcementsScript.sqf';"];

Place this in a trigger or script to call in reinforcements:
nul = ['spawn','drop',west,10,'B_APC_Wheeled_01_cannon_F',100,'B_Heli_Transport_03_F','SmokeShell',''] execVM 'ETG_ReinforcementsScript.sqf';


/////////////////////////
//Modify these examples//
/////////////////////////


nul = ['spawn','drop',west,10,'B_APC_Wheeled_01_cannon_F',100,'B_Heli_Transport_03_F','SmokeShell',''] execVM 'ETG_ReinforcementsScript.sqf';

nul = ['spawn','drop',west,16,'',100,'B_Heli_Transport_03_F','SmokeShell','empty'] execVM 'ETG_ReinforcementsScript.sqf';

nul = ['spawn','drop',west,10,'B_CargoNet_01_ammo_F',100,'B_Heli_Transport_03_F','SmokeShell','empty'] execVM 'ETG_ReinforcementsScript.sqf';


//Explanation//

nul = 
["marker1",								//put in a marker name that should be near the spawning zone of the vehicles - does not have to be on/over land
"marker2",								//put in a marker name that should be near the drop zone
west,									//select what side the dropped units will be from - can be west, east, independent
10,										//select how many parachuters you want to have
"B_APC_Wheeled_01_cannon_F",			//select what vehicle you want to drop can be a any vehicle or any ammobox
100,									//put in a number in which the drop happens around the drop off point - it just adds some randomness to it ;)
"B_Heli_Transport_03_F",				//select the vehicle transporting the units/cargo	
"SmokeShell",							//select what smokeshell or chemlight should be attached to the cargo
"empty"]								//put in "empty" if you want the cargo vehicle to be empty/without a crew - if you want an ammobox put in empty...
execVM "ETG_ReinforcementsScript.sqf";
*/

_paradrop = [
			"OPFOR Forces Para Drop incoming!",
			"The enemy managed to call in reinforcements! Form a perimeter around the objective area!"
	];
	
if (isServer) then {	
	if (ETG_Reinforcements != 1) then {
		ETG_Reinforcements = 1;
		if(random 1 >= 0.35) then {
	hqSideChat = "Side objective assigned, stand-by for orders."; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	} else {
	hqSideChat = "Side objective assigned, stand-by for orders."; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	};
	hqSideChat = _paradrop call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		
		_Spawn = _this select 0;   					//spawn marker
		_Drop = _this select 1;  			  		//drop marker
		_Side = _this select 2;    					//Bluefor etc
		_ParachuterNumber = _this select 3;			//Ammount of parachuters
		_Cargo = _this select 4; 					//Cargo of the helicopter/plane
		_RandomDropArea = _this select 5; 			//100m
		_TransportVehicle = _this select 6;			//plane/helicopter
		_ETG_CargoSmoke = _this select 7; 			//smoke shell classname
		_ETG_Vehicle = _this select 8; 				//empty or not
		

		_SpawnPoint = getMarkerPos _Spawn;
		_DropPoint = getMarkerPos _Drop;
		_Delete = [0,0,0];
		_ParachutersAmmount = 0;
		
		//Sets the side/parachute units
			switch (_Side) do {                                                       
				case west: { ETG_ParachutersClassName = "B_soldier_PG_F";  };                                                          
				case east: { ETG_ParachutersClassName = "O_soldier_PG_F"; };     
				case independent: { ETG_ParachutersClassName = "I_soldier_F"; };  
			};
		
		//Creates the groups for the Pilot and the parachuters
			_ETG_HeliCrew = createGroup _Side;
			_ETG_ReinforcementsPilotGroup = createGroup _Side; 
		
		//Creates the Parachuters
			while {_ParachutersAmmount < _ParachuterNumber} do 
				{
					ETG_ParachutersClassName createUnit [_SpawnPoint,_ETG_HeliCrew ,"", 0.6, "private"];
					_ParachutersAmmount = _ParachutersAmmount + 1
				};
				ParachutersName = nearestObjects [_SpawnPoint, ["Man"], 50];
				
		//Adds parachutes to independent troops
			if (_Side == independent) then [ 
				{
					{ _x addbackpack "B_Parachute"; } forEach ParachutersName;
				}, {} 
			];
			
		//Spawn the Cargo and Transport vehicle	
			if (_ETG_Vehicle == "empty") then [ {ETG_Cargo = _Cargo createVehicle _SpawnPoint;}, { [_SpawnPoint, 180,_Cargo, _ETG_HeliCrew] call bis_fnc_spawnvehicle; _ETG_Cargo = nearestObjects [_SpawnPoint, ["landvehicle"], 50]; ETG_Cargo = _ETG_Cargo select 0; } ];
					[_SpawnPoint, 180,_TransportVehicle, _ETG_ReinforcementsPilotGroup] call bis_fnc_spawnvehicle;
					_ETG_Transport = nearestObjects [_SpawnPoint, ["air"], 50];
					ETG_TransportVehicle = _ETG_Transport select 0;
					
		//Moves the units into the transport vehicle
			{_x  moveInCargo ETG_TransportVehicle;} forEach ParachutersName;
			
		//Finds out what vehicle the cargo will be attached to and sets the correct position
			_ETG_TransportVehicleClass = typeOf ETG_TransportVehicle;
			switch (_ETG_TransportVehicleClass) do {                                                       
				case "I_Heli_Transport_02_F": { ETG_CargoPosition = [0, 2, -0.7]  };                                                          
				case "B_Heli_Transport_03_F": { ETG_CargoPosition = [0, 2, 0] };     
				case "B_Heli_Transport_03_unarmed_F": { ETG_CargoPosition = [0, 2, 0] }; 
				case "sab_C130_H_CSAT": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_H_CSAT2": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_H_CSAT3": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_H_AAF": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_H_AAF2": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_H_AAF3": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_J": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_JC": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_JE": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_JEC": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_JT": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_HE": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_HEC": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_HC": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_FA": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_LC": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_LC_Ski": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_CG": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_FP": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_CSP": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_J_FF": { ETG_CargoPosition = [0, 4, -2] }; 
				case "sab_C130_J_FF2": { ETG_CargoPosition = [0, 4, -2] };
				case "B_Heli_Light_01_F": { ETG_CargoPosition = [0, 1, -8] };
				case "O_Heli_Light_02_F": { ETG_CargoPosition = [0, 1, -8] };
				case "O_Heli_Transport_04_F": { ETG_CargoPosition = [0, 1, -8] };
				case "O_Heli_Transport_04_bench_F": { ETG_CargoPosition = [0, 1, -8] };
				case "O_Heli_Transport_04_box_F": { ETG_CargoPosition = [0, 1, -8] };
				case "O_Heli_Transport_04_medevac_F": { ETG_CargoPosition = [0, 1, -8] };
				case "O_Heli_Transport_04_ammo_F": { ETG_CargoPosition = [0, 1, -8] };
				case "O_Heli_Transport_04_repair_F": { ETG_CargoPosition = [0, 1, -8] };
				case "O_Heli_Transport_04_covered_F": { ETG_CargoPosition = [0, 1, -8] };
				case "O_Heli_Transport_04_fuel_F": { ETG_CargoPosition = [0, 1, -8] };
				case "O_Heli_Attack_02_F": { ETG_CargoPosition = [0, 1, -8] };
				case "O_Heli_Attack_02_black_F": { ETG_CargoPosition = [0, 1, -8] };
				case "I_Heli_light_03_F": { ETG_CargoPosition = [0, 1, -8] };
				case "I_Heli_light_03_unarmed_F": { ETG_CargoPosition = [0, 1, -8] };
				default { ETG_CargoPosition =  [0, 0, 0]};  };
			
		//Attaches the cargo to the transport vehicle
			ETG_Cargo attachTo [ETG_TransportVehicle, ETG_CargoPosition];	
			
		//Waypoint for the Helicopter
			_ETG_HeliWaypoint1 = _ETG_ReinforcementsPilotGroup addWaypoint [_DropPoint, 0];
			_ETG_HeliWaypoint1 setWaypointType "move";
			_ETG_HeliWaypoint1 setWaypointBehaviour "CARELESS";
			ETG_TransportVehicle flyInHeight 300;
			
		//sets the new waypoint
			_ETG_HeliWaypoint2 = _ETG_ReinforcementsPilotGroup addWaypoint [[0,0,0], 0];
			_ETG_HeliWaypoint2 setWayPointType "MOVE";
			_ETG_HeliWaypoint2 setWayPointBehaviour "CARELESS";
			ETG_TransportVehicle flyInHeight 300;
		
		//waits until the distance to the droppoint is > 800
			waitUntil {ETG_TransportVehicle distance _DropPoint < 800};	
			_ETG_ReinforcementsPilotGroup setCurrentWaypoint [_ETG_ReinforcementsPilotGroup, 1];
			deleteWaypoint [_ETG_ReinforcementsPilotGroup, 0];
			_ETG_ReinforcementsPilotGroup setCurrentWaypoint [_ETG_ReinforcementsPilotGroup, 1];
				
		//Unloading the cargo
			ETG_Cargo attachTo [ETG_TransportVehicle, [0, -15, -2] ];
			_ETG_CargoPosition = getPos ETG_Cargo;
			detach ETG_Cargo;
			ETG_Parachute = "B_Parachute_02_F" createVehicle _ETG_CargoPosition;    
			ETG_Parachute setPos _ETG_CargoPosition;
			ETG_Cargo attachTo [ETG_Parachute, [0, 0, -1.2] ];    
		
		//Creates the cargo smoke
			if (_Cargo == "") then {} else {
				_ETG_CargoSmoke = _ETG_CargoSmoke createVehicle position ETG_TransportVehicle;
				_ETG_CargoSmoke attachto [ETG_Cargo,[0,0,0]];
			};
			
		//Unloading the units
			{_x setpos (ETG_TransportVehicle modeltoWorld [0, -15, -2])  ;unassignvehicle _x;  _x action ["Eject",ETG_TransportVehicle];sleep 0.2} forEach ParachutersName;
		
		//Waits until the Cargo is 4m above the ground and detaches it
			waituntil {(getPos ETG_Cargo select 2) < 4};	
			detach ETG_Cargo;
				
		//Delete the parachute
			sleep 10.0;
			deleteVehicle ETG_Parachute;
		//Delete 
			waituntil {ETG_TransportVehicle distance _Delete < 10000};
			ETG_TransportVehicle deleteVehicleCrew driver ETG_TransportVehicle;
			deleteVehicle ETG_TransportVehicle;

		ETG_Reinforcements = 0;
	code } else {};
};
