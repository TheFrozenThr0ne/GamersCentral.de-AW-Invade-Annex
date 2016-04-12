private [ "_accelerated_time" ];

setTimeMultiplier PARAMS_DayTimeMultiplier;

while { true } do {
	if ( daytime > 20 || daytime < 4 ) then {
		_accelerated_time = 100 * 3;
		if ( _accelerated_time > 100 ) then {
			_accelerated_time = 100;
		};
		setTimeMultiplier _accelerated_time;
	} else {
		setTimeMultiplier PARAMS_DayTimeMultiplier;
	};
	sleep 10;
};
