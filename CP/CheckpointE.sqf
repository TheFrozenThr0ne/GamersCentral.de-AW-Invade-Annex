_x = 0;


while {true} do 
{

_grpe = createGroup east;
_grpee = createGroup east;
_grpe = [getMarkerPos "checkpointe", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
_grpee = [getMarkerPos "checkpointe", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpe, getMarkerPos "checkpointe", 10] call BIS_fnc_taskDefend;
[_grpee, getMarkerPos "checkpointe", 10] call BIS_fnc_taskDefend;
{_x allowfleeing 0} foreach units _grpe;
{_x allowfleeing 0} foreach units _grpee;		
	
	{
		_x addCuratorEditableObjects [units _grpe, false];
	} foreach AllCurators;
	{
		_x addCuratorEditableObjects [units _grpee, false];
	} foreach AllCurators;

	
_Array = units _grpe + units _grpee;
waitUntil{!({alive _x}foreach _Array)};

if ((random 1) > 0.50) then
{

hint "Road Checkpoint Echo under Attack! Enemys managed to call Reinforcements arrival time in few minutes";

sleep (60 + (random 120));

for "_x" from 1 to 1 do {
_grper = createGroup east;
_grper = [getMarkerPos "checkpointe", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grper, getMarkerPos "checkpointe", 10] call BIS_fnc_taskDefend;
{_x allowfleeing 0} foreach units _grper;

_spawnRandomisatione=150;
_spwnposNewe = [(getMarkerPos "checkpointe"),random _spawnRandomisatione,random 360] call BIS_fnc_relPos;
//_grper setpos _spwnposNewe;
{_x setpos _spwnposNewe} forEach units _grper;

_Pose = getMarkerPos "checkpointe";
_grper addWaypoint [_Pose, 0];
[_grper, 0] setWaypointType "MOVE";

	{
		_x addCuratorEditableObjects [units _grper, false];
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