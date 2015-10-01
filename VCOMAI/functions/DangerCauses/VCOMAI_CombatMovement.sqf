//if (_this getVariable "VCOM_InCover") then
//{
	_NearestEnemy = _this call VCOMAI_ClosestEnemy;
	if ((typeName _NearestEnemy isEqualTo "ARRAY") || {isNil "_this"} || {!(alive _NearestEnemy)}) exitWith {};
	if !(lineintersects [eyepos _this,eyepos _NearestEnemy]) then 
	{
		_doesIntersect = terrainIntersectASL [eyePos _this, eyePos _NearestEnemy];
		if !(_doesIntersect) then
		{
			_this setVariable ["VCOM_VisuallyCanSee",true,false];
			_this forceSpeed 0;
			_this lookAt (getposATL _NearestEnemy);
			_this setUnitPos "AUTO";
			_this spawn {sleep 5;_this forcespeed -1};
		};
	};
//};