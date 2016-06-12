//buildingPatrol  1.0 by SPUn
if(!isServer)exitWith{};
private ["_grp","_buildings","_i","_aliveCount","_bPoss"];

_grp = _this select 0;
_buildings = _this select 1;

_bPoss = [];
{
	_i = 0;
	while { ((_x buildingPos _i) select 0) != 0 } do {
		_bPoss set [count (_bPoss), (_x buildingPos _i)];
		_i = _i + 1;
	};
}forEach _buildings;

_grp setBehaviour "AWARE";

_aliveCount = { alive _x } count units _grp;
while{_aliveCount > 0}do{
	_aliveCount = { alive _x } count units _grp;
	{
		if(unitReady _x)then{
			_x doMove (_bPoss call BIS_fnc_selectRandom);
		};
	}forEach units _grp;
	sleep 20;
};