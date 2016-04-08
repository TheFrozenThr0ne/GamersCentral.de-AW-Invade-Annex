//////////////////////////////////////////////////////////////////
// Function file for Arma3
// Created origanlly by: Salsa and Gobbo
// Edited by:  MetaliX and M416_KSA
//
// for more information about this script visit:
// http://www.armaholic.com/page.php?id=21334
//////////////////////////////////////////////////////////////////

_XYZ=uniform player;
if (_XYZ !="") then {
uniform01var = _XYZ;
vest01var = vest player;
backpack01var = backpack player;
headgear01var = headgear player;
magazines01var = magazines player;
weapons01var = weapons player;
primacc01var = primaryWeaponItems player;
secacc01var = secondaryWeaponItems player;
sideacc01var = handgunItems player;
items01var = items player;
assitems01var = assignedItems player;
goggles01var = goggles player;
hint "Loadout Saved";} else {hint "GO GET SOMETHING ON!";};