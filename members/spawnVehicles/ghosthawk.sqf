_flag = _this select 0; // Object that had the Action (also _target in the addAction command)
_player = _this select 1; // Unit that used the Action (also _this in the addAction command)
_actID = _this select 2; // ID of the Action

_player = Player;
_uid = getPlayerUID _player;
_nameCheck = false;


if (_uid in masterUIDArray) then {
_nameCheck = true;
};

if (_nameCheck) then {


_Object = "B_Heli_Transport_01_camo_F";
_StartPos = spawn_a;
_Azimut = 260;
_Fuel = 1;
_Vehicle = _Object createVehicle position _StartPos;
_Vehicle setDir _Azimut;
_Vehicle setFuel _Fuel;
_Vehicle setpos (_Vehicle modelToWorld [0,0,0]);
_Vehicle allowdamage false;
//_Vehicle lockturret [[1],true];
//_Vehicle lockturret [[2],true];
_Vehicle setHit ["mala vrtule", 0];
_Vehicle setHit ["velka vrtule", 0];
sleep 0.5;
player moveInDriver _Vehicle;
sleep 1;
_Vehicle allowdamage true;
titleText ["You are a Member, Welcome","PLAIN DOWN"]; titleFadeOut 8;
} else {
titleText ["You are not a Member, Sorry. Please visit our Steam Community Group GamersCentral for more information.","PLAIN DOWN"]; titleFadeOut 8;
};


