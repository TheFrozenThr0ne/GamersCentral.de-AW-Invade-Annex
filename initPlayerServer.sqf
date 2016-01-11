_player = _this select 0;
_uid = getPlayerUID _player;

if ( _player getVariable [ "reserved", false ] && { !( _uid in allowed ) } ) then {
	[ [], "fnc_reservedSlot", _player ] call BIS_fnc_MP;
};


addMissionEventHandler ["HandleDisconnect", { 
    _unit  = _this select 0;
    _pos = getPosATL _unit;
    
    _wholder = nearestObjects [_pos, ["weaponHolderSimulated", "weaponHolder"], 2];
    
    {
        deleteVehicle _x;
    }forEach _wholder + [_unit];
    
    false
}];


