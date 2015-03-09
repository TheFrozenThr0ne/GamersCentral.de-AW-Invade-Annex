diag_log ["##Spawn_Soldiers##"];
/*
	File: ai.sqf
	Author: drsubo
	usage : [_uLoc] execVM
*/
_centerpos = _this select 0;
_unit = objNull;


_unitGroup = createGroup RESISTANCE;
_unitGroup setBehaviour "AWARE";
_unitGroup setCombatMode "RED";

_unit1 = _unitGroup createUnit ["O_Soldier_F", _centerpos, [], 0, "CAN_COLLIDE"];
_unit2 = _unitGroup createUnit ["O_Soldier_GL_F", _centerpos, [], 0, "CAN_COLLIDE"];
_unit3 = _unitGroup createUnit ["O_soldier_M_F", _centerpos, [], 0, "CAN_COLLIDE"];
_unit4 = _unitGroup createUnit ["O_Soldier_lite_F", _centerpos, [], 0, "CAN_COLLIDE"];

_unit5 = _unitGroup createUnit ["O_Soldier_SL_F", _centerpos, [], 0, "CAN_COLLIDE"];
_unit6 = _unitGroup createUnit ["O_Soldier_A_F", _centerpos, [], 0, "CAN_COLLIDE"];
_unit7 = _unitGroup createUnit ["O_Soldier_AR_F", _centerpos, [], 0, "CAN_COLLIDE"];
_unit8 = _unitGroup createUnit ["O_medic_F", _centerpos, [], 0, "CAN_COLLIDE"];
_unit9 = _unitGroup createUnit ["O_soldier_exp_F", _centerpos, [], 0, "CAN_COLLIDE"];


_unit1 setVariable["LASTLOGOUT_EPOCH",99999999];
_unit2 setVariable["LASTLOGOUT_EPOCH",99999999];
_unit3 setVariable["LASTLOGOUT_EPOCH",99999999];
_unit4 setVariable["LASTLOGOUT_EPOCH",99999999];
_unit5 setVariable["LASTLOGOUT_EPOCH",99999999];
_unit6 setVariable["LASTLOGOUT_EPOCH",99999999];
_unit7 setVariable["LASTLOGOUT_EPOCH",99999999];
_unit8 setVariable["LASTLOGOUT_EPOCH",99999999];
_unit9 setVariable["LASTLOGOUT_EPOCH",99999999];

_unit setSkill 0.6;
_unit setRank "Private";
_unit enableAI "TARGET";
_unit enableAI "AUTOTARGET";
_unit enableAI "MOVE";
_unit enableAI "ANIM";
_unit enableAI "FSM";

//Sniper
_unit1 setRank "Private";
_unit1 enableAI "TARGET";
_unit1 enableAI "AUTOTARGET";
_unit1 enableAI "MOVE";
_unit1 enableAI "ANIM";
_unit1 enableAI "FSM";
_unit1 setSkill 0.7;
//Rifleman
_unit2 setRank "Private";
_unit2 enableAI "TARGET";
_unit2 enableAI "AUTOTARGET";
_unit2 enableAI "MOVE";
_unit2 enableAI "ANIM";
_unit2 enableAI "FSM";
_unit2 setSkill 0.7;
//Hunter
_unit3 setRank "Private";
_unit3 enableAI "TARGET";
_unit3 enableAI "AUTOTARGET";
_unit3 enableAI "MOVE";
_unit3 enableAI "ANIM";
_unit3 enableAI "FSM";  
_unit3 setSkill 0.5;

//Diver
_unit4 setRank "Private";
_unit4 enableAI "TARGET";
_unit4 enableAI "AUTOTARGET";
_unit4 enableAI "MOVE";
_unit4 enableAI "ANIM";
_unit4 enableAI "FSM";
_unit4 setSkill 0.6;

//Armed Civ
_unit5 setRank "Private";
_unit5 enableAI "TARGET";
_unit5 enableAI "AUTOTARGET";
_unit5 enableAI "MOVE";
_unit5 enableAI "ANIM";
_unit5 enableAI "FSM";
_unit5 setSkill 0.5;
//hunter
_unit6 setRank "Private";
_unit6 enableAI "TARGET";
_unit6 enableAI "AUTOTARGET";
_unit6 enableAI "MOVE";
_unit6 enableAI "ANIM";
_unit6 enableAI "FSM";
_unit6 setSkill 0.5;
//hunter
_unit7 setRank "Private";
_unit7 enableAI "TARGET";
_unit7 enableAI "AUTOTARGET";
_unit7 enableAI "MOVE";
_unit7 enableAI "ANIM";
_unit7 enableAI "FSM";
_unit7 setSkill 0.5;
//hunter
_unit8 setRank "Private";
_unit8 enableAI "TARGET";
_unit8 enableAI "AUTOTARGET";
_unit8 enableAI "MOVE";
_unit8 enableAI "ANIM";
_unit8 enableAI "FSM";         
_unit8 setSkill 0.5;
//hunter
_unit9 setRank "Private";
_unit9 enableAI "TARGET";
_unit9 enableAI "AUTOTARGET";
_unit9 enableAI "MOVE";
_unit9 enableAI "ANIM";
_unit9 enableAI "FSM";  
_unit9 setSkill 0.5;


_unitGroup selectLeader _unit1;
