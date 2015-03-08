/*
@file: fn_AOminefield.sqf
Author:

	Quiksilver (credit Rarek [ahoyworld] for initial build)
	
Description:

	Spawn a minefield around AO by MaDmaX [GC]
	
________________________________________________________________*/

#define MINE_TYPES "APERSBoundingMine","APERSMine","ATMine"
_centralPos = _this select 0;
_unitsArray = [];

for "_x" from 0 to 59 do {
        _mine = createMine [[MINE_TYPES] call BIS_fnc_selectrandom, (getMarkerPos currentAO), [], 508];
        _unitsArray = _unitsArray + [_mine];
};

_unitsArray