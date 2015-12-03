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

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups; 

_null = [] execVM "scripts\vehicle\crew\crew.sqf"; 								// vehicle HUD
_null = [] execVM 'scripts\group_manager.sqf';									// group manager
_null = [] execVM "scripts\restrictions.sqf"; 									// gear restrictions and safezone
_null = [] execVM "scripts\pilotCheck1.sqf"; 									// pilots only
_null = [] execVM "scripts\jump.sqf";											// jump action
_null = [] execVM "scripts\misc\diary.sqf";										// diary tabs	
_null = [] execVM "scripts\icons.sqf";											// blufor map tracker Quicksilver
_null = [] execVM "scripts\VAclient.sqf";										// Virtual Arsenal
_null = [] execVM "scripts\misc\Intro.sqf";										// AW intro screen
_null = [] execVM "scripts\voice_control\voiceControl.sqf";						// Voice Control
if (PARAMS_HeliRope != 0) then {call compile preprocessFileLineNumbers "scripts\vehicle\fastrope\zlt_fastrope.sqf";};	
if (PARAMS_HeliSling != 0) then {call compile preprocessFileLineNumbers "scripts\vehicle\sling\sling_config.sqf";};				// Heli Sling.
call compileFinal preprocessFileLineNumbers "functions\taru.sqf";

nul = ["mission"] execVM "scripts\helmetcam\hcam_init.sqf";

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
systemChat "Initialize SpyGlass";
[] call SPY_fnc_payLoad;
[] call SPY_fnc_initSpy;
systemChat "SpyGlass Initialized";

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

//initPlayerLocal.sqf

//small sleep to make sure any init loadouts have been applied
//OR apply any default loadouts before this point
sleep 1;
[missionnamespace, "arsenalClosed",
{
	// Save inventory for loading after respawn
	[player, [missionnamespace, "VirtualInventory"]] call BIS_fnc_saveInventory;
}] call BIS_fnc_addScriptedEventHandler;

//Save initial loadout
[ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_saveInventory;


//Save loadout when ever we exit an arsenal
[ missionNamespace, "arsenalClosed", {
	[ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_saveInventory;
}] call BIS_fnc_addScriptedEventHandler;


//When we revive
[ missionNamespace, "reviveRevived", {
	_nul = _this spawn {
		_unit = _this select 0;
		_revivor = _this select 1;

		//if forced respawn or we bleed out
		if ( isNull _revivor ) then {
			//wait until player is actually respawned into alive state
			sleep playerRespawnTime;
			//Load last saved inventory
			[ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_loadInventory;
		};
	};
} ] call BIS_fnc_addScriptedEventHandler;


player addEventHandler [ "Killed", {
	//Save players loadout for if he is revived
	[ player, [ missionNamespace, "reviveInventory" ] ] call BIS_fnc_saveInventory;
}];


player addEventHandler [ "Respawn", {
	if ( player getVariable [ "BIS_revive_incapacitated", false ] ) then {
		//Set correct loadout on incapacitated unit laying on floor in injured state
		//This is also the new unit if he is revived
		[ player, [ missionNamespace, "reviveInventory" ] ] call BIS_fnc_loadInventory;
	};
	//Did we respawn from the menu
	if ( missionNamespace getVariable [ "menuRespawn", false ] ) then {
		
		missionNamespace setVariable [ "menuRespawn", false ];
	};
}];

		
//If the respawn menu button is active
if ( !isNumber( missionConfigFile >> "respawnButton" ) || { getNumber( missionConfigFile >> "respawnButton" ) > 0 } ) then {
	_respawnMenu = [] spawn {
		waitUntil { !isNull ( uiNamespace getVariable [ "RscDisplayMPInterrupt", displayNull ] ) };
		uiNamespace getVariable "RscDisplayMPInterrupt" displayCtrl 1010 ctrlAddEventHandler [ "ButtonClick", {
			missionNamespace setVariable [ "menuRespawn", true ];
		}];
	};
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
if (_email == "Support@GamersCentral.de") then {

GlobalHint = format["<t align='center' size='2.2' color='#FF0000'>%1<br/></t><t size='1.4' color='#33CCFF'>%2</t><br/>has joined the server. To get involved in the GamersCentral community, Join our Steam Community Group GamersCentral and Apply - oder sprichst du Deutsch, dann besuche unsere Community Webseite unter http://GamersCentral.de Registriere und Bewirb dich!</t><br/>",_squad,_name];

hint parseText GlobalHint; publicVariable "GlobalHint";
} else {};