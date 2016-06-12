//cleanUp 1.0 by SPUn
if (!isServer)exitWith{};

while{true}do{
	AIRS_Players = call LV_GetPlayers;
	nul = [300,AIRS_Players] call LV_RemoveDead;
	sleep 60;
};