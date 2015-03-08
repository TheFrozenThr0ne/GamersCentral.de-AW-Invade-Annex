_num1 = 1;
_num2 = 2;
_num3 = 3;

_Stxt = parseText format
["
<t color='#FF3B3E' size='1.2' align='center'>NON COMMUNITY MEMBER DETECTED!</t><br/><br/>

~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
<t color='#ffff00' size='1' align='left'>Name:</t> %4<br/>
<t color='#ffff00' size='1' align='left'>Status:</t> Not Qualified<br /><br/>
~~~~~~~~~~~~~~~~~~~~~~~~~<br/><br /><br />

<t color='#FF7700' size='1'>This is an Community Vehicle, Please leave this Slot blank if youre in a Reserved Slot.<br/><br/>


Begin playing Regular here, come Join our TeamSpeak 3 Server to higher the chances to become a part of our Reserved Community Attacker Slots.</t><br/><br/><br/>
This Vehicle is locked because we would like to build something, if you're experienced then it would be great if you will be a part of this Server.<br/>br/>http://Join.GamersCentral.de<br/>br/><br/>
<br/><br/>
Enjoy your time in our Server.<br/><br/><br/><br/>

~~~~~~~~~~~~~~~~~~~~~~~~~<br/>
TS3.GamersCentral.de<br/>
~~~~~~~~~~~~~~~~~~~~~~~~~<br/>

", _num1, _num2, _num3, name player];


hintSilent _Stxt;
	