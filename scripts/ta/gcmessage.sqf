_image = parseText "<img size='8' image='scripts\ta\gc.paa'/>";
_imageSmall = parseText "<img size='5' image='scripts\ta\gc.paa'/>";
_sep = parseText "<br />--------------------------------<br />";
_main = parseText "Welcome to GamersCentral!";
_rules = parseText "New to this Mission? Read the Description and Information - Press M and click Top left at Mission for info.<br/><br/>This is an Co-Op Server!<br/>Team Killing = BAN<br/>Rape AO w/Aircraft = BAN<br/>Please Play Nice!<br/><br/>Join our Community today at http://Join.GamersCentral.de to get access to Community Commands and Vehicles.<br/><br/>Join our TeamSpeak3 TS3.GAMERSCENTRAL.DE<br/><br/>Please donate to keep this Server alive, type !donate in chat for more information!<br/><br/><br/>Enjoy our Customized Mission. Have Fun!<br/><br/><br/>NEW: HaloJump changed, if more than 2 Pilots are Online then Halo Jump is not more available.";
_txt = composeText [_image, _sep, _main, _sep, _rules];
_txtRep = composeText [_image, _sep, _main, _sep, _rules];

sleep 15;
hint _txt;
//sleep 180;
//hint _txt;

/*
while {true} do {
sleep 900;
hintSilent _txtRep;
}
*/