// Add Actions, Actions in action menu.
// O-Group Briefing Maps
fnc_board_jip = {
act1 = sign_1 addaction ["<t color='#ffff11'>Whiteboard -> Clean</t>","intel\Scripts\clean.sqf"];
act1 = sign_1 addaction ["<t color='#ffff11'>Whiteboard -> Corkboard</t>","intel\Scripts\info.sqf"];
act1 = sign_1 addaction ["<t color='#ffff11'>Whiteboard -> Server Staff</t>","intel\Scripts\admins.sqf"];
act1 = sign_1 addaction ["<t color='#ffff11'>Whiteboard -> Community Vehicles</t>","intel\Scripts\vehicles.sqf"];
act1 = sign_1 addaction ["<t color='#ffff11'>Whiteboard -> About</t>","intel\Scripts\about.sqf"]; 
act2 = sign_1 addaction ["<t color='#ffff11'>Whiteboard -> Join us</t>","intel\Scripts\joinus.sqf"]; 
Sleep 1;
};

[[sign_1],"fnc_board_jip",true,true] spawn BIS_fnc_MP;