/*
	VoiceControl Script by KiloSwiss - 07.Juni.2015
	Restrict Voice in certain channels without disabling them completely.
	So players can still write in global, but talking is permitted.

	Credit goes to SaMatra (for pointing me into the right direction) and also to
	KillzoneKid (for his script/function that is used to detect players talking).
*/

/*
	Information about new scripting commands: http://dev.arma3.com/post/spotrep-00040

	<number> enableChannel <bool>	//enable/disable a specific channel.
	channelEnabled <number> 		//returns <bool>, true for enabled.
	setCurrentChannel <number>		//set current channel to speak in.
	currentChannel				//returns <number> (when in directChannel returns 5).
	getPlayerChannel player		//returns <number> (when in directChannel returns -1).

	0 = Global
	1 = Side
	2 = Command
	3 = Group
	4 = Vehicle
	5 = Direct
	6 = System
*/

if(!hasInterface)exitWith{};
waitUntil{!isNil {getPlayerUID player}};
private "_pUID";

_pUID = getPlayerUID player;

VC_disabledChannels = getArray(missionConfigFile >> "disableChannels");
VC_adminList = getArray(missionConfigFile >> "voiceControlAdminList");

VC_playerVONChannels = getArray(missionConfigFile >> "playerVONChannels");
VC_groupLeaderVONChannels = getArray(missionConfigFile >> "groupLeaderVONChannels");
VC_commanderVONChannels = getArray(missionConfigFile >> "groupLeaderVONChannels")+[2];
VC_adminVONChannels = getArray(missionConfigFile >> "adminVONChannels");

/* Loop to enable/disable certain channels "on the fly" */
_pUID spawn{ while{true}do{ uisleep 1;

	if(_this in VC_adminList)then{	//In admin list
		VC_allowedChannels = VC_adminVONChannels;
	}else{
		if(serverCommandAvailable "#logout")then{ //Logged in as admin
			VC_allowedChannels = VC_adminVONChannels;
		}else{
			if(count units group player == 1)then{	//Player is alone
				VC_allowedChannels = VC_playerVONChannels;
			}else{
				if(player != leader group player)then{
					VC_allowedChannels = VC_playerVONChannels;
				}else{ //Player is group leader
					VC_allowedChannels = (if(vehicle player != player && effectiveCommander (vehicle player) == player)then[{VC_commanderVONChannels},{VC_groupLeaderVONChannels}]);
					/* If the player is group leader and commander of a vehicle, he gets access to the command channel */
				};
			};
		};
	};

	if(isNil "VC_openChannels")then{VC_openChannels = []};
	if !(VC_openChannels isEqualTo VC_allowedChannels)then{	//Voice permissions have changed
		for "_i" from 0 to 6 do{	//Enable/disable channels "on the fly" (override "disableChannels" settings from description.ext)
			_i enableChannel (if(_i in VC_allowedChannels)then[{true},{if(_i in VC_disabledChannels)then[{false},{true}]}]);
		};
		VC_openChannels = VC_allowedChannels;
	};
}};


/* Code/Functions used from KillzoneKids "Who's Talking" script: http://killzonekid.com/arma-scripting-tutorials-whos-talking/ */
VoN_ChannelId_fnc = {
	switch _this do {
		case localize "str_channel_global" : {["str_channel_global",0]};
		case localize "str_channel_side" : {["str_channel_side",1]};
		case localize "str_channel_command" : {["str_channel_command",2]};
		case localize "str_channel_group" : {["str_channel_group",3]};
		case localize "str_channel_vehicle" : {["str_channel_vehicle",4]};
		case localize "str_channel_direct" : {["str_channel_direct",5]};
		default {["",-1]};
	}
};

VoN_Event_fnc = {
	VoN_currentTxt = _this;
	VoN_channelId = VoN_currentTxt call VoN_ChannelId_fnc;
	if((VoN_channelId select 1) >= 0 && !((VoN_channelId select 1) in VC_allowedChannels))then{
		playSound "Alarm";
		cutText[format["Talking in %1 is not allowed!\nPlease change Your channel with %2 or %3", str localize(VoN_channelId select 0), actionKeysNames ["nextChannel",1], actionKeysNames ["prevChannel",1]], "PLAIN", 1];
		setCurrentChannel 5;
	};
};

[] spawn { private "_fncDown";
	VoN_isOn = false;
	VoN_currentTxt = "";
	VoN_channelId = -1;
	_fncDown = {
		if (!VoN_isOn) then {
			if (!isNull findDisplay 55 && !isNull findDisplay 63) then {
				VoN_isOn = true;
				ctrlText (findDisplay 63 displayCtrl 101) call VoN_Event_fnc;
				findDisplay 55 displayAddEventHandler ["Unload", {
					VoN_isOn = false;
					"" call VoN_Event_fnc;
				}]; 
			};
		};
		false
	};
	_fncUp = {
		if (VoN_isOn) then {
			_ctrlText = ctrlText (findDisplay 63 displayCtrl 101);
			if (VoN_currentTxt != _ctrlText) then {
				_ctrlText call VoN_Event_fnc;
			};
		};
		false
	};
	waitUntil {!isNull findDisplay 46};
	findDisplay 46 displayAddEventHandler ["KeyDown", _fncDown];
	findDisplay 46 displayAddEventHandler ["KeyUp", _fncUp];
	findDisplay 46 displayAddEventHandler ["MouseButtonDown", _fncDown];
	findDisplay 46 displayAddEventHandler ["MouseButtonUp", _fncUp];
	findDisplay 46 displayAddEventHandler ["JoystickButton", _fncDown];
};

/*
"" spawn {	//DEBUG ONLY
	waitUntil{!isNil "VC_openChannels"};
	while{true}do{ uisleep .1;
		hintsilent format["Channel - Enabled - VON:\n\n
		Global: %1 - %2\nSide: %3 - %4\nCommand: %5 - %6\nGroup: %7
		 - %8\n Vehicle: %9 - %10\nDirect: %11 - %12\nSystem: %13 - %14\n",
		channelEnabled 0, 0 in VC_openChannels, channelEnabled 1, 1 in VC_openChannels,
		channelEnabled 2, 2 in VC_openChannels, channelEnabled 3, 3 in VC_openChannels,
		channelEnabled 4, 4 in VC_openChannels, channelEnabled 5, 5 in VC_openChannels, 
		channelEnabled 6, 6 in VC_openChannels];
	};
};
*/