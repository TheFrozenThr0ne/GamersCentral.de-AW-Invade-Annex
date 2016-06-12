//monitorAIgroups 1.0 by SPUn
if(!isServer)exitWith{};
private["_classnames","_faction","_aliveCount"];

while{true}do{
	{
		_classnames = _x getVariable "classnames";
		if(!isNil("_classnames"))then{
			_aliveCount = {alive _x} count units _x;
			if(_aliveCount == 0)then{
				if((_x getVariable "state") == "alive")then{
					_faction = faction (leader _x);
					[_classnames,_faction,_x] spawn AIRS_SpawnGroup;
				};
			};
		};
	}forEach allGroups;
	sleep 10;
	if(!AIRS_respawn_WEST && !AIRS_respawn_EAST && !AIRS_respawn_INDE)exitWith{};
};