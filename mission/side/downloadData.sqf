// =======================================================================================================
//
//		downloadData.sqf - by T-800a - 12.10.2013
//
// =======================================================================================================

if ( isNil "T8_pubVarInUse" ) then { T8_pubVarInUse = false; };


T8_varFileSize = (288354 + (random 235237));  	  								// Filesize ... smaller files will take shorter time to download!

T8_varTLine01 = "Download aborted!";				// download aborted - Download abgebrochen!
T8_varTLine02 = "Download already in progress by someone else!";			// download already in progress by someone else - Wird bereits ausgefuehrt!
T8_varTLine03 = "Download started!";					// download started - Download gestarted!
T8_varTLine04 = "Download finished!";				// download finished - Download abgeschlossen
T8_varTLine05 = "##  Download File Data  ##";				// line for the addaction

T8_varDiagAbort = false;
T8_varDownSucce = false;

_downloadComplete =
			"<t align='center'><t size='2.2'>Download Complete</t><br/><t size='1.5' color='#00B2EE'>File Data Saved</t><br/>____________________<br/>Fantastic job, lads!<br/><br/>Initialize self destruction of OS. Stand by.</t>";
			

T8_fnc_abortActionLaptop =
{
	if ( T8_varDownSucce ) exitWith {};

	player sideChat T8_varTLine01; 
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
	private [ "_laptop", "_caller", "_id", "_downloadComplete" ];
	_laptop = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	
	if ( T8_pubVarInUse ) exitWith { player sideChat T8_varTLine02;  };
	
	player sideChat T8_varTLine03;
	
	T8_pubVarInUse = true;
	publicVariable "T8_pubVarInUse";
		
	[ _laptop, _id ] spawn 
	{
		private [ "_laptop", "_id", "_newFile", "_dlRate" ];
		_laptop = _this select 0;
		_id = _this select 1;
		_newFile = 0;
		
		createDialog "T8_DataDownloadDialog";
		
		sleep 0.5;
		ctrlSetText [ 8001, "Connecting ..." ];
		sleep 0.5;
		ctrlSetText [ 8001, "Connected:" ];		
		ctrlSetText [ 8003, format [ "%1 kb", T8_varFileSize ] ];		
		ctrlSetText [ 8004, format [ "%1 kb", _newFile ] ];		
		
		while { !T8_varDiagAbort } do
		{
			_dlRate = 450 + random 280;
			_newFile = _newFile + _dlRate;

			if ( _newFile > T8_varFileSize ) then 
			{
				_dlRate = 0;		
				_newFile = T8_varFileSize;
				ctrlSetText [ 8001, "Download finished!" ];	
				T8_varDiagAbort = true;
				player sideChat T8_varTLine04;
				T8_varDownSucce = true;		
			
			GlobalHint = _downloadComplete; publicVariable "GlobalHint"; hint parseText _downloadComplete;
			
			sleep 15;
			deleteVehicle sideObj;
				// [ [ _laptop, _id ], "T8_fnc_removeActionLaptop", true, true] spawn BIS_fnc_MP;
			};
			
			ctrlSetText [ 8002, format [ "%1 kb/t", _dlRate ] ];		
			ctrlSetText [ 8004, format [ "%1 kb", _newFile ] ];				
			
			sleep 0.2;
		};
			
		T8_varDiagAbort = false;
		
		T8_pubVarInUse = false;
		publicVariable "T8_pubVarInUse";
		
	};
};

downloadDataDONE = true;
