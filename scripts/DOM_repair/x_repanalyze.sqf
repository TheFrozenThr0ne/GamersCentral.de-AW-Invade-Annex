// by Xeno
private ["_aid","_caller","_coef","_damage","_damage_val","_estimated_time","_fuel","_fuel_val","_rep_count","_this","_type_name"];

_caller = _this select 1;
_aid = _this select 2;

if (!(local _caller)) exitWith {};
_rep_count = 1;

#ifdef __ACE__
if (d_objectID2 isKindOf "Tank" || d_objectID2 isKindOf "Wheeled_APC") exitWith {hint "Not possible for a tank or wheeled APC!"};
#endif

if (d_objectID2 isKindOf "Air") then {
	_rep_count = 0.1;
} else {
	if (d_objectID2 isKindOf "Tank") then {
		_rep_count = 0.2;
	} else {
		_rep_count = 0.3;
	};
};

_fuel = fuel d_objectID2;
_damage = damage d_objectID2;

_damage_val = (_damage / _rep_count);
_fuel_val = ((1 - _fuel) / _rep_count);
_coef = if (_fuel_val == _damage_val) then {
	_damage_val
} else {
	if (_fuel_val > _damage_val) then {
		_fuel_val
	} else {
		_damage_val
	}
};
_coef = ceil _coef;
_estimated_time = _coef * 3;

_type_name = [typeOf (d_objectID2),0] call XfGetDisplayName;
hintSilent format ["Vehicle status: %4\n--------------------------------\nFuel: %1\nDamage: %2\nEstimated repair time: %3 sec",_fuel, _damage,_estimated_time,_type_name];