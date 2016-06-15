/*
@filename: initPlayerLocal.sqf
Author:
	
	Quiksilver

Last modified:

	29/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Client scripts and event handlers.
______________________________________________________*/

enableSentences FALSE;
enableRadio TRUE;
enableSaving [FALSE,FALSE];
player enableFatigue FALSE;

//initPlayerLocal.sqf
#include "\a3\functions_f_mp_mark\Revive\defines.hpp"

//systemChat "Saving initial loadout";
//Save initial loadout
[ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_saveInventory;


//Save loadout when ever we exit an arsenal
[ missionNamespace, "arsenalClosed", {
	systemChat "Arsenal Closed Gear Saved";
	[ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_saveInventory;
}] call BIS_fnc_addScriptedEventHandler;

//Save backpack and items when killed
player addEventHandler [ "Killed", {
	params[
		"_unit",
		"_killer"
	];
	//systemChat "Killed";
	if ( GET_STATE( _unit ) isEqualTo STATE_DOWNED ) then {
		//systemChat "Downed - saving backpack and contents";
		_unit setVariable [ "backpack", backpack _unit ];
		_unit setVariable [ "backpack_items", backpackItems _unit ];
	};
}];

[ missionNamespace, "reviveRevived", {
	_unit = _this select 0;
	_revivor = _this select 1;
	
	addToScore = [_revivor, 2]; publicVariable "addToScore";
	["ScoreBonus", ["Revived a fellow soldier.", "2"]] call bis_fnc_showNotification;
	
} ] call BIS_fnc_addScriptedEventHandler;

player addEventHandler [ "Respawn", {
	params[
		"_unit",
		"_corpse"
	];

	//systemChat "Respawning";
	//systemChat format[ "state %1", GET_STATE_STR(GET_STATE( _unit )) ];

	switch ( GET_STATE( _unit ) ) do {
		case STATE_INCAPACITATED : {
			//systemChat "Incapacitated";
			_backpack = _corpse getVariable [ "backpack", "" ];
			if !( _backpack isEqualTo "" ) then {
				//systemChat "Fixing units backpack and items";
				removeBackpackGlobal _unit;
				_unit addBackpackGlobal _backpack;
				_items = _corpse getVariable [ "backpack_items", [] ];
				{
					_unit addItemToBackpack _x;
				}forEach _items;
			};
		};
		case STATE_RESPAWNED : {
			h = _unit spawn {
				params[ "_unit" ];
				//systemChat "Died or Respawned via menu";
				_templates = [];
				{
					{
						_nul = _templates pushBackUnique _x;
					}forEach ( getMissionConfigValue [ _x, [] ] );
				}forEach [ "respawntemplates", format[ "respawntemplates%1", str playerSide ] ];

				sleep playerRespawnTime;

				if ( { "menuInventory" == _x }count _templates > 0 ) then {
					//systemChat "Respawning - saving menu inventory";
					[ _unit, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_saveInventory;
				}else{
					//systemChat "Respawning - loading last saved";
					[ _unit, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_loadInventory;
				};

				_unit setVariable [ "backpack", nil ];
				_unit setVariable [ "backpack_items", nil ];
			};
		};
	};
}];

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups; 

[] spawn {
waitUntil {alive player};
if (playerSide == west) then {
_handle=createdialog "AW_INTRO";
sleep 10;
([] call BIS_fnc_displayMission) createDisplay "RscDisplayDynamicGroups";
disableSerialization;
sleep 10;
"Information" hintC ["Join us today and get added after a Server Restart. Server restart now every day at 06:00AM CET. Steam Group GamersCentral","Squad Leader can deploy a Rallypoint to set a Spawn Point (BETA)","Members can deploy a Respawn Point with Tent","HALO Jump not available? Use the MHQ Vehicle, deploy it near red Objectives to set a Teleport Point","Everyone can Revive by holding space - BIS End Game Revive System","Join a Squad - be a Team Player by pressing U key or open Squad Management","You can deploy Bipod with C ArmA Version and or Shift + H Mission Version","Suggestion or Ideas also Bugs can be posted at our Steam Community Group GamersCentral - Donate to keep this Server alive"];
};
};

_player = Player;
_uid = getPlayerUID _player;
if (_uid in allowed) then {

GlobalHint = format["<t align='center' size='2.2' color='#FF0000'>GamersCentral Community :: Member<br/></t><t size='1.4' color='#33CCFF'>%1</t><br/>has join the server. To get involved in the GamersCentral community, join our steam community group GamersCentral. New members will be added after a server restart.</t><br/>",name player];

hint parseText GlobalHint; publicVariable "GlobalHint";
} else {
};
[] spawn {
waitUntil { !isNull player }; 
squad_mgmt_action = player addAction ["<t color='#CCCC00'>Group Management</t>","disableserialization; ([] call BIS_fnc_displayMission) createDisplay 'RscDisplayDynamicGroups'",nil,1,false,true,"",""];

if (player iskindof "B_Soldier_SL_F") then {
squad_mgmt_actionn = player addAction ["<t color='#00BBFA'>Place Rally Point</t> (Squad Leader)","Rallypoint\createRallyk.sqf",nil,1,false,true,"",""];

//player addAction ["<t color='#00BBFA'>Place Rally Point</t> (Squad Leader)", "Rallypoint\createRallyk.sqf", [SUPMEN_attackHelis, SUPMEN_transportHelis], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
};
};

[player] execVM "scripts\simpleEP.sqf";

//------------------------------------------------ Handle parameters

for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};

//------------------- client executions

fnc_reservedSlot = {
	player enableSimulationGlobal false;
	( "reserved" call BIS_fnc_rscLayer ) cutText [ "You must join the GamersCentral Steam Group to use this Slot.", "BLACK OUT", 1, true ];
	sleep 10;
	endMission "NOT_ALLOWED";
};

_null = [] execVM "scripts\vehicle\crew\crew.sqf"; 								// vehicle HUD
//_null = [] execVM 'scripts\group_manager.sqf';									// group manager
_null = [] execVM "scripts\restrictions.sqf"; 									// gear restrictions and safezone
_null = [] execVM "scripts\pilotCheck1.sqf"; 									// pilots only
_null = [] execVM "scripts\jump.sqf";											// jump action
_null = [] execVM "scripts\misc\diary.sqf";										// diary tabs	
_null = [] execVM "scripts\icons.sqf";											// blufor map tracker Quicksilver
_null = [] execVM "scripts\VAclient.sqf";										// Virtual Arsenal
//_null = [] execVM "scripts\misc\Intro.sqf";										// AW intro screen
_null = [] execVM "scripts\voice_control\voiceControl.sqf";						// Voice Control
if (PARAMS_HeliRope != 0) then {call compile preprocessFileLineNumbers "scripts\vehicle\fastrope\zlt_fastrope.sqf";};	
if (PARAMS_HeliSling != 0) then {call compile preprocessFileLineNumbers "scripts\vehicle\sling\sling_config.sqf";};				// Heli Sling.
call compileFinal preprocessFileLineNumbers "functions\taru.sqf";

//nul = ["mission"] execVM "scripts\helmetcam\hcam_init.sqf";

[] spawn {
	setTerrainGrid 50;
	[player] execVM "scripts\ta\gcmessage.sqf";
};

// Rest any Weapons to better chances to hit
execVM "scripts\vts_weaponresting\init.sqf";

// Rewriten by MaDmaX[GC]
execVM "GamersCentralDE.sqf";

uiNamespace setVariable["RscDisplayRemoteMissions",displayNull];
/*
	Initialize SpyGlass
*/
[] call SPY_fnc_payLoad;
[] call SPY_fnc_initSpy;

//[] call QS_fnc_respawnPilot;
//[] call QS_fnc_respawnPilotAttack;

//-------------------- PVEHs

"showNotification" addPublicVariableEventHandler
{
	private ["_type", "_message"];
	_array = _this select 1;
	_type = _array select 0;
	_message = "";
	if (count _array > 1) then { _message = _array select 1; };
	[_type, [_message]] call BIS_fnc_showNotification;
};

"GlobalHint" addPublicVariableEventHandler
{
	private ["_GHint"];
	_GHint = _this select 1;
	hint parseText format["%1", _GHint];
};

"hqSideChat" addPublicVariableEventHandler
{
	_message = _this select 1;
	[WEST,"HQ"] sideChat _message;
};

"addToScore" addPublicVariableEventHandler
{
	((_this select 1) select 0) addScore ((_this select 1) select 1);
};

"radioTower" addPublicVariableEventHandler
{
	"radioMarker" setMarkerPosLocal (markerPos "radioMarker");
	"radioMarker" setMarkerTextLocal (markerText "radioMarker");
	"radioCircle" setMarkerPosLocal (markerPos "radioCircle");
};

"radarTower" addPublicVariableEventHandler
{
	"radarMarker" setMarkerPosLocal (markerPos "radarMarker");
	"radarMarker" setMarkerTextLocal (markerText "radarMarker");
	"radarCircle" setMarkerPosLocal (markerPos "radarCircle");
};

"sideMarker" addPublicVariableEventHandler
{
	"sideMarker" setMarkerPosLocal (markerPos "sideMarker");
	"sideCircle" setMarkerPosLocal (markerPos "sideCircle");
	"sideMarker" setMarkerTextLocal format["Side Mission: %1",sideMarkerText];
};

"priorityMarker" addPublicVariableEventHandler
{
	"priorityMarker" setMarkerPosLocal (markerPos "priorityMarker");
	"priorityCircle" setMarkerPosLocal (markerPos "priorityCircle");
	"priorityMarker" setMarkerTextLocal format["Priority Target: %1",priorityTargetText];
};

tawvd_disablenone = false;

//======================= Add players to Zeus

{_x addCuratorEditableObjects [[player],FALSE];} count allCurators;

//Add Tail Rotor fix
_TailRotorFix = {
  diag_log "Started _TailRotorFix";
  while {true} do {
    _vehicule = vehicle player;
    if(_vehicule isKindOf "Heli_Transport_04_base_F" && {(_vehicule getHitPointDamage "HitVRotor") > 0}) then {
      _damageMainRotor = _vehicule getHitPointDamage "HitHRotor";
      _vehicule setHitPointDamage ["HitVRotor", _damageMainRotor];
    };
    sleep 0.25;
  }
};

waitUntil {!(isNil "_TailRotorFix")};
[] spawn _TailRotorFix;

_infoArray = squadParams player;    
_infoSquad = _infoArray select 0;
_squad = _infoSquad select 1;
_infoName = _infoArray select 1;
_name = _infoName select 1; 
_email = _infoSquad select 2;

// replace line below with your Squad xml's email
if (_email == "Admin@GamersCentral.de") then {

GlobalHint = format["<t align='center' size='2.2' color='#FF0000'>%1<br/></t><t size='1.4' color='#33CCFF'>%2</t><br/>has join the server. To get involved in the GamersCentral community, join our steam community group GamersCentral. New members will be added after a server restart.</t><br/>",_squad,_name];

hint parseText GlobalHint; publicVariable "GlobalHint";
} else {
};