while {true} do 
{
_grpe = createGroup east;
_grpe = [getMarkerPos "checkpointe", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpe, getMarkerPos "checkpointe", 10] call BIS_fnc_taskDefend;
{_x allowfleeing 0} foreach units _grpe;		
	
	{
		_x addCuratorEditableObjects [units _grpe, false];
	} foreach AllCurators;
	
	_Array = units _grpe;
	waitUntil{!({alive _x}foreach _Array)};

while{count _Array > 0}do
{
	{if(!alive _x)then{_Array = _Array - [_x]}}foreach _Array;
	sleep 1800;
};
};