/*
@file: switchSide.sqf
Author:

	[GC] MaDmaX
	
Description:

	Player join the Opfor side to fight against Blufor.
_______________________________________________________________________*/



waitUntil {sleep 0.5; !(isNil "currentAOUp")};
private ["_fightBlufor","_deadOpfor","_deadOpforHint"];

_fightBlufor = format
	[
		"<t align='center' size='2.2'>Main AO</t><br/># <t size='1.5' align='center' color='#CF0034'>%1</t> #<br/>____________________<br/><t align='left'>Just overflowed to OPFOR Main AO and fight now against BLUFOR.</t>",
		name player
	];
_deadOpforHint = format
	[
		"<t align='center' size='2.2'>Main AO</t><br/>+ <t size='1.5' align='center' color='#2bff00'>%1</t> +<br/>____________________<br/><t align='left'>Just dies and is now back to BLUFOR.</t>",
		name player
	];
/*_deadOpfor = format
	[
		"%1 just dies and is now back to BLUFOR.",
		"%1 have seen the end of war, and is now back to BLUFOR.",
		"%1 war is a symptom of mans failure as a thinking animal, and is now back to BLUFOR.",
		"%1 war does not determine who is right - only who is left, and is now back to BLUFOR..",
		"%1 war is over ... If you want it.",
		name player
	];*/
	
_flag = _this select 0; // Object that had the Action (also _target in the addAction command)
_player = _this select 1; // Unit that used the Action (also _this in the addAction command)
_actID = _this select 2; // ID of the Action

if (currentAOUp) then {
hintC "Fight against BLUFOR - Rules\n\nPlease read before enjoy!\n\n____________________\n\nYou are not Allowed to Punish your Killer otherwise you risk to get permanently banned, this is currently a bug.\n\nYoure not allowed to Spawn to the objective as far someone is directly on it also called as spawn killer, exemple at Side Mission and Main AO like on MHQ. And youre not allowed to Destroy the objectives at Side Mission and AO.\n\nYoure not allowed to use Map, GPS or Radio.\n\n\n\nThis is an idea by MaDmaX[GC] and it would be sad if this will fail so please play fair otherwise you destroy the Server and you risk also the end of the Server! Follow our Rules!\n\n\n\n- No Map\n- No GPS\n- No Radio";
sleep 10;
systemChat "Did you read the Window?! I just hope you understood!";
titleText ["Get Ready", "BLACK OUT"];
sleep 5;
titleText ["Get Ready", "BLACK FADED"];
sleep 2;
titleText ["", "BLACK IN"];

_player allowDamage false;

_spawnRandomisation=600;
_spwnposNew = [(getMarkerPos "aoMarker"),random _spawnRandomisation,random 360] call BIS_fnc_relPos;
player setpos _spwnposNew;


_side = createCenter EAST;
_group = createGroup _SIDE;
[player] joinSilent _group;

if (side player == east) then {
// systemChat "You are on the East side now.";
West setFriend [East, 0];
sleep 2;
_player addUniform "U_O_CombatUniform_ocamo";
_player addHeadgear "H_HelmetO_ocamo";
sleep 1;

GlobalHint = _fightBlufor; publicVariable "GlobalHint"; hint parseText GlobalHint;
titleText ["BETA - You are able to Fight against BLUFOR. Good Luck! - This feature can be changed!","PLAIN DOWN"]; titleFadeOut 8;
sleep 4;
_player setDamage 0;
_player allowDamage true;


waitUntil {
while {alive player} do
{	
_player removeItem "ItemMap";
_player removeItem "ItemRadio";
_player removeItem "ItemGPS";
_player unlinkItem "ItemMap";
_player unlinkItem "ItemRadio";
_player unlinkItem "ItemGPS";
_player UnassignItem "ItemMap";
_player UnassignItem "ItemRadio";
_player UnassignItem "ItemGPS";
};
sleep 0.5; !alive player;



_side2 = createCenter WEST;
_group2 = createGroup _SIDE2;
[player] joinSilent _group2;

sleep 3;
titleText ["Dead! You are on the West side now.", "BLACK FADED"];
sleep 2;
titleText ["", "BLACK IN"];

// systemChat "Dead! You are on the West side now.";

East setFriend [West, 0];

WaitUntil {Alive player};
sleep 5;
_player addUniform "U_B_CombatUniform_mcam";
_player addHeadgear "H_HelmetB_light";
_player addItem "ItemMap";
_player addItem "ItemRadio";
_player addItem "ItemGPS";
sleep 2;

GlobalHint = _deadOpforHint; publicVariable "GlobalHint"; hint parseText GlobalHint;

// hqSideChat = _deadOpfor call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
if (alive player) exitWith {};
}; 

};

	} else {
	titleText ["The Main AO is currently not active - please wait.","PLAIN DOWN"]; titleFadeOut 8;

};

