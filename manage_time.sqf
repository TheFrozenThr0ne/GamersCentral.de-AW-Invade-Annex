private [ "_accelerated_time" ];

setTimeMultiplier 30;

while { true } do {
	if ( daytime > 20 || daytime < 4 ) then {
		_accelerated_time = 100 * 3;
		if ( _accelerated_time > 100 ) then {
			_accelerated_time = 100;
		};
		setTimeMultiplier _accelerated_time;
	} else {
		setTimeMultiplier 30;
	};
	sleep 10;
};
