private [ "_accelerated_time" ];

if (PARAMS_StateDayTimeMultiplier == 1) then {

setTimeMultiplier PARAMS_DayTimeMultiplier;

while { true } do {
	if ( daytime > 20 || daytime < 4 ) then {
		_accelerated_time = PARAMS_DayTimeMultiplierFastNight * 3;
		if ( _accelerated_time > PARAMS_DayTimeMultiplierFastNight ) then {
			_accelerated_time = PARAMS_DayTimeMultiplierFastNight;
		};
		setTimeMultiplier _accelerated_time;
	} else {
		setTimeMultiplier PARAMS_DayTimeMultiplier;
	};
	sleep 10;
};
};