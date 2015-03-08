Repair_restore_delay = 15;

// setup global chat logic
if (isNil "x_global_chat_logic") then {x_global_chat_logic = "Logic" createVehicleLocal [0,0,0]};

// display a text message over a global logic chat
// parameters: text (without brackets)
// example: "Hello World!" call XfGlobalChat;
XfGlobalChat = {x_global_chat_logic globalChat _this};

// display a text message over HQ sidechat (CROSSROAD)
// parameters: text
// example: "Hello World!" call XfHQChat;
XfHQChat = {[playerSide, "HQ"] sideChat _this};

// get displayname of an object
// parameters: type of object (string), what (0 = CfgVehicles, 1 = CfgWeapons, 2 = CfgMagazines)
// example: _dispname = ["UAZ", 0] call XfGetDisplayName;
XfGetDisplayName = {
	private ["_obj_name", "_obj_kind", "_cfg"];
	_obj_name = _this select 0;_obj_kind = _this select 1;
	_cfg = switch (_obj_kind) do {case 0: {"CfgVehicles"};case 1: {"CfgWeapons"};case 2: {"CfgMagazines"};};
	getText (configFile >> _cfg >> _obj_name >> "displayName")
};

x_event_holder = "Logic" createVehicleLocal [0, 0, 0];

// multiple events per type
XNetAddEvent = {
	private ["_a", "_ea"];
	_a = switch (_this select 0) do {
		case 0: {true}; // all
		case 1: {if (isServer) then {true} else {false}}; // server only
		case 2: {if (local player) then {true} else {false}}; // client only
		case 3: {if (isDedicated) then {true} else {false}}; // dedicated only
		case 4: {if (!isServer) then {true} else {false}}; // client only, 2
	};
	if (_a) then {
		_ea = x_event_holder getVariable (_this select 1);
		if (isNil "_ea") then {_ea = []};
		_ea set [count _ea, _this select 2];
		x_event_holder setVariable [_this select 1, _ea];
	};
};
XNetCallEvent = {
	x_n_e_gl = _this; publicVariable "x_n_e_gl";
	_this call XNetRunEvent;
};
"x_n_e_gl" addPublicVariableEventHandler {
	(_this select 1) call XNetRunEvent;
};

XNetRunEvent = {
	private ["_ea", "_p", "_pa"];
	_ea = x_event_holder getVariable (_this select 0);
	if (!isNil "_ea") then {
		_pa = _this select 1;
		if (!isNil "_pa") then {
			{_pa call _x} forEach _ea;
		} else {
			{call _x} forEach _ea;
		};
	};
};
XfCreateTrigger = {
	private ["_pos", "_trigarea", "_trigact", "_trigstatem", "_trigger"];
	_pos = _this select 0;
	_trigarea = _this select 1;
	_trigact = _this select 2;
	_trigstatem = _this select 3;
	_trigger = createTrigger ["EmptyDetector" ,_pos];
	_trigger setTriggerArea _trigarea;
	_trigger setTriggerActivation _trigact;
	_trigger setTriggerStatements _trigstatem;
	_trigger
};

[0, "rep_ar", {_this setDamage 0;_this setFuel 1}] call XNetAddEvent;

XGreyText = {"<t color='#f0bfbfbf'>" + _this + "</t>"};
XRedText = {"<t color='#f0ff0000'>" + _this + "</t>"};
XBlueText = {"<t color='#f07f7f00'>" + _this + "</t>"}; //olive

x_sfunc = {
	private ["_objs"];
	if ((vehicle player) == player)then{_objs = nearestObjects [player,["LandVehicle","Air","Ship"],5];if (count _objs > 0) then {d_objectID2 = _objs select 0;if (alive d_objectID2) then {if(damage d_objectID2 > 0.05 || fuel d_objectID2<1)then{true}else{false}}else{false}}}else{false};
};
x_ffunc = {
	private ["_l","_vUp","_winkel"];
	if ((vehicle player) == player) then {d_objectID1=(position player nearestObject "LandVehicle");if (!alive d_objectID1 || player distance d_objectID1 > 8)then{false}else{_vUp=vectorUp d_objectID1;if((_vUp select 2) < 0)then{true}else{_l=sqrt((_vUp select 0)^2+(_vUp select 1)^2);if(_l != 0)then{_winkel=(_vUp select 2) atan2 _l;if(_winkel < 30)then{true}else{false}}}}} else {false}
};
x_pfunc = {
	private ["_objs"];
	if ((vehicle player) == player) then {d_objectID3=(position player nearestObject "Ship");if (alive d_objectID3 && player distance d_objectID3 < 6.1) then {true} else {false}} else {false};
};

// special triggers for engineers, AI version, everybody can repair and flip vehicles
if (true) then {
	d_eng_can_repfuel = true;
	INS_REV_CFG_dom_repair_flip_vehicle = true;
	INS_REV_CFG_dom_repair_push_boat = true;
	INS_REV_CFG_dom_repair_engineer_only = true;
	
	_pos = position player;
	
	// Flip vehicle
	if (INS_REV_CFG_dom_repair_flip_vehicle) then {
		[_pos, [0, 0, 0, false], ["NONE", "PRESENT", true], ["call x_ffunc", "actionID1=d_objectID1 addAction ['Unflip Vehicle' call XGreyText, 'scripts\DOM_repair\x_unflipVehicle.sqf',[d_objectID1],-1,false];", "d_objectID1 removeAction actionID1"]] call XfCreateTrigger;
	};
	
	// Push boat
	if (INS_REV_CFG_dom_repair_push_boat) then {
		[_pos, [0, 0, 0, false], ["NONE", "PRESENT", true], ["call x_pfunc", "actionID3=d_objectID3 addAction ['Push Boat' call XGreyText, 'scripts\DOM_repair\x_pushVehicle.sqf',d_objectID3,-1,false];", "d_objectID3 removeAction actionID3"]] call XfCreateTrigger;
	};
	
	// Check enginner
	private "_engineerList";
	_engineerList = ["B_engineer_F","O_engineer_F","I_engineer_F","B_officer_F","B_crew_F","B_soldier_repair_F"];
	if (INS_REV_CFG_dom_repair_engineer_only && !(typeOf player in _engineerList)) exitWith {};
	
	// Add repair action
	_trigger = createTrigger["EmptyDetector" ,getPos player];
	_trigger setTriggerArea [0, 0, 0, true];
	_trigger setTriggerActivation ["NONE", "PRESENT", true];
	_trigger setTriggerStatements["call x_sfunc", "actionID6 = d_objectID2 addAction ['Analyze Vehicle' call XGreyText, 'scripts\DOM_repair\x_repanalyze.sqf',[],-1,false];actionID2 = d_objectID2 addAction ['Repair/Refuel Vehicle' call XGreyText, 'scripts\DOM_repair\x_repengineer.sqf',[],-1,false]", "d_objectID2 removeAction actionID6;d_objectID2 removeAction actionID2"];
};