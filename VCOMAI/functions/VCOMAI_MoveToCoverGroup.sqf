
{
	if !(_x getVariable "VCOM_MovedRecentlyCover") then
	{
		_x call VCOMAI_MoveToCover;
	};
} foreach (units (group _this));