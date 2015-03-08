sleep 10;
_image = parseText "<img size='8' image='ta\gc.paa'/>";
_imageSmall = parseText "<img size='5' image='ta\gc.paa'/>";
_sep = parseText "<br />--------------------------------<br />";
_main = parseText "Pilot Rules!";
_rules = parseText "This is an Co-Op Server!<br/>Practise your flying at home!<br/>Don't ditch choppers to fight on the front line!<br/>No destruction of friendly equipment!<br/>Do not fly risky!<br/>Airlift only on requests allowed!<br/>Coordinate with other Pilots!<br/>Do not fly if you cant, learn it on singleplayer!<br/>Please Play Nice!<br/><br/><br/>TeamSpeak3 TS3.GAMERSCENTRAL.DE<br/>";
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