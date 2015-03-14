private ["_veh","_vehName","_vehVarname","_completeTextJet","_flagPole","_reward","_GAU","_rabbit"];

smRewards =
[
	["an MI-48 Kajman", "O_Heli_Attack_02_black_F"],
	["a WY-55 Hellcat", "I_Heli_light_03_F"],
	["an AH-9 Pawnee GAU - 19", "Rabbit_F"],
	["an FV-720 Mora", "I_APC_tracked_03_cannon_F"],
	["an AFV-4 Gorgon", "I_APC_Wheeled_03_cannon_F"],
	["an IFV-6a Cheetah", "B_APC_Tracked_01_AA_F"],
	["an AMV-7 Marshall", "B_APC_Wheeled_01_cannon_F"],
	["an MBT-52 Kuma", "I_MBT_03_cannon_F"],
	["an M2A4 Slammer (Urban Purpose)", "B_MBT_01_TUSK_F"],
	["a Flag Pole allow you to fight against BLUFOR","Flag_White_F"]
];
smMarkerList =
["smReward1","smReward2","smReward3","smReward4","smReward5","smReward6","smReward7","smReward8","smReward9","smReward10","smReward11","smReward12","smReward13","smReward14","smReward15","smReward16","smReward17","smReward18","smReward19","smReward20","smReward21","smReward22","smReward23","smReward24","smReward25","smReward26","smReward27"];

_veh = smRewards call BIS_fnc_selectRandom;

_vehName = _veh select 0;
_vehVarname = _veh select 1;

_completeTextJet = format[
"<t align='center'><t size='2.2'>Priority Target</t><br/><t size='1.5' color='#08b000'>Enemy CAS Neutralized</t><br/>____________________<br/>Fantastic job, lads! The OPFOR stationed on the island won't last long if you keep that up!<br/><br/>We've given you %1 to help with the fight. You'll find it at base.<br/><br/>Focus on the main objective for now.</t>",_vehName];

_flagPole = format[
"<t align='center'><t size='2.2' color='#E00000'>PVP ENABLED</t><br/><t align='center'><t size='2.2'>Flag Pole</t><br/><t size='1.5' color='#FD67D5'>AVAILABLE</t><br/>____________________<br/>You are now able to join the OPFOR forces to AO! You find the Flag Pole at the Base on the Spawn Point. The flag pole will be removed within 15 minutes until you get a new one as reward!<br/><br/><br/>- Status: Beta<br/><br/>Follow the Rules!</t>",_vehName];
	
	
_reward = createVehicle [_vehVarname, getMarkerPos "smReward1",smMarkerList,0,"NONE"];
waitUntil {!isNull _reward};

_reward setDir 284;

/*
GlobalHint = _completeTextJet; publicVariable "GlobalHint"; hint parseText _completeTextJet;
showNotification = ["EnemyJetDown", "Enemy CAS is down. Well Done!"]; publicVariable "showNotification";
*/

showNotification = ["Reward", format["Your team received %1!", _vehName]]; publicVariable "showNotification";
	
// Great idea by MaDmaX[GC] - Allows players for 15 mintes to join the OPFOR forces - spawn random at AO or Side Mission if active.
	if (_reward isKindOf "Flag_White_F") then {
	deleteVehicle _reward;
	
	GlobalHint = _flagPole; publicVariable "GlobalHint"; hint parseText _flagPole;
	
	_spwnPole = getMarkerPos "poleReward";
	opforteleport setPos _spwnPole;
	
	"againstblufor" setMarkerPos getPos opforteleport;

	[] call QS_fnc_OpforFlagSleepAndRemove;
	
	//opforteleport setPos [-10000,10000,10000];
	//"againstblufor" setMarkerPos [-10000,-10000,-10000];
	};
	
if (_reward isKindOf "Rabbit_F") exitWith {
	_GAU = createVehicle ["B_Heli_Light_01_armed_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_GAU setDir 284;
	_reward setDamage 1;
	_GAU removeMagazine ("5000Rnd_762x51_Belt");
	_GAU removeWeapon ("M134_minigun");
	_GAU addWeapon ("HMG_127_APC");
	_GAU addMagazine ("500Rnd_127x99_mag_Tracer_Red");
	{_x addCuratorEditableObjects [[_GAU], false];} foreach adminCurators;
};

{
	_x addCuratorEditableObjects [[_reward], false];
} foreach adminCurators;