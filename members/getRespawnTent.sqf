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

player addBackpack "B_Respawn_TentA_F";

titleText ["You are a Member, Respawn Tent added.","PLAIN DOWN"]; titleFadeOut 8;
} else {
titleText ["You are not a Member, Sorry. Please apply and join our Community. GamersCentral on Steam.","PLAIN DOWN"]; titleFadeOut 8;
};