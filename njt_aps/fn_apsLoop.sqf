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

// Regularly check for all vehicles' APS status and remove/add from global array
if isServer then {
	if (isNil "njt_var_apsStatusLoop") then {
		njt_var_apsStatusLoop = 0 spawn {
			while {true} do {
				{
					private _apsEnabled = _x getVariable ["njt_var_apsEnabled",false];
					private _apsCooldown = _x getVariable ["njt_var_apsCooldown",false];
					if (_apsEnabled && !_apsCooldown) then {
						njt_var_apsActiveVehicles pushbackUnique _x;
					} else {
						njt_var_apsActiveVehicles = njt_var_apsActiveVehicles - [_x];
					};
				} forEach entities [["LandVehicle"],[],false,true];
				publicVariable "njt_var_apsActiveVehicles";
				sleep 1;
			};
		};
	};
};