

  //_addtime = 10; 		// Number of minutes you want to advance per cycle)
  //_delay = 180; 		// delay in seconds between loops (3 minutes in this example)
  
	_addtime = PARAMS_DayDuration;
	_delay = 10;
	
While{TRUE}do
{
        // If the time is between 4am and 6pm, lets speed up the updates and reduce the time advance
        if((Date select 3) > 4)&&((Date select 3) < 6))then{_delay = 60; _addtime = 5}else{_delay = 180; addtime = 10};

        // If the time is between 6pm and 8pm, lets speed up the updates and reduce the time advance
        if((Date select 3) > 18)&&((Date select 3) < 20))then{_delay = 60; _addtime = 5}else{_delay = 180; addtime = 10};
	sleep _delay;
	Tag_NewDate = [date select 0, date select 1, date select 2, date select 3, (date select 4 + _addtime)];
	PublicVariable "Tag_NewDate";
	SetDate Tag_NewDate;
};