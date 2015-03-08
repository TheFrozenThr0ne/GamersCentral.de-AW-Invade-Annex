_unit = _this select 0;
_corpse = _this select 1;

if (local _unit) then {
	_corpse removeAction squad_mgmt_action;
	
	squad_mgmt_action = player addAction [
		("<t color='#04cc6b'>" + "Squad Management" + "</t>"), 
		Compile preprocessFileLineNumbers "scripts\DOM_squad\open_dialog.sqf", [], -80, false
	];
};