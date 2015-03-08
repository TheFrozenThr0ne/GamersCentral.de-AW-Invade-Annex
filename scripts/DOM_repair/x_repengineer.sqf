// by Xeno
private ["_aid","_caller","_coef","_damage","_damage_ok","_damage_val","_fuel","_fuel_ok","_fuel_val","_rep_count","_breaked_out","_rep_action","_type_name","_estimated_time","_cur_time"];

_caller = _this select 1;
_aid = _this select 2;

_truck_near = false;
if (player distance TR7 < 21 || player distance TR8 < 21) then {_truck_near = true};
if (!d_eng_can_repfuel && !_truck_near) exitWith {
	hintSilent format["You have to restore your repair/refuel capability. Try again %1 seconds later.", player getVariable "Repair_restore_delay"];
};

_caller removeAction _aid;
if (!(local _caller)) exitWith {};

#ifdef __ACE__
if (d_objectID2 isKindOf "Tank" || d_objectID2 isKindOf "Wheeled_APC") exitWith {hint "Not possible for a tank or wheeled APC!"};
#endif

_rep_count = switch (true) do {
	case (d_objectID2 isKindOf "Air"): {0.1};
	case (d_objectID2 isKindOf "Tank"): {0.2};
	default {0.3};
};

_fuel = fuel d_objectID2;
_damage = damage d_objectID2;

_damage_val = (_damage / _rep_count);
_fuel_val = ((1 - _fuel) / _rep_count);
_coef = switch (true) do {
	case (_fuel_val > _damage_val): {_fuel_val};
	default {_damage_val};
};
_coef = ceil _coef;

hintSilent format ["Vehicle status:\n---------------------\nFuel: %1\nDamage: %2",_fuel, _damage];
_type_name = [typeOf (d_objectID2),0] call XfGetDisplayName;
(format ["Repairing and refuelling %1... Stand by", _type_name]) call XfGlobalChat;
_damage_ok = false;
_fuel_ok = false;
d_cancelrep = false;
_breaked_out = false;
_breaked_out2 = false;
_rep_action = player addAction["Cancel Service" call XRedText,"DOM_repair\x_cancelrep.sqf"];

_estimated_time = _coef * 5;
_cur_time = time;
while {_estimated_time > time - _cur_time} do {
//for "_wc" from 1 to _coef do {
	if (!alive player || d_cancelrep) exitWith {player removeAction _rep_action};
	"Still working..." call XfGlobalChat;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	waitUntil {animationState player == "AinvPknlMstpSlayWrflDnon_medic" || _breaked_out || _estimated_time < time - _cur_time};
	waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic" || _breaked_out || _estimated_time < time - _cur_time};
	player playMove "AinvPknlMstpSnonWrflDnon_medic";
	
	if (d_cancelrep) exitWith {_breaked_out = true};
	if (vehicle player != player) exitWith {
		_breaked_out2 = true;
		hintSilent "You have entered a vehicle, service canceled";
	};
	if (!_fuel_ok) then {_fuel = _fuel + _rep_count};
	if (_fuel >= 1 && !_fuel_ok) then {_fuel = 1;_fuel_ok = true};
	if (!_damage_ok) then {_damage = _damage - _rep_count};
	if (_damage <= 0.01 && !_damage_ok) then {_damage = 0;_damage_ok = true};
	hintSilent format ["Vehicle status:\n---------------------\nFuel: %1\nDamage: %2",_fuel, _damage];
};
if (_breaked_out) exitWith {
	"Service canceled..." call XfGlobalChat;
	player playMoveNow "amovpknlmstpsraswrfldnon";
	player removeAction _rep_action;
};
if (_breaked_out2) exitWith {};

d_eng_can_repfuel = false;
[] spawn {
	format["Engineer repair/refuel will be restored %1 seconds later.",Repair_restore_delay] call XfGlobalChat;
	hint format["Engineer repair/refuel will be restored %1 seconds later.",Repair_restore_delay];
	player setVariable ["Repair_restore_delay", Repair_restore_delay, true];
	sleep Repair_restore_delay;
	d_eng_can_repfuel = true;
	'Engineer repair/refuel capability restored.' call XfGlobalChat;
	hint "Engineer repair/refuel capability restored.";
};

player playMoveNow "amovpknlmstpsraswrfldnon";
player removeAction _rep_action;
if (!alive player) exitWith {player removeAction _rep_action};

["rep_ar", d_objectID2] call XNetCallEvent;
(format ["%1 repaired and refuelled", _type_name]) call XfGlobalChat;
