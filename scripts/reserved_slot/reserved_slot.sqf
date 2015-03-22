private ["_isAdmin","_admin"];

_isAdmin = false;
sleep 1;

if (isServer) exitWith {};

{
	if (str(player) == _x) exitWith {
		_isAdmin = true;
	};
} forEach INS_REV_CFG_reserved_slot_units;

if (!_isAdmin) exitWith {};

if (serverCommandAvailable "#shutdown") exitWith {
	hint format ["Welcome %1!\nYou logged in as admin", name player];
	titleText [format["Welcome %1! You logged in as admin", name player],"PLAIN"];
};

for "_i" from 1 to 6 do {
	hint "Attention!\nThis is a reserved admin slot.\nIf you are an admin on this server log in in the next 30 seconds otherwise you'll get kicked automatically!";
	titleText ["Attention! This is a reserved admin slot.\n\nIf you are an admin on this server log in in the next 30 seconds otherwise you'll get kicked automatically!\n\n\n\n(After youre logged in, wait few Seconds)","BLACK FADED"];
	//sleep 5;
};

if (serverCommandAvailable "#shutdown") exitWith {
	hint format ["Welcome %1!\nYou logged in as admin, no kick", name player];
	titleText [format["Welcome %1! You logged in as admin, no kick", name player],"PLAIN"];
};

hint "Attention!\nYou have 5 seconds to log in or you get kicked automatically!";
titleText ["Attention! You have 5 seconds to log in or you get kicked automatically!","BLACK FADED"];
//sleep 5;

if (serverCommandAvailable "#shutdown") exitWith {
	hint format ["Welcome %1!\nYou logged in as admin, no kick", name player];
	titleText [format["Welcome %1! You logged in as admin, no kick", name player],"PLAIN"];
};

hint "You will be kicked now... !!!";
titleText ["You will be kicked now... !!!","BLACK FADED"];

sleep 1;
endMission "LOSER";