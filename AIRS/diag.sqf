//diag.sqf

while{true}do{
	_westUnits = [];
	_eastUnits = [];
	_indeUnits = [];
	_all = allUnits;
	{
		if(side _x == west)then{_westUnits set[(count _westUnits),_x];};
		if(side _x == east)then{_eastUnits set[(count _eastUnits),_x];};
		if(side _x == resistance)then{_indeUnits set[(count _indeUnits),_x];};
	}forEach _all;
	
	_groups = allGroups;
	_dead = allDead;
	
	hint parseText format["<t size='1.25' font='puristaMedium' color='#ff0000'>WEST units:</t> <t size='1.5' font='puristaMedium' color='#ffffff'>%1</t><br/>
<t size='1.25' font='puristaMedium' color='#ff0000'>EAST units:</t> <t size='1.5' font='puristaMedium' color='#ffffff'>%2</t><br/>
<t size='1.25' font='puristaMedium' color='#ff0000'>INDE units:</t> <t size='1.5' font='puristaMedium' color='#ffffff'>%3</t><br/><br/>
<t size='1.25' font='puristaMedium' color='#ff0000'>Total units:</t> <t size='1.5' font='puristaMedium' color='#ffffff'>%4</t><br/><br/>
<t size='1.25' font='puristaMedium' color='#ff0000'>Groups:</t> <t size='1.5' font='puristaMedium' color='#ffffff'>%5</t><br/><br/>
<t size='1.25' font='puristaMedium' color='#ff0000'>Dead troops:</t> <t size='1.5' font='puristaMedium' color='#ffffff'>%6</t>",(count _westUnits),(count _eastUnits),(count _indeUnits),(count _all),(count _groups),(count _dead)];
	
	sleep 1;
};