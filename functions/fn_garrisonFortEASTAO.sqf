
	_building = _this select 0;
	_faction = "OPF_F";
	_coef = 1;

	BIS_getRelPos = {
		_relDir = [_this, player] call BIS_fnc_relativeDirTo;
		_dist = [_this, player] call BIS_fnc_distance2D;
		_elev = ((getPosASL _this) select 2) - ((getPosASL player) select 2);
		_dir = (direction player) - direction _this;

		[_relDir, _dist, _elev, _dir];
	};

	_buildings = [
		"Land_Cargo_Patrol_V2_F", [
			[90.1156,2.21253,-4.1396,120.6112],
			[316.962,3.01801,-4.14061,270.592],
			[31.6563,3.01418,-4.13602,-0.194908],
			[270,2,-4.14,210]

		]
	];

	if (!(typeOf _building in _buildings)) exitWith {_newGrp = objNull; _newGrp};

	_paramsArray = (_buildings select ((_buildings find (typeOf _building)) + 1));
	_finalCnt = count _paramsArray;

	_newGrp = createGroup EAST;

	_units = ["O_Soldier_GL_F", "O_Soldier_AR_F"];

	{
		_pos =  [_building, _x select 1, (_x select 0) + direction _building] call BIS_fnc_relPos;
		_pos = [_pos select 0, _pos select 1, ((getPosASL _building) select 2) - (_x select 2)];
		_units select floor random 2 createUnit [_pos, _newGrp, "BIS_currentDude = this"];
		doStop BIS_currentDude;
		commandStop BIS_currentDude;
		BIS_currentDude setPosASL _pos;
		BIS_currentDude setUnitPos "UP";
		BIS_currentDude doWatch ([BIS_currentDude, 1000, direction _building + (_x select 3)] call BIS_fnc_relPos);
		BIS_currentDude setDir direction _building + (_x select 3);
	} forEach _paramsArray;
	
	_newGrp setBehaviour "COMBAT";
	_newGrp setCombatMode "RED";
	[_newGrp, getPos radioTower] call BIS_fnc_taskDefend;
	[(units _newGrp)] call QS_fnc_setSkill3;
	_newGrp;