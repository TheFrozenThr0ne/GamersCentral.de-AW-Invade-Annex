if (isServer) then
{
	private ["_timer"];
	_timer = [_this, 0, 1200, [0]] call bis_fnc_param;

	BIS_missionLastPhaseTimer = _timer;
};