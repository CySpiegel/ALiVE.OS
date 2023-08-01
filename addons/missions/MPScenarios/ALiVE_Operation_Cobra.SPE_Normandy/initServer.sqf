/* 
* Filename:
* initServer.sqf
*
* Description:
* Executed only on server when mission is started.
* 
* Creation date: 05/04/2021
* 
* */
// ====================================================================================
private ["_isMHQDeployed"];

if (isDedicated) then  { 
	disableRemoteSensors true; 
};

[] spawn {
     while {true} do {
          {
               if (!isNull (getAssignedCuratorUnit _x)) then {
                    _x addCuratorEditableObjects [allUnits + vehicles,true];
               };
          } count allCurators;
          sleep 10;
     };
};

Jersey setGroupId ["Jersey Squad"];

[US_AMMOBOX,["Arsenal", {["Open",true] spawn SPE_Arsenal_fnc_arsenal; }]] remoteExec ["addAction"];
[US_AMMOBOX_1,["Arsenal", {["Open",true] spawn SPE_Arsenal_fnc_arsenal; }]] remoteExec ["addAction"];
[US_AMMOBOX_2,["Arsenal", {["Open",true] spawn SPE_Arsenal_fnc_arsenal; }]] remoteExec ["addAction"];


SPE_CadetMode = false;
SPE_HardcoreMode = true;




// Returns array of dates for given year when moon is at its fullest
fnc_fullMoonDates =
{
	private _year = param [0, 2035];
	private ["_date", "_phase", "_fullMoonDate"];
	private _fullMoonPhase = 1;
	private _waxing = false;
	private _fullMoonDates = [];
	for "_i" from dateToNumber [_year, 1, 1, 0, 0] to dateToNumber [_year, 12, 31, 23, 59] step 1 / 365 do
	{
		_date = numberToDate [_year, _i];
		_phase = moonPhase _date;

		call
		{
			if (_phase > _fullMoonPhase) exitWith
			{
				_waxing = true;
				_fullMoonDate = _date;
			};

			if (_waxing) exitWith
			{
				_waxing = false;
				_fullMoonDates pushBack _fullMoonDate;
			};
		};

		_fullMoonPhase = _phase;
	};

	_fullMoonDates;
};

//set random full moon date in year 1970
setDate selectRandom (1944 call fnc_fullMoonDates); 
skipTime 8;
0 setOvercast 0.1;  
0 setRain 0;  
0 setfog 0.01; 
forceWeatherChange;





    




