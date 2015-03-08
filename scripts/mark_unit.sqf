/*
      ::: ::: :::             ::: :::             ::: 
     :+: :+:   :+:           :+:   :+:           :+:  
    +:+ +:+     +:+         +:+     +:+         +:+   
   +#+ +#+       +#+       +#+       +#+       +#+    
  +#+ +#+         +#+     +#+         +#+     +#+     
 #+# #+#           #+#   #+#           #+#   #+#      
### ###             ### ###             ### ###      

| AHOY WORLD | ARMA 3 ALPHA | STRATIS DOMI VER 2.7 |

Creating working missions of this complexity from
scratch is difficult and time consuming, please
credit http://www.ahoyworld.co.uk for creating and
distibuting this mission when hosting!

This version of Domination was lovingly crafted by
Jack Williams (Rarek) for Ahoy World!
*/

/*
	Remove this accounting for respawning when another
	script handles that.
*/


private ["_unit","_marker","_delay"];
_unit = _this select 0;
_marker = _this select 1;
_delay = _this select 2;
while {true} do
{
	_marker setMarkerAlpha 1;
	while {alive _unit} do 
	{
		_marker setMarkerPosLocal getPos _unit;
		sleep _delay;
	};
	_marker setMarkerAlpha 0;
	waitUntil {alive _unit};
};
