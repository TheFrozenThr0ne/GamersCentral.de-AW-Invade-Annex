_num1 = 1;
_num2 = 2;
_num3 = 3;

_Stxt = parseText format
["
<t color='#71FF61' size='1.6' align='center'>COMMUNITY MEMBER DETECTED!</t><br/><br/>

~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
<t color='#ffff00' size='1.2' align='left'>Name:</t> %4<br/>
<t color='#ffff00' size='1.2' align='left'>Status:</t> Qualified<br /><br/>
~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
<t color='#FF7700' size='1.6'>! Welcome !</t><br />
~~~~~~~~~~~~~~~~~~~~~~~~~<br/><br/>

<t size='1.2'>%4, please respect our rules.</t><br/><br/>

<t size='1.2'>We revoke access without announce. Take care!</t><br/><br/>

<t size='1.2'>Please be a paragon for other players!</t><br/><br/>

<t size='1.6'>Good Hunting.</t><br/><br/><br/>
~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
TS3.GamersCentral.de<br/>
~~~~~~~~~~~~~~~~~~~~~~~~~<br/>

", _num1, _num2, _num3, name player];

hintSilent _Stxt;
sleep 5;
hintSilent "";
	