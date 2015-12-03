_unit = _this select 0;
_corpse = _this select 1;

if (local _unit) then {
	_corpse removeAction squad_mgmt_action;
	
	squad_mgmt_action = player addaction ["<t color='#CCCC00'>Group Management</t>","disableserialization; ([] call BIS_fnc_displayMission) createDisplay 'RscDisplayDynamicGroups'",nil,1,false,true,"",""];
};