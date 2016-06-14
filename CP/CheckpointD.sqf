while {true} do 
{
_grpd = createGroup east;
_grpd = [getMarkerPos "checkpointd", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpd, getMarkerPos "checkpointd", 50] call BIS_fnc_taskDefend;

	{
		_x addCuratorEditableObjects [units _grpd, false];
	} foreach adminCurators;
	
	{
	
	_Array = units _grpd;
	waitUntil{!({alive _x}foreach _Array)};

while{count _Array > 0}do
{
	{if(!alive _x)then{_Array = _Array - [_x]}}foreach _Array;
	sleep 1800;
};
};