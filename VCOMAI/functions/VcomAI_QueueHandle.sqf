while {true} do
{
	//systemchat format ["VcomAI_UnitQueue: %1",VcomAI_UnitQueue];
	if !(VcomAI_UnitQueue isEqualTo []) then
	{
		_ConsideringUnit = VcomAI_UnitQueue select 0;
		if !(isNull _ConsideringUnit) then 
		{
			if (side _ConsideringUnit in VCOM_SideBasedExecution) then
			{
				[_ConsideringUnit] execFSM "VCOMAI\AIBEHAVIORNEW.fsm";
			};
				VcomAI_ActiveList pushback _ConsideringUnit;
				VcomAI_UnitQueue = VcomAI_UnitQueue - [_ConsideringUnit];			
		}
		else
		{
			VcomAI_UnitQueue = VcomAI_UnitQueue - [_ConsideringUnit];		
		};
	};

	
	//systemchat format ["VcomAI_ActiveList: %1",VcomAI_ActiveList];
	sleep 0.25;
	{
		if (isNull _x) then {VcomAI_ActiveList = VcomAI_ActiveList - [_x];};
	} foreach VcomAI_ActiveList;
	
};