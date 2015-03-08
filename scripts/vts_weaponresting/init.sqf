#include "vts_weaponresting_config.hpp"

if (isDedicated) exitWith {};
if !(isnil "vts_weaponresting_keydown") exitwith {};

waitUntil {!(isnull (findDisplay 46))};

enableCamShake false;

vts_weaponresting_debug=false;

VTS_WEAPONRESTING_KEY_BIND=VTS_WEAPONRESTING_KEY;
VTS_WEAPONRESTING_SHIFT_BIND=VTS_WEAPONRESTING_SHIFT;
VTS_WEAPONRESTING_CTRL_BIND=VTS_WEAPONRESTING_CTRL;
VTS_WEAPONRESTING_ALT_BIND=VTS_WEAPONRESTING_ALT;

vts_weaponresting_keydown=(findDisplay 46) displayAddEventHandler ["KeyDown","_this call vts_weaponresting_checkbind;"];

vts_weaponresting_checkbind=
{
	_b=false;
	_key=_this select 1;
	if (_key==VTS_WEAPONRESTING_KEY_BIND) then 
	{
		_shift=true;
		_ctrl=true;
		_alt=true;
		if (_this select 2) then
		{
			if !(VTS_WEAPONRESTING_SHIFT_BIND) then {_shift=false;};
		}
		else
		{
			if (VTS_WEAPONRESTING_SHIFT_BIND) then {_shift=false;};
		};
		if (_this select 3) then
		{
			if !(VTS_WEAPONRESTING_CTRL_BIND) then {_ctrl=false;};
		}
		else
		{
			if (VTS_WEAPONRESTING_CTRL_BIND) then {_ctrl=false;};
		};
		if (_this select 4) then
		{
			if !(VTS_WEAPONRESTING_ALT_BIND) then {_alt=false;};
		}
		else
		{
			if (VTS_WEAPONRESTING_ALT_BIND) then {_alt=false;};
		};
		if (_shift && _ctrl && _alt) then
		{
			[] spawn vts_weaponresting_func;
			_b=true;
		};
	};
	_b;
};

