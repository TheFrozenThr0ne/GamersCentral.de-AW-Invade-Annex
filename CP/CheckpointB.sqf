while {true} do 
{
_grpb = createGroup east;
_grpb = [getMarkerPos "checkpointb", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpb, getMarkerPos "checkpointb", 50] call BIS_fnc_taskDefend;

	{
		_x addCuratorEditableObjects [units _grpb, false];
	} foreach adminCurators;
	
	{
	
	_Array = units _grpb;
	waitUntil{!({alive _x}foreach _Array)};

while{count _Array > 0}do
{
	{if(!alive _x)then{_Array = _Array - [_x]}}foreach _Array;
	sleep 1800;
};
};