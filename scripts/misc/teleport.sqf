	/*
	Cedits: MaDmaX[GC]
	
	
	Adds the Flag at end of AO and despawn.
	
	
	*/
	
	_spawnRandomisation=200;
	_spwnposNew = [(getMarkerPos "aoMarker"),random _spawnRandomisation,random 360] call BIS_fnc_relPos;
	aoflag setpos _spwnposNew;
	"aoteleport" setMarkerPos getPos aoflag;
	
	sleep 900;
	aoflag setPos [-10000,10000,10000];
	"aoteleport" setMarkerPos [-10000,-10000,-10000];