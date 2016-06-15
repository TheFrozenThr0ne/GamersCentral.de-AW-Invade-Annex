_x = 0;


while {true} do 
{

_grpb = createGroup east;
_grpbb = createGroup east;
_grpb = [getMarkerPos "checkpointb", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
_grpbb = [getMarkerPos "checkpointb", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpb, getMarkerPos "checkpointb", 10] call BIS_fnc_taskDefend;
[_grpbb, getMarkerPos "checkpointb", 10] call BIS_fnc_taskDefend;
{_x allowfleeing 0} foreach units _grpb;
{_x allowfleeing 0} foreach units _grpbb;	
	
	{
		_x addCuratorEditableObjects [units _grpb, false];
	} foreach AllCurators;
	{
		_x addCuratorEditableObjects [units _grpbb, false];
	} foreach AllCurators;


_Array = units _grpb + units _grpbb;
waitUntil{!({alive _x}foreach _Array)};

if ((random 1) > 0.50) then
{

hint "Road Checkpoint Bravo under Attack! Enemys managed to call Reinforcements arrival time in few minutes";

sleep (60 + (random 120));

for "_x" from 1 to 1 do {
_grpbr = createGroup east;
_grpbr = [getMarkerPos "checkpointb", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpbr, getMarkerPos "checkpointb", 10] call BIS_fnc_taskDefend;
{_x allowfleeing 0} foreach units _grpbr;

_spawnRandomisationb=150;
_spwnposNewb = [(getMarkerPos "checkpointb"),random _spawnRandomisationb,random 360] call BIS_fnc_relPos;
//_grpbr setpos _spwnposNewb;
{_x setpos _spwnposNewb} forEach units _grpbr;

_Posb = getMarkerPos "checkpointb";
_grpbr addWaypoint [_Posb, 0];
[_grpbr, 0] setWaypointType "MOVE";

	{
		_x addCuratorEditableObjects [units _grpbr, false];
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