_x = 0;


while {true} do 
{

_grpc = createGroup east;
_grpcc = createGroup east;
_grpc = [getMarkerPos "checkpointc", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
_grpcc = [getMarkerPos "checkpointc", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpc, getMarkerPos "checkpointc", 10] call BIS_fnc_taskDefend;
[_grpcc, getMarkerPos "checkpointc", 10] call BIS_fnc_taskDefend;
{_x allowfleeing 0} foreach units _grpc;
{_x allowfleeing 0} foreach units _grpcc;	
	
	{
		_x addCuratorEditableObjects [units _grpc, false];
	} foreach AllCurators;
	{
		_x addCuratorEditableObjects [units _grpcc, false];
	} foreach AllCurators;

	
_Array = units _grpc + units _grpcc;
waitUntil{!({alive _x}foreach _Array)};

if ((random 1) > 0.50) then
{

hint "Road Checkpoint Charlie under Attack! Enemys managed to call Reinforcements arrival time in few minutes";

sleep (60 + (random 120));

for "_x" from 1 to 1 do {
_grpcr = createGroup east;
_grpcr = [getMarkerPos "checkpointc", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpcr, getMarkerPos "checkpointc", 10] call BIS_fnc_taskDefend;
{_x allowfleeing 0} foreach units _grpcr;

_spawnRandomisationc=150;
_spwnposNewc = [(getMarkerPos "checkpointc"),random _spawnRandomisationc,random 360] call BIS_fnc_relPos;
//_grpcr setpos _spwnposNewc;
{_x setpos _spwnposNewc} forEach units _grpcr;

_Posc = getMarkerPos "checkpointc";
_grpcr addWaypoint [_Posc, 0];
[_grpcr, 0] setWaypointType "MOVE";

	{
		_x addCuratorEditableObjects [units _grpcr, false];
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