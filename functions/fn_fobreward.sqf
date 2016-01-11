	private ["_veh","_vehName","_vehVarname","_completeText","_reward","_GAU","_rabbit","_mortar"];

smRewards =
[
	["an AH-9 Pawnee GMG - 20MM", "Land_GarbageBags_F"],
	["an FV-720 Mora", "I_APC_tracked_03_cannon_F"],
	["an AFV-4 Gorgon", "I_APC_Wheeled_03_cannon_F"],
	["an AMV-7 Marshall", "B_APC_Wheeled_01_cannon_F"],
	["an MBT-52 Kuma", "I_MBT_03_cannon_F"],
	["an Offraod (Repair)", "C_Offroad_01_repair_F"],
	["a Strider HMG", "I_MRAP_03_hmg_F"],
	["an Offraod (Repair)", "C_Offroad_01_repair_F"],
	["a Strider HMG", "I_MRAP_03_hmg_F"],
	["a Strider HMG", "I_MRAP_03_hmg_F"],
	["a Strider HMG", "I_MRAP_03_hmg_F"],
	["a Mobile Mortar Truck", "B_G_Offroad_01_repair_F"],
	["a Mobile Mortar Truck", "B_G_Offroad_01_repair_F"],
	["an Offroad (Armed GMG)", "Land_InfoStand_V1_F"],
	["an Offroad (Armed GMG)", "Land_InfoStand_V1_F"],
	["a CRV-6e Bobcat", "B_APC_Tracked_01_CRV_F"]
];

_veh = smRewards call BIS_fnc_selectRandom;
_vehName = _veh select 0;
_vehVarname = _veh select 1;

_reward = _vehVarname createVehicle getMarkerPos apcPad1;
_vicDir1 = (markerDir apcPad1);
_reward setDir _vicDir1;
waitUntil {!isNull _reward};

_completeText = format[
"<t align='center'><t size='2.2'>FOB Mission</t><br/><t size='1.5' color='#08b000'>COMPLETE</t><br/>____________________<br/>Fantastic job, lads! The OPFOR stationed on the island won't last long if you keep that up!<br/><br/>We've given you %1 to help with the fight. You'll find it at the FOB.<br/><br/>Focus on the main objective for now; we'll relay this success to the intel team and see if there's anything else you can do for us. We'll get back to you in 5-10 minutes.</t>",_vehName];
[_completeText] remoteExec ["AW_fnc_globalHint",0,false];

if (_reward isKindOf "B_G_Offroad_01_repair_F") exitWith {
	_mortar = "B_Mortar_01_F" createVehicle getMarkerPos apcPad1;
	_mortar attachTo [_reward,[0,-2.5,.3]];
};
if (_reward isKindOf "Land_InfoStand_V1_F") exitWith {
	deleteVehicle _reward;
	_truck = "B_G_Offroad_01_repair_F" createVehicle getMarkerPos apcPad1;
	_truck setDir _vicDir1;
	_GMG = createVehicle ["B_GMG_01_high_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_GMG attachTo [_truck,[0,-2.5,.8]];
};
{
	_x addCuratorEditableObjects [[_reward], false];
} foreach adminCurators;