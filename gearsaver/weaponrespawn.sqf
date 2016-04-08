//////////////////////////////////////////////////////////////////
// Function file for Arma3
// Created origanlly by: Salsa and Gobbo
// Edited by:  MetaliX and M416_KSA
//
// for more information about this script visit:
// http://www.armaholic.com/page.php?id=21334
//////////////////////////////////////////////////////////////////

waitUntil {!alive player};
waitUntil {alive player};

_p = player;
removeAllAssignedItems _p;
removeAllItems _p;
removeAllWeapons _p;
removeVest _p;
removeUniform _p;
removeHeadgear _p;
removeBackpack _p;
if (uniform01var !="") then{removeUniform _p;_p addUniform uniform01var;};
if (vest01var !="") then {removeVest _p;_p addVest vest01var;};
if (backpack01var !="") then{removeBackpack _p;_p addBackpack backpack01var;};
if (headgear01var !="") then {removeHeadgear _p;_p addHeadgear headgear01var;};
if (goggles01var !="") then {removeGoggles _p;_p addgoggles goggles01var;};
{_p addMagazine _x} forEach magazines01var;
{_p addWeapon _x} forEach weapons01var;
{_p addPrimaryWeaponItem _x} forEach primacc01var;
{_p addSecondaryWeaponItem _x} forEach secacc01var;
{_p addHandgunItem _x} forEach sideacc01var;
{_p addItem _x} forEach items01var;
{_p addItem _x} forEach assitems01var;
{_p assignItem _x} forEach assitems01var;