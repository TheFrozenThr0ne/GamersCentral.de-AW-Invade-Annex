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

/*if (isServer) then {
  externalConfigFolder = "\InvadeAnnex_settings";
  [] execVM (externalConfigFolder + "\init.sqf");
};*/

_null = [] execVM "members\communityList.sqf";

_IntroMusic            = true; // Welcome Intro Song
if (_IntroMusic) then { playMusic "intro";};

// [player] execVM "welcome.sqf";



["Initialize"] call BIS_fnc_dynamicGroups;
ETG_Reinforcements = 0;
// [] execVM "VCOMAI\init.sqf";

//Execute scripts
[] execVM "VCOM_Driving\init.sqf";



execVM "JWC_CASFS\initCAS.sqf";

// Admin reserved slot
// You can reserve admin slot	
INS_REV_CFG_reserved_slot = true;
INS_REV_CFG_reserved_slot_units = ["bis_curatorUnit_1","bis_curatorUnit_2","bis_curatorUnit_3"];
[] execVM "scripts\reserved_slot\reserved_slot.sqf";

// if (isServer) then {OnPlayerConnected "[_uid,_name] execVM ""members\checkslot.sqf""";};

// DAC_Basic_Value = 0;execVM "DAC\DAC_Config_Creator.sqf";
//call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";		// revive
call compile preprocessFile "=BTC=_TK_punishment\=BTC=_tk_init.sqf"; 

execVM "R3F_LOG\init.sqf";

if (isServer) then {[1000,-1,true,100,1000,1000]execvm "zbe_cache\main.sqf"};
//execFSM "core\fsm\ZBE_HCCache.fsm";

[] execVM "scripts\DOM_repair\init.sqf";
[] execVM "scripts\DOM_squad\init.sqf";
0 = [] execVM "scripts\DOM_squad\group_manager.sqf";
_null = [] execVM "scripts\units\tankCheck.sqf";
[] execVM "scripts\clean.sqf";	

// Compile scripts
getLoadout = compile preprocessFileLineNumbers 'get_loadout.sqf';
setLoadout = compile preprocessFileLineNumbers 'set_loadout.sqf';
               
			   
			                                    
// Save loadout every 2 seconds
[] spawn {
    while{true} do {
        if(alive player) then {
            respawnLoadout = [player] call getLoadout;
        };
    sleep 2;  
    };
};



// Load saved loadout on respawn
player addEventHandler ["Respawn", {
        [player, respawnLoadout] spawn setLoadout;
    }
];  


// Added load and save actions to all ammo boxes
{
	if(_x isKindOf "ReammoBox" || _x isKindOf "ReammoBox_F") then {
	    _x addAction ["<t color='#ff1111'>Save loadout</t>", { savedLoadout = [player] call getLoadout; }];
	    _x addAction ["<t color='#00cc00'>Load loadout</t>", { [player, savedLoadout] spawn setLoadout; }];   
	};
} forEach vehicles;

{
	if(_x isKindOf "B_Respawn_TentA_F" || _x isKindOf "B_Respawn_TentA_F") then {
	    _x addAction ["<t color='#ff1111'>VAS</t>","scripts\VAS\open.sqf",[],10,true,true,'((vehicle player) == player) && ((player distance _target) < 5)'];
		_x addAction ["Quick Gear Save",QS_fnc_saveInventory,[],7,true,true,'((vehicle player) == player) && ((player distance _target) < 5)'];
		_x addAction ["View Distance Settings",TAWVD_fnc_openTAWVD,[],-98,false,false,"",''];
	};
} forEach vehicles;


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
[player, ["aHeli1", "aHeli2", "aHeli3", "aHeli4", "aHeli5", "aHeli6"], ["tHeli1", "tHeli2", "tHeli3", "tHeli4", "tHeli5", "tHeli6", "tHeli7"]] execVM "scripts\supportMenu\supportMenuInit.sqf";
