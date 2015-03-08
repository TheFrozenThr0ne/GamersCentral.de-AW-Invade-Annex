sleep 10;
_image = parseText "<img size='8' image='ta\gc.paa'/>";
_imageSmall = parseText "<img size='5' image='ta\gc.paa'/>";
_sep = parseText "<br />--------------------------------<br />";
_main = parseText "Pilot Rules!";
_rules = parseText "This is an Co-Op Server!<br/>Just leave this if you don't know what youre doing!<br/>Don't spawn enemys at or near base or directly on players!<br/>Don't spawn friendlys to over take AO or SM!<br/>If you ignore the Rules you risk to get permanently banned!<br/>Don't destroy SM or Tower and do not kill enemys!<br/><br/>You allowed to create new Challanges and that's it!<br/>You can learn it on singleplayer!<br/>Please Play Nice!<br/><br/><br/>TeamSpeak3 TS3.GAMERSCENTRAL.DE<br/>";
_txt = composeText [_image, _sep, _main, _sep, _rules];
_txtRep = composeText [_image, _sep, _main, _sep, _rules];

sleep 35;
hint _txt;
//sleep 180;
//hint _txt;

/*
while {true} do {
sleep 900;
hintSilent _txtRep;
}
*/