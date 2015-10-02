_id = _this select 2;
_array = _this select 3;
_name = _array select 0;
BTC_tk_PVEH = [_name,name player];
publicVariable "BTC_tk_PVEH";
//hint format ["%1 has committed TK and has been punished by %2",_name, name player];
_kill = format
	[
		"<t size='1.5' align='center' color='#E00000'>%1</t><br/>____________________<br/>has committed TK and has been punished by <t color='#00B2EE'>%2</t>",
		_name,
		_punisher
	];	
	GlobalHint = _kill; publicVariable "GlobalHint"; hint parseText GlobalHint;
player removeAction _id;