sepa = ["<t color='#ffff33'>Put on ear plugs</t>",{
	_u = _this select 1;
	_i = _this select 2;
	if (soundVolume == 1) then {
		1 fadeSound 0.5;
		_u setUserActionText [_i,"Take off ear plugs"]
	} else {
		1 fadeSound 1;
		_u setUserActionText [_i,"<t color='#ffff33'>Put on ear plugs</t>"]
	}
},[],-90,false,true,"","_target == vehicle player"];
player addAction sepa;

/*player addEventHandler ["Respawn",{
	1 fadeSound 1;
	sepa = ["<t color='#ffff33'>Put on ear plugs</t>",{
	_u = _this select 1;
	_i = _this select 2;
	if (soundVolume == 1) then {
		1 fadeSound 0.5;
		_u setUserActionText [_i,"Take off ear plugs"]
	} else {
		1 fadeSound 1;
		_u setUserActionText [_i,"<t color='#ffff33'>Put on ear plugs</t>"]
	}
},[],-90,false,true,"","_target == vehicle player"];
	player addAction sepa;
}];*/