vts_weaponresting_func=
{
	if !(isnil "vts_weapon_resting") exitwith {};

	if (currentweapon player=="") exitwith {};

	_vts_resting_recoil=0.15;
	_vts_resting_recoil_prone=0.30;
	_vts_resting_aperture=15;
	_vts_weaponresting_sound="vts_weaponresting_sound";
	_vts_weaponresting_soundslide="a3\sounds_f\weapons\Shells\5_56\dirt_556_09.wss";
	addCamShake [0, 0, 0];

	//[player, 45,0] call BIS_fnc_setPitchBank; 

	//hint format["%1",asin((player weaponDirection (currentweapon player)) select 2)];

	_vts_weaponresting_check=
	{
		_vts_weaponresting_debug=_this select 0;
		
		_colorred=[1,0,0,1];
		_colorgreen=[0,1,0,1];
		
		_dir=direction  player;
		_leftoffest=0.50;
		_rightoffest=0.60;
		_frontoffest=0.75;
		_frontterrainoffest=0.8;
		_muzzleoffest=0.07;
		_downoffset=0.45;
		_downoffsetobjectvertical=0.5;
		_downoffsetterrainvertical=0.75;
		_weaponpitch=asin((player weaponDirection (currentweapon player)) select 2);
		_distance=1.5;
		
		_posleft=[(eyepos player select 0)+_leftoffest*(sin (_dir-90)),(eyepos player select 1)+_leftoffest*(cos (_dir-90)),(eyepos player select 2)-_downoffset];
		_posleft0=[(_posleft  select 0),( _posleft select 1),( _posleft select 2)];
		_posleft1=[(_posleft  select 0)+_distance*(sin _dir),( _posleft select 1)+_distance*(cos _dir),(_posleft  select 2)+_distance*(sin _weaponpitch)];

		_posright=[(eyepos player select 0)+_rightoffest*(sin (_dir+90)),(eyepos player select 1)+_rightoffest*(cos (_dir+90)),(eyepos player select 2)-_downoffset];
		_posright0=[( _posright select 0),( _posright select 1),( _posright select 2)];
		_posright1=[( _posright select 0)+_distance*(sin _dir),( _posright select 1)+_distance*(cos _dir),(_posright select 2)+_distance*(sin _weaponpitch)];

		
		_posmuzzle=[(eyepos player select 0)+_muzzleoffest*(sin (_dir+90)),(eyepos player select 1)+_muzzleoffest*(cos (_dir+90)),(eyepos player select 2)];
		_posmuzzle0=[( _posmuzzle select 0),( _posmuzzle select 1),( _posmuzzle select 2)];
		_posmuzzle1=[( _posmuzzle select 0)+_distance*(sin _dir),( _posmuzzle select 1)+_distance*(cos _dir),(_posmuzzle select 2)+_distance*(sin _weaponpitch)];

		
		_posdown=[(eyepos player select 0)+_frontoffest*(sin _dir)+_muzzleoffest*(sin (_dir+90)),(eyepos player select 1)+_frontoffest*(cos _dir)+_muzzleoffest*(cos (_dir+90)),(eyepos player select 2)];
		_posdown0=[( _posdown select 0),( _posdown select 1),( _posdown select 2)+_frontoffest*(sin _weaponpitch)];
		_posdown1=[( _posdown select 0),( _posdown select 1),( _posdown select 2)+_frontoffest*(sin _weaponpitch)-_downoffsetobjectvertical];

		_posdownterrain=[(eyepos player select 0)+_frontterrainoffest*(sin _dir)+_muzzleoffest*(sin (_dir+90)),(eyepos player select 1)+_frontterrainoffest*(cos _dir)+_muzzleoffest*(cos (_dir+90)),(eyepos player select 2)];
		_posdownterrain0=[( _posdownterrain select 0),( _posdownterrain select 1),( _posdownterrain select 2)+_frontoffest*(sin _weaponpitch)];
		_posdownterrain1=[( _posdownterrain select 0),( _posdownterrain select 1),( _posdownterrain select 2)+_frontoffest*(sin _weaponpitch)-_downoffsetterrainvertical];

		
		_colorright=_colorred;
		_colorleft=_colorred;
		_colormuzzle=_colorred;
		_colordown=_colorred;
		_colordownterrain=_colorred;
		
		_lrest=false;
		_rrest=false;
		_mzrest=false;
		_mdown=false;
		_mdownterrain=false;
		
		_wresting=false;
		
		if (lineIntersects [_posleft0,_posleft1,player]) then
		{
			_colorright=_colorgreen;
			//if (direction player>_playerdir+15) then {player setdir _playerdir+15};
			_lrest=true;
		};
		if (lineIntersects [_posright0,_posright1,player]) then
		{
			_colorleft=_colorgreen;
			//if (direction player>_playerdir+15) then {player setdir _playerdir+15};
			_rrest=true;
		};	
		if (lineIntersects [_posmuzzle0,_posmuzzle1,player]) then
		{
			_colormuzzle=_colorgreen;
			//if (direction player>_playerdir+15) then {player setdir _playerdir+15};
			_mzrest=true;
		};	
		if (lineIntersects [_posdown0,_posdown1,player]) then
		{
			_colordown=_colorgreen;
			//if (direction player>_playerdir+15) then {player setdir _playerdir+15};
			_mdown=true;
		};		
		if (terrainIntersectASL [_posdownterrain0,_posdownterrain1]) then
		{	
			//if (direction player>_playerdir+15) then {player setdir _playerdir+15};
			if (stance player=="PRONE") then
			{
				_colordownterrain=_colorgreen;
				_mdownterrain=true;
			};
		};	
		
		
		_checkmen=nearestObjects [[(getposatl player select 0)+1.1*sin(direction player),(getposatl player select 1)+1.1*cos(direction player),(getposatl player) select 2],["Man"],0.6];
		if ((count _checkmen)>0) then
		{
			
			//if (direction player>_playerdir+15) then {player setdir _playerdir+15};
			if ((_checkmen select 0) iskindof "Man") then
			{
				if ((stance (_checkmen select 0)=="CROUCH") && ((stance player)!="PRONE")) then
				{
					_colordown=_colorgreen;
					_mdown=true;
				};
			};
		};
		
			
		
		if (_vts_weaponresting_debug) then
		{
			drawLine3D [ASLToATL _posleft0,ASLToATL _posleft1,_colorright];
			drawLine3D [ASLToATL _posright0,ASLToATL _posright1,_colorleft];
			drawLine3D [ASLToATL _posmuzzle0,ASLToATL _posmuzzle1,_colormuzzle];
			drawLine3D [ASLToATL _posdown0,ASLToATL _posdown1,_colordown];
			drawLine3D [ASLToATL _posdownterrain0,ASLToATL _posdownterrain1,_colordownterrain];
		};
		
		if ((_lrest or _rrest or _mdown or _mdownterrain) && (!_mzrest)) then 
		{
			_wresting=true;
		};
		
		if ((vehicle player!=player) or !(alive player)) then {_wresting=false;};
		
		_wresting;
		
	};
		

	_vts_weaponresting_showwind=
	{
		disableserialization;
		_wind=[];
		if !(isnil "vts_ballistic_wind") then
		{
			_wind=vts_ballistic_wind;
		}
		else
		{
			_wind=wind;
		};
		
		_windx=(_wind select 0);
		_windy=(_wind select 1);
		if (_windx<0) then {_windx=_windx*-1;};
		if (_windy<0) then {_windy=_windy*-1;};
		_windstr=sqrt(_windx^2+_windy^2);
		_color="<t color='#ffffff'>";

		switch (true) do
		{
			case (_windstr>=1 && _windstr<2):{_color="<t color='#CCFFFF'>";};
			case (_windstr>=2 && _windstr<3):{_color="<t color='#99FFCC'>";};
			case (_windstr>=3 && _windstr<4):{_color="<t color='#99FF99'>";};
			case (_windstr>=4 && _windstr<5):{_color="<t color='#99FF66'>";};
			case (_windstr>=5 && _windstr<6):{_color="<t color='#99FF00'>";};
			case (_windstr>=6 && _windstr<7):{_color="<t color='#CCFF00'>";};
			case (_windstr>=7 && _windstr<8):{_color="<t color='#FFFF00'>";};
			case (_windstr>=8 && _windstr<9):{_color="<t color='#FFCC00'>";};
			case (_windstr>=9 && _windstr<10):{_color="<t color='#FF9900'>";};
			case (_windstr>=10 && _windstr<11):{_color="<t color='#FF6600'>";};
			case (_windstr>=11 && _windstr<12):{_color="<t color='#FF3300'>";};
			case (_windstr>=12):{_color="<t color='#FF0000'>";};
		};
	
	
		_winddir=(((_wind select 0)*2-(_wind select 0))atan2((_wind select 1)*2-(_wind select 1)));
		if (_winddir<0) then {_winddir=_winddir+360;};
		_dir="Calm";
		if (_color!="<t color='#ffffff'>") then 
		{
			switch (true) do
			{
				case (_winddir>=337.5 or _winddir<22.5):{_dir="N";};
				case (_winddir>=22.5 && _winddir<67.5):{_dir="NE";};
				case (_winddir>=67.5 && _winddir<112.5):{_dir="E";};
				case (_winddir>=112.5 && _winddir<157.5):{_dir="SE";};
				case (_winddir>=157.5 && _winddir<202.5):{_dir="S";};
				case (_winddir>=202.5 && _winddir<247.5):{_dir="SW";};
				case (_winddir>=247.5 && _winddir<292.5):{_dir="W";};
				case (_winddir>=292.5 && _winddir<337.5):{_dir="NW";};
			};	
		};
		_display=uinamespace getvariable "VTS_WeaponResting_Dialog_id";
		(_display displayctrl 1) ctrlSetStructuredText parsetext("<t align='center'>~"+_color+_dir+"</t></t>"); 
		
	};		
		
		
	if ([vts_weaponresting_debug] call _vts_weaponresting_check) then 
	{
		if (stance player=="PRONE") then {_vts_resting_recoil=_vts_resting_recoil_prone;};
		player setUnitRecoilCoefficient _vts_resting_recoil;
		addCamShake [0, 0, 0];
		playsound _vts_weaponresting_sound; 
		vts_weapon_resting=true;
		_vts_weaponresting_dir=(direction player);
		_vts_weaponresting_pos=(getposatl player);
		_vts_weaponresting_min=_vts_weaponresting_dir-_vts_resting_aperture;
		if (_vts_weaponresting_min<0) then {_vts_weaponresting_min=360+_vts_weaponresting_min;};
		_vts_weaponresting_max=_vts_weaponresting_dir+_vts_resting_aperture;
		if (_vts_weaponresting_max>360) then {_vts_weaponresting_max=_vts_weaponresting_max-360;};
		//if (vts_weaponresting_debug) then {player sidechat format["%1 & %2 for %3",_vts_weaponresting_min,_vts_weaponresting_max,direction player]; };
		1338 cutRsc ["VTS_WeaponResting_Dialog", "PLAIN"];
		_vtsweaprest=true;
		_loop=0;

		_lastanim=animationstate player;
		_lastrestanim="";
		
		while {_vtsweaprest} do
		{
			_lastpos=getposatl player;
			if ((_loop!=0) && (_loop mod (3/0.1)==0)) then {[] spawn _vts_weaponresting_showwind};
			sleep 0.1;
			_currentpos=getposatl player;
			if !([vts_weaponresting_debug] call _vts_weaponresting_check) then {_vtsweaprest=false;};
			//if (((direction player)>(_vts_weaponresting_min) && (direction player)<(_vts_weaponresting_max))) then {_vtsweaprest=true;};
			if (_vts_weaponresting_pos distance (getposatl player)>0.1) then
			{
				//playsound3D [_vts_weaponresting_soundslide,player,false,getPos player,0.01,1,5]; 
				_vts_weaponresting_pos=(getposatl player);
			};
			//Check if anim need update when not moving if player is not moving

			if !(_lastrestanim==(animationstate player)) then
			{

					waituntil {sleep 0.1;(isclass (configfile >> "CfgMovesMaleSdr" >> "States" >> ((animationstate player)+"_rest"))) or !([vts_weaponresting_debug] call _vts_weaponresting_check)};
					_lastanim=animationstate player;
					_restanim=(_lastanim+"_rest");
					if (vts_weaponresting_debug) then {player sidechat str(isclass (configfile >> "CfgMovesMaleSdr" >> "States" >> _restanim))};
					if (isclass (configfile >> "CfgMovesMaleSdr" >> "States" >> _restanim)) then 
					{
						if (vts_weaponresting_debug) then {player sidechat _restanim};
							player switchmove _restanim;
							_lastrestanim=_restanim;
						
					};					

			};

			_loop=_loop+1;
		};
		addCamShake [5, 1, 5];
		vts_weapon_resting=nil;
		player setUnitRecoilCoefficient 1;
		player switchmove _lastanim;
		1338 cutFadeOut 0.5;
	};


};