while {true} do 
{
_grpc = createGroup east;
_grpc = [getMarkerPos "checkpointc", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpc, getMarkerPos "checkpointc", 10] call BIS_fnc_taskDefend;
{_x allowfleeing 0} foreach units _grpc;	
	
	{
		_x addCuratorEditableObjects [units _grpc, false];
	} foreach AllCurators;
	
	_Array = units _grpc;
	waitUntil{!({alive _x}foreach _Array)};

while{count _Array > 0}do
{
	{if(!alive _x)then{_Array = _Array - [_x]}}foreach _Array;
	sleep 1800;
};
};