// APS - MAINTENANCE LOOP MODULE
// This function performs maintenance tasks on vehicles.
params ["_vehicle"];

// Cleanup: regularly empty the vehicle's tracked objects array of old junk
[_vehicle] spawn {
	params ["_vehicle"];
	while {alive _vehicle} do {
		private _handledProjectiles = _vehicle getVariable ["njt_var_apsTracked",[]];
		_handledProjectiles = _handledProjectiles - [objNull];
		_vehicle setVariable ["njt_var_apsTracked",_handledProjectiles];
		
		sleep 10;
	};
};

// Regularly check for the vehicle's APS status and remove/add from global array
[_vehicle] spawn {
	params ["_vehicle"];
	while {alive _vehicle} do {
		private _apsEnabled = _vehicle getVariable ["njt_var_apsEnabled",false];
		private _apsCooldown = _vehicle getVariable ["njt_var_apsCooldown",false];
		if (_apsEnabled && !_apsCooldown) then {
			njt_var_apsActiveVehicles pushback _vehicle;
		} else {
			njt_var_apsActiveVehicles = njt_var_apsActiveVehicles - [_vehicle];
		};
		sleep 1;
	};
};