_x = 0;

while {true} do 
{

_grpa = createGroup east;
_grpaa = createGroup east;
_grpa = [getMarkerPos "checkpointa", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
_grpaa = [getMarkerPos "checkpointa", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpa, getMarkerPos "checkpointa", 10] call BIS_fnc_taskDefend;
[_grpaa, getMarkerPos "checkpointa", 10] call BIS_fnc_taskDefend;
{_x allowfleeing 0} foreach units _grpa;
{_x allowfleeing 0} foreach units _grpaa;

	{
		_x addCuratorEditableObjects [units _grpa, false];
	} foreach AllCurators;
	{
		_x addCuratorEditableObjects [units _grpaa, false];
	} foreach AllCurators;

_Array = units _grpa + units _grpaa;
waitUntil{!({alive _x}foreach _Array)};

if ((random 1) > 0.50) then
{

hint "Road Checkpoint Alpha under Attack! Enemys managed to call Reinforcements arrival time in few minutes";

sleep (60 + (random 120));

for "_x" from 1 to 1 do {
_grpar = createGroup east;
_grpar = [getMarkerPos "checkpointa", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpar, getMarkerPos "checkpointa", 10] call BIS_fnc_taskDefend;
{_x allowfleeing 0} foreach units _grpar;

_spawnRandomisationa=150;
_spwnposNewa = [(getMarkerPos "checkpointa"),random _spawnRandomisationa,random 360] call BIS_fnc_relPos;
//_grpar setpos _spwnposNewa;
{_x setpos _spwnposNewa} forEach units _grpar;

_Posa = getMarkerPos "checkpointa";
_grpar addWaypoint [_Posa, 0];
[_grpar, 0] setWaypointType "MOVE";

	{
		_x addCuratorEditableObjects [units _grpar, false];
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