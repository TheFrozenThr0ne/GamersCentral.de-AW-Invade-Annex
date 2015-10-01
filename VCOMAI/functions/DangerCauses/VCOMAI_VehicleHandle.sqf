_AssignedCargo = assignedCargo (vehicle _this);

if (_this in _AssignedCargo) then
{
	[_this] orderGetIn false;
	_this leaveVehicle (vehicle _this);
};