// =======================================================================================================
//
//		downloadData.sqf - by T-800a - 12.10.2013
//
// =======================================================================================================

if ( isNil "T8_pubVarInUse" ) then { T8_pubVarInUse = false; };


T8_varFileSize = (88354 + (random 35237));  								// Filesize ... smaller files will take shorter time to download!

T8_varTLine01 = "Download aborted!";				// download aborted - Download abgebrochen!
T8_varTLine02 = "Download already in progress by someone else!";			// download already in progress by someone else - Wird bereits ausgefuehrt!
T8_varTLine03 = "Download started!";					// download started - Download gestarted!
T8_varTLine04 = "Download finished!";				// download finished - Download abgeschlossen
T8_varTLine05 = "##  Download File Data  ##";				// line for the addaction

T8_varDiagAbort = false;
T8_varDownSucce = false;

T8_fnc_abortActionLaptop =
{
	if ( T8_varDownSucce ) exitWith {};
	private "_downloadAborded";
	player sideChat T8_varTLine01; 
	_downloadAborded = 
		[
		"Download of Enemy File Data aborted!"
		
		];
	hqSideChat = _downloadAborded call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
				
	T8_varDiagAbort = true;
};


T8_fnc_addActionLaptop =
{
	_this addAction [ T8_varTLine05, "call T8_fnc_ActionLaptop", nil, 0.1, false ];
};


T8_fnc_removeActionLaptop =
{
	_laptop = _this select 0;
	_id = _this select 1;
	_laptop removeAction _id;
};


T8_fnc_ActionLaptop =
{
	private [ "_laptop", "_caller", "_id", "_downloadStarted" ];
	_laptop = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
		
		
	[ _laptop, _id ] spawn 
	{
		private [ "_laptop", "_id", "_newFile", "_dlRate", "_downloadFinish", "_downloadStarted", "_downloadFailed", "_downloadConnecting", "_downloadConnected", "_downloadComplete" ];
		_laptop = _this select 0;
		_id = _this select 1;
		_newFile = 0;
		
		_downloadFinish = 
		[
		"Download of Enemy File Data complete!"
		
		];
		_downloadStarted = 
		[
		"Download of Enemy File Data - stand by!"
		
		];
		_downloadConnecting = 
		[
		"Connect to File Data Server...."
		];
		_downloadConnected = 
		[
		"Connection to File Data Server accomplished."
		];
		_downloadFailed = 
		[
		"Connection to File Data Server failed. Please try again."
		];
		
		if(random 1 >= 0.35) then {

		player sideChat T8_varTLine03;
		hqSideChat = _downloadStarted call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		sleep (2 + (random 5));
		
		createDialog "T8_DataDownloadDialog";
		
		sleep 0.5;
		ctrlSetText [ 8001, "Connecting ..." ];
		hqSideChat = _downloadConnecting call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	
		sleep (2 + (random 5));
		ctrlSetText [ 8001, "Connected:" ];		
		hqSideChat = _downloadConnected call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		ctrlSetText [ 8003, format [ "%1 kb", T8_varFileSize ] ];		
		ctrlSetText [ 8004, format [ "%1 kb", _newFile ] ];	
		
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		
		} else {
		
		T8_varDiagAbort = true;
		
		T8_pubVarInUse = false;
		publicVariable "T8_pubVarInUse";
		
		hqSideChat = _downloadStarted call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		sleep (2 + (random 5));
		hqSideChat = _downloadConnecting call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		sleep (2 + (random 5));
		hqSideChat = _downloadFailed call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		
		};
		
		while { !T8_varDiagAbort } do
		{
			_dlRate = 450 + random 280;
			_newFile = _newFile + _dlRate;

			if ( _newFile > T8_varFileSize ) then 
			{
				_dlRate = 0;		
				_newFile = T8_varFileSize;
				ctrlSetText [ 8001, "Download finished!" ];	
				hqSideChat = _downloadFinish call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
				T8_varDiagAbort = true;
				player sideChat T8_varTLine04;
				T8_varDownSucce = true;		
				sleep 1;
				
				_downloadComplete =
			"<t align='center'><t size='2.2'>Download Complete</t><br/><t size='1.5' color='#00B2EE'>File Data Saved</t><br/>____________________<br/>Fantastic job, lads!<br/><br/>Initialize self destruction of OS. Stand by.</t>";
			GlobalHint = _downloadComplete; publicVariable "GlobalHint"; hint parseText _downloadComplete;

			sleep 15;
			deleteVehicle sideObj;
				// [ [ _laptop, _id ], "T8_fnc_removeActionLaptop", true, true] spawn BIS_fnc_MP;
			};
			
			ctrlSetText [ 8002, format [ "%1 kb/t", _dlRate ] ];		
			ctrlSetText [ 8004, format [ "%1 kb", _newFile ] ];				
			
			sleep 0.2;
			sideMissionUp = true;
			publicVariable "sideMissionUp";
		};
			
		T8_varDiagAbort = false;
		
		T8_pubVarInUse = false;
		publicVariable "T8_pubVarInUse";
	};
};

[player] call T8_fnc_ActionLaptop;