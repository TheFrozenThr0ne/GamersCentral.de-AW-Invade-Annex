GetTransportPilotsCount ={
	_pilotsCounter = 0;
  
  {
    if ((isPlayer _x) && {_x isKindOf "B_Helipilot_F"}) then {
      _pilotsCounter = _pilotsCounter +1;
    };
  
  }
  forEach playableUnits;
  
  (_pilotsCounter);
};