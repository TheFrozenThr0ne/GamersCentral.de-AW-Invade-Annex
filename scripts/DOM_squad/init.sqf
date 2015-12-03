squad_mgmt_action = player addaction ["<t color='#CCCC00'>Group Management</t>","disableserialization; ([] call BIS_fnc_displayMission) createDisplay 'RscDisplayDynamicGroups'",nil,1,false,true,"",""];

// Init functions
call Compile preprocessFileLineNumbers "scripts\DOM_squad\x_netinit.sqf";
if (!isDedicated) then {
	call Compile preprocessFileLineNumbers "scripts\DOM_squad\x_uifuncs.sqf";
	
	[] spawn 
{
private["_old","_recorded"];
	if(!alive player) then
		{
		_old = player;
		_old removeAction squad_mgmt_action;
		waitUntil {alive player};
		
	squad_mgmt_action = player addaction ["<t color='#CCCC00'>Group Management</t>","disableserialization; ([] call BIS_fnc_displayMission) createDisplay 'RscDisplayDynamicGroups'",nil,1,false,true,"",""];
};
};

	private "_playerRespawn";
	_playerRespawn = player addEventHandler ["Respawn", {_this Call Compile preprocessFileLineNumbers "scripts\DOM_squad\onPlayerRespawn.sqf";}]; 
	
};
