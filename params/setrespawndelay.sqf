if (isServer) then
{
	private ["_delay"];
	_delay = [_this, 0, 1200, [0]] call bis_fnc_param;

	BIS_initialRespawnDelay = _delay;
};