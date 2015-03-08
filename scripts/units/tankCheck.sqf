while {true} do
{
	waitUntil {sleep 0.5; alive player};
	if (typeOf player != "B_crew_F") then
	{
		while {alive player} do
		{
			waitUntil {sleep 0.5; vehicle player != player};
			_v = vehicle player;
			if (_v isKindOf "O_MBT_02_cannon_F") then
			{
				if (driver _v == player) then
				{
					player action ["eject", _v];
					waitUntil {sleep 0.5; vehicle player == player};
					player action ["engineOff", _v];
					hintSilent format ["Welcome %1!\nYou must be a Mechanized Infantry - Driver!", name player];
				};
				
			};
			if (_v isKindOf "O_MBT_02_cannon_F") then
			{
				if (gunner _v == player) then
				{
					player action ["eject", _v];
					waitUntil {sleep 0.5; vehicle player == player};
					player action ["engineOff", _v];
					hintSilent format ["Welcome %1!\nYou must be a Mechanized Infantry - Gunner!", name player];
				};
				
			};
		};
	} else {
		waitUntil {sleep 0.5; !alive player};
	};
};