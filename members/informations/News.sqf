waitUntil {sleep 0.5; alive player};
_player = Player;
_uid = getPlayerUID _player;
_nameCheck = false;

if (_uid in masterUIDArray) then {
_nameCheck = true;
};
if (_nameCheck) then {
sleep 3;
execVM "members\informations\newsRules.sqs";
} else {
sleep 3;
};