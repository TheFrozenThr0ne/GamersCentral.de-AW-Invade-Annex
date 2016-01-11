//  ZeusPlayerUpdate Loop     //
//scripts\misc\zeusupdater.sqf//
//      MykeyRM [AW]          //
////////////////////////////////

//zeusupdater.sqf

waitUntil {time > 3};
call {while {true} do {objectsToAdd = (entities "AllVehicles" - entities "Animal" - entities "RoadCone_L_F" - [medicTruck, medicTruck_1, medicTruck_2, Damaged_Ghost, HEMTTu_1, HEMTTu_2, HEMTTu_3, HEMTTu_4, HEMTTu_5, HEMTTu_6, HEMTTu_7, HEMTTu_8, Quartermaster, crossroad, Injured1, Injured, Injured2, Supply_Officer]); publicVariable "objectsToAdd";{_x addCuratorEditableObjects [(objectsToAdd), true]; } foreach allCurators; sleep 180;};};

//player groupChat "Zeus unit updater running";        //Can have hint that updater is running on startup remove // to activate.