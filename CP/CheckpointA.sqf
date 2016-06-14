while {true} do 
{
_grpa = createGroup east;
_grpa = [getMarkerPos "checkpointa", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
[_grpa, getMarkerPos "checkpointa", 10] call BIS_fnc_taskDefend;
{_x allowfleeing 0} foreach units _grpa;

	{
		_x addCuratorEditableObjects [units _grpa, false];
	} foreach AllCurators;
	
	_Array = units _grpa;
	waitUntil{!({alive _x}foreach _Array)};

while{count _Array > 0}do
{
	{if(!alive _x)then{_Array = _Array - [_x]}}foreach _Array;
	sleep 1800;
};
};