private ["_caller","_attackHelis","_transportHelis","_attackH1","_attackH2","_attackH3","_attackH4","_attackH5","_attackH6","_tranH1","_tranH1_pilot","_tranH2","_tranH2_pilot","_tranH3","_tranH3_pilot","_tranH4","_tranH4_pilot","_tranH5","_tranH5_pilot","_tranH6","_tranH6_pilot","_tranH7","_tranH7_pilot","_attackH1_pilot","_attackH2_pilot","_attackH3_pilot","_attackH4_pilot","_attackH5_pilot","_attackH6_pilot"];
_caller = _this select 1;
_caller removeAction SUPMEN_cas;
_caller removeAction SUPMEN_trans;
// Attack Helicopter Mode
if (((_this select 3) select 0) == "attackHelis") then {
    _attackHelis = ((_this select 3) select 1);
    if ((count _attackHelis) >= 1) then {
        _attackH1 = call compile format["%1",((_attackHelis) select 0)];
        _attackH1_pilot = driver _attackH1;
        if (!isNull _attackH1_pilot) then {
            SUPMEN_attackH1 = _caller addAction[format ["<t color='#F07422'>Request Close Air Support from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Cursor Target</t>", name _attackH1_pilot, typeOf _attackH1], "scripts\supportMenu\createTask.sqf", [screenToWorld [0.5,0.5], _attackH1_pilot, "Attack"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
            SUPMEN_attackH1Map = _caller addAction[format ["<t color='#F07422'>Request Close Air Support from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Map Click</t>", name _attackH1_pilot, typeOf _attackH1], "scripts\supportMenu\createTaskMap.sqf", [_attackH1_pilot, "Attack"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
        };
    };
    if ((count _attackHelis) >= 2) then {
        _attackH2 = call compile format["%1",((_attackHelis) select 1)];
        _attackH2_pilot = driver _attackH2;
        if (!isNull _attackH2_pilot) then {
            SUPMEN_attackH2 = _caller addAction[format ["<t color='#F07422'>Request Close Air Support from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Cursor Target</t>", name _attackH2_pilot, typeOf _attackH2], "scripts\supportMenu\createTask.sqf", [screenToWorld [0.5,0.5], _attackH2_pilot, "Attack"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
            SUPMEN_attackH2Map = _caller addAction[format ["<t color='#F07422'>Request Close Air Support from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Map Click</t>", name _attackH2_pilot, typeOf _attackH2], "scripts\supportMenu\createTaskMap.sqf", [_attackH2_pilot, "Attack"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
        };
    };
    if ((count _attackHelis) >= 3) then {
        _attackH3 = call compile format["%1",((_attackHelis) select 2)];
        _attackH3_pilot = driver _attackH3;
        if (!isNull _attackH3_pilot) then {
            SUPMEN_attackH3 = _caller addAction[format ["<t color='#F07422'>Request Close Air Support from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Cursor Target</t>", name _attackH3_pilot, typeOf _attackH3], "scripts\supportMenu\createTask.sqf", [screenToWorld [0.5,0.5], _attackH3_pilot, "Attack"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
            SUPMEN_attackH3Map = _caller addAction[format ["<t color='#F07422'>Request Close Air Support from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Map Click</t>", name _attackH3_pilot, typeOf _attackH3], "scripts\supportMenu\createTaskMap.sqf", [_attackH3_pilot, "Attack"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
        };
    };
    if ((count _attackHelis) == 4) then {
        _attackH4 = call compile format["%1",((_attackHelis) select 3)];
        _attackH4_pilot = driver _attackH4;
        if (!isNull _attackH4_pilot) then {
            SUPMEN_attackH4 = _caller addAction[format ["<t color='#F07422'>Request Close Air Support from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Cursor Target</t>", name _attackH4_pilot, typeOf _attackH4], "scripts\supportMenu\createTask.sqf", [screenToWorld [0.5,0.5], _attackH4_pilot, "Attack"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
            SUPMEN_attackH4Map = _caller addAction[format ["<t color='#F07422'>Request Close Air Support from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Map Click</t>", name _attackH4_pilot, typeOf _attackH4], "scripts\supportMenu\createTaskMap.sqf", [_attackH4_pilot, "Attack"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
        };
    };
	 if ((count _attackHelis) == 5) then {
        _attackH5 = call compile format["%1",((_attackHelis) select 4)];
        _attackH5_pilot = driver _attackH5;
        if (!isNull _attackH5_pilot) then {
            SUPMEN_attackH5 = _caller addAction[format ["<t color='#F07422'>Request Close Air Support from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Cursor Target</t>", name _attackH5_pilot, typeOf _attackH5], "scripts\supportMenu\createTask.sqf", [screenToWorld [0.5,0.5], _attackH5_pilot, "Attack"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
            SUPMEN_attackH5Map = _caller addAction[format ["<t color='#F07422'>Request Close Air Support from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Map Click</t>", name _attackH5_pilot, typeOf _attackH5], "scripts\supportMenu\createTaskMap.sqf", [_attackH5_pilot, "Attack"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
        };
    };
	if ((count _attackHelis) == 6) then {
        _attackH6 = call compile format["%1",((_attackHelis) select 5)];
        _attackH6_pilot = driver _attackH6;
        if (!isNull _attackH6_pilot) then {
            SUPMEN_attackH6 = _caller addAction[format ["<t color='#F07422'>Request Close Air Support from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Cursor Target</t>", name _attackH6_pilot, typeOf _attackH6], "scripts\supportMenu\createTask.sqf", [screenToWorld [0.5,0.5], _attackH6_pilot, "Attack"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
            SUPMEN_attackH6Map = _caller addAction[format ["<t color='#F07422'>Request Close Air Support from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Map Click</t>", name _attackH6_pilot, typeOf _attackH6], "scripts\supportMenu\createTaskMap.sqf", [_attackH6_pilot, "Attack"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
        };
    };
};
// Transport Helicopter Mode
if (((_this select 3) select 0) == "transportHelis") then {
    _transportHelis = ((_this select 3) select 1);
    if ((count _transportHelis) >= 1) then {
        _tranH1 = call compile format["%1",((_transportHelis) select 0)];
        _tranH1_pilot = driver _tranH1;
        if (!isNull _tranH1_pilot) then {
            SUPMEN_tHeli1 = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Cursor Target</t>", name _tranH1_pilot, typeOf _tranH1], "scripts\supportMenu\createTask.sqf", [screenToWorld [0.5,0.5], _tranH1_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
            SUPMEN_tHeli1Map = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Map Click</t>", name _tranH1_pilot, typeOf _tranH1], "scripts\supportMenu\createTaskMap.sqf", [_tranH1_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
        };
    };
    if ((count _transportHelis) >= 2) then {
        _tranH2 = call compile format["%1",((_transportHelis) select 1)];
        _tranH2_pilot = driver _tranH2;
        if (!isNull _tranH2_pilot) then {
            SUPMEN_tHeli2 = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1's</t> %2 at Cursor Target</t>", name _tranH2_pilot, typeOf _tranH2], "scripts\supportMenu\createTask.sqf", [screenToWorld [0.5,0.5], _tranH2_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
            SUPMEN_tHeli2Map = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Map Click</t>", name _tranH2_pilot, typeOf _tranH2], "scripts\supportMenu\createTaskMap.sqf", [_tranH2_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
        };
    };
    if ((count _transportHelis) >= 3) then {
        _tranH3 = call compile format["%1",((_transportHelis) select 2)];
        _tranH3_pilot = driver _tranH3;
        if (!isNull _tranH3_pilot) then {
            SUPMEN_tHeli3 = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1</t> at Cursor Target</t>", name _tranH3_pilot], "scripts\supportMenu\createTask.sqf", [screenToWorld [0.5,0.5], _tranH3_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
            SUPMEN_tHeli3Map = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Map Click</t>", name _tranH3_pilot, typeOf _tranH3], "scripts\supportMenu\createTaskMap.sqf", [_tranH3_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
        };
    };
    if ((count _transportHelis) >= 4) then {
        _tranH4 = call compile format["%1",((_transportHelis) select 3)];
        _tranH4_pilot = driver _tranH4;
        if (!isNull _tranH4_pilot) then {
            SUPMEN_tHeli4 = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1</t> at Cursor Target</t>", name _tranH4_pilot], "scripts\supportMenu\createTask.sqf", [screenToWorld [0.5,0.5], _tranH4_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
            SUPMEN_tHeli4Map = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Map Click</t>", name _tranH4_pilot, typeOf _tranH3], "scripts\supportMenu\createTaskMap.sqf", [_tranH4_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
        };
    };
	if ((count _transportHelis) == 5) then {
        _tranH5 = call compile format["%1",((_transportHelis) select 4)];
        _tranH5_pilot = driver _tranH5;
        if (!isNull _tranH5_pilot) then {
            SUPMEN_tHeli5 = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1</t> at Cursor Target</t>", name _tranH5_pilot], "scripts\supportMenu\createTask.sqf", [screenToWorld [0.5,0.5], _tranH5_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
            SUPMEN_tHeli5Map = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Map Click</t>", name _tranH5_pilot, typeOf _tranH5], "scripts\supportMenu\createTaskMap.sqf", [_tranH5_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
        };
    };
	if ((count _transportHelis) == 6) then {
        _tranH6 = call compile format["%1",((_transportHelis) select 5)];
        _tranH6_pilot = driver _tranH6;
        if (!isNull _tranH6_pilot) then {
            SUPMEN_tHeli6 = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1</t> at Cursor Target</t>", name _tranH6_pilot], "scripts\supportMenu\createTask.sqf", [screenToWorld [0.5,0.5], _tranH6_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
            SUPMEN_tHeli6Map = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Map Click</t>", name _tranH6_pilot, typeOf _tranH6], "scripts\supportMenu\createTaskMap.sqf", [_tranH6_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
        };
    };
	if ((count _transportHelis) == 7) then {
        _tranH7 = call compile format["%1",((_transportHelis) select 6)];
        _tranH7_pilot = driver _tranH7;
        if (!isNull _tranH7_pilot) then {
            SUPMEN_tHeli7 = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1</t> at Cursor Target</t>", name _tranH7_pilot], "scripts\supportMenu\createTask.sqf", [screenToWorld [0.5,0.5], _tranH7_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
            SUPMEN_tHeli7Map = _caller addAction[format ["<t color='#F07422'>Request Transport from <t color='#ECF70C'>%1's</t> <t color='#DE1D1D'>%2</t> at Map Click</t>", name _tranH7_pilot, typeOf _tranH7], "scripts\supportMenu\createTaskMap.sqf", [_tranH7_pilot, "Transport"], -100, false, false, "", "leader group _this == _this && _target == vehicle _this || leader group _this == _this && _target == _this"];
        };
    };
};
