# GamersCentral.de-AW-Invade-Annex ALTIS

A Custimized Version of Mission Ahoy World Invade &amp; Annex edited by http://GamersCentral.de


# # # CREDITS # # #

Main Creator of this Mission is Ahoy World.

The leader of all those Changes is MaDmaX. Please Respect he's work, great Ideas and improvements. If you like to use a Script, made by him, for your Mission then, please ask him first for permission. If you dont like to ask then you have to add Credits Information about its Project.



# # # FEATURES # # #

Squad Managment + Options (hold T)

Helmet Camera

Transport Logistics - [R3F] Logistics

* Teleport to far places - MaDmaX Script

MHQ Vehicle

Dynamic Weather

Weapon Resting Bipod (Shift + H)

Unit Caching

Taru MOD Pod (fixed)

HALO Jump (Only available when less than 2 Transport Vortex Pilots)

* Restricted Community only Vehicles (Follow to do below to use this) - MaDmaX Script

* PVP Function - (You will get a Flag Pole as Side Mission reward which allow you to Join the OPFOR Side to AO for 15 Minutes) - MaDmaX Script

Base No Damage Safe Zone





# # # INFO # # #

PSD Pictures for Map can be Downloaded here: http://gamersupload.de/file/568/billboard-intel.rar.html



# # #  REQIRED:  # # 

Create a Folder in Root Directory of your ArmA III Server - InvadeAnnex_settings

Create 3 Files in the Folder InvadeAnnex_settings - communityList.sqf - init.sqf - VIPcommunityList.sqf

# Or remove
if (isServer) then {

  externalConfigFolder = "\InvadeAnnex_settings";
  
  [] execVM (externalConfigFolder + "\init.sqf");
  
};
# in init.sqf in your Mission Folder in order to disable Community Vehicles


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



# # # SUPPORT # # #

http://GamersCentral.de/

http://steamcommunity.com/groups/GamersCentral/

Support@GamersCentral.de

TS3.GamersCentral.de
