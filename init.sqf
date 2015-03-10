/*
@filename: init.sqf
Author:
	
	Quiksilver

Last modified:

	12/05/2014
	
Description:

	Things that may run on both server and client.
	Deprecated initialization file, still using until the below is correctly partitioned between server and client.
______________________________________________________*/

if (isServer) then {
  externalConfigFolder = "\InvadeAnnex_settings";
  [] execVM (externalConfigFolder + "\init.sqf");
};

DAC_Basic_Value = 0;execVM "DAC\DAC_Config_Creator.sqf";
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";		// revive
execVM "R3F_LOG\init.sqf";

if (isServer) then {[1000,-1,true,100,1000,1000]execvm "zbe_cache\main.sqf"};
//execFSM "core\fsm\ZBE_HCCache.fsm";

[] execVM "scripts\DOM_repair\init.sqf";
[] execVM "scripts\DOM_squad\init.sqf";
0 = [] execVM "scripts\DOM_squad\group_manager.sqf";
_null = [] execVM "scripts\units\tankCheck.sqf";
	
addMissionEventHandler ["HandleDisconnect", { 
    _unit  = _this select 0;
    _pos = getPosATL _unit;
    
    _wholder = nearestObjects [_pos, ["weaponHolderSimulated", "weaponHolder"], 2];
    
    {
        deleteVehicle _x;
    }forEach _wholder + [_unit];
    
    false
}];  


taskmasterLoaded = false;
call compile preprocessFileLineNumbers "scripts\ascomBackEnd.sqf";
call compile preprocessFileLineNumbers "scripts\ascomFunctions.sqf";
[] execVM "scripts\shk_taskmaster.sqf";
waitUntil {taskmasterLoaded};
if (isServer) then {
    waitUntil { !isNil "ASCOM_Initialized" };
};
waitUntil {!isNull player};
//Change the 2 arrays below for your heli names, eg ["aHeli1", "aHeli2"], ["tHeli1", "tHeli2"]
//Helicopter Names MUST BE IN "QUOTES!"
[player, ["aHeli1", "aHeli2", "aHeli3", "aHeli4", "aHeli5"], ["tHeli1", "tHeli2", "tHeli3", "tHeli4", "tHeli5", "tHeli6"]] execVM "scripts\supportMenu\supportMenuInit.sqf";