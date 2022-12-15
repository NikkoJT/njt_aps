// APS - OVERWATCH LOOP MODULE
// This function detects when there are nearby important projectiles, and activates the interceptor if there are.
params ["_vehicle"];

// Cleanup: regularly empty the vehicle's tracked objects array of old junk
[_vehicle] spawn {
	params ["_vehicle"];
	while {alive _vehicle && (_vehicle getVariable ["njt_var_apsEnabled",false])} do {
		private _handledProjectiles = _vehicle getVariable ["njt_var_apsTracked",[]];
		_handledProjectiles = _handledProjectiles - [objNull];
		_vehicle setVariable ["njt_var_apsTracked",_handledProjectiles];
		
		sleep 10;
	};
};

// If the APS is manually disabled or the vehicle is destroyed, exit
while {alive _vehicle && (_vehicle getVariable ["njt_var_apsEnabled",false])} do {
	// If this isn't currently our vehicle, it's not our problem
	if (!local _vehicle) then { sleep 1; continue };
	// If APS is on cooldown, skip this
	private _APScooldown = _vehicle getVariable ["njt_var_apsCooldown",false];
	if _APScooldown then { sleep 1; continue };
	
	// Detect nearby projectiles
	private _projectiles = [_vehicle] call njt_fnc_apsNearProjectiles;
	if (count _projectiles > 0) then {
		{
			// If the projectile hasn't already been handled, activate interceptor
			private _isHandled = (_x in (_vehicle getVariable ["njt_var_apsTracked",[]]));
			if !(_isHandled) then {
				[_x,_vehicle] spawn njt_fnc_apsIntercept;
			};
		} forEach _projectiles;
	};
	uisleep 0.001;
};