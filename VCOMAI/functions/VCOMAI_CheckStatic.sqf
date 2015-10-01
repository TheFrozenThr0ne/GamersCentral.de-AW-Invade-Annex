
_weapon = nearestObject [(getposATL _this),"StaticWeapon"];
if !(isNull _weapon || {(_weapon distance _this) > 100}) then
{
	_this setVariable ["VCOMAI_StaticNearby",true,false];
}
else
{
	_this setVariable ["VCOMAI_StaticNearby",false,false];
};