// Executed on the server.
lampcreateTaskAttack = {
    private ["_taskName", "_caller", "_tasktaker", "_target"];

    _taskName = _this select 0;
    _caller = _this select 1;
    _tasktaker = _this select 2;
    _target = _this select 3;

    // Code goes here!
    [_taskName,format ["Attack Run Request from %1", name _caller],"Friendlies have requested an attack run, send them to hell!", _taskTaker, [], "assigned", _target] call SHK_Taskmaster_add;
};

// Executed on the server.
lampcreateTaskTransport = {
    private ["_taskName", "_caller", "_taskTaker", "_target"];

    _taskName = _this select 0;
    _caller = _this select 1;
    _taskTaker = _this select 2;
    _target = _this select 3;

    // Code goes here!
    [_taskName,format ["Transport Request from %1", name _caller],"Friendlies have requested a transport, help them!", _taskTaker, [], "assigned", _target] call SHK_Taskmaster_add;
};

// Executed on the server.
lamptaskUpdate = {
    private ["_taskName", "_taskState"];

    _taskName = _this select 0;
    _taskState = _this select 1;

    // Code goes here!
    [_taskName,_taskState] call SHK_Taskmaster_upd;
};
