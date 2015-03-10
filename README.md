# GamersCentral.de-AW-Invade-Annex

A Custimized Version of Mission AW Invade &amp; Annex from http://GamersCentral.de


# # # INFO # #

PSD Pictures for Map can be Downloaded here: http://gamersupload.de/file/568/billboard-intel.rar.html



# # #  REQIRED:  # # 

Create a Folder in Root Directory of your ArmA III Server - InvadeAnnex_settings

Create 3 Files in the Folder InvadeAnnex_settings - communityList.sqf - init.sqf - VIPcommunityList.sqf



# # #  TO DO:  # # 

# # Copy below in to communityList.sqf #


masterClassArray = ["B_MBT_01_mlrs_F","O_Plane_CAS_02_F"];

masterUIDArray = [

  "76561198001220177", // MaDmaX
  
  "76561198001220177" // MaDmaX
  
];

publicVariable "masterClassArray";

publicVariable "masterUIDArray";





# # Copy below in to VIPcommunityList.sqf #

masterClassArrayVIP = [""];

masterUIDArrayVIP = [

  "76561198001220177", // MaDmaX
  
  "76561198001220177" // MaDmaX
  
];

publicVariable "masterClassArrayVIP";

publicVariable "masterUIDArrayVIP";




# # Copy below in to init.sqf #

execVM (externalConfigFolder + "\communityList.sqf");

execVM (externalConfigFolder + "\VIPcommunityList.sqf");





Replace the UID with yours for able to use Restricted Vehicles.

You can add Vehicle Class Names to masterClassArrayVIP = [""]; or masterClassArray = ["B_MBT_01_mlrs_F","O_Plane_CAS_02_F"]; to restrict Vehicles to only who are in the Community list.
