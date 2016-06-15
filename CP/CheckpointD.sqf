_x = 0;


while {true} do 
{

_grpd = createGroup east;
_grpdd = createGroup east;
_grpd = [getMarkerPos "checkpointd", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
_grpdd = [getMarkerPos "checkpointd", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpd, getMarkerPos "checkpointd", 10] call BIS_fnc_taskDefend;
[_grpdd, getMarkerPos "checkpointd", 10] call BIS_fnc_taskDefend;
{_x allowfleeing 0} foreach units _grpd;
{_x allowfleeing 0} foreach units _grpdd;		
	
	{
		_x addCuratorEditableObjects [units _grpd, false];
	} foreach AllCurators;
	{
		_x addCuratorEditableObjects [units _grpdd, false];
	} foreach AllCurators;

	
_Array = units _grpd + units _grpdd;
waitUntil{!({alive _x}foreach _Array)};

if ((random 1) > 0.50) then
{

hint "Road Checkpoint Delta under Attack! Enemys managed to call Reinforcements arrival time in few minutes";

sleep (60 + (random 120));

for "_x" from 1 to 1 do {
_grpdr = createGroup east;
_grpdr = [getMarkerPos "checkpointd", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpdr, getMarkerPos "checkpointd", 10] call BIS_fnc_taskDefend;
{_x allowfleeing 0} foreach units _grpdr;

_spawnRandomisationd=150;
_spwnposNewd = [(getMarkerPos "checkpointd"),random _spawnRandomisationd,random 360] call BIS_fnc_relPos;
//_grpdr setpos _spwnposNewd;
{_x setpos _spwnposNewd} forEach units _grpdr;

_Posd = getMarkerPos "checkpointd";
_grpdr addWaypoint [_Posd, 0];
[_grpdr, 0] setWaypointType "MOVE";

	{
		_x addCuratorEditableObjects [units _grpdr, false];
	} foreach AllCurators;
	};
};

while{count _Array > 0}do
{
	{if(!alive _x)then{_Array = _Array - [_x]}}foreach _Array;
	sleep 1;
};

sleep 3600;

};