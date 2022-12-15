// APS - OVERWATCH LOOP MODULE
// This function detects when there are nearby important projectiles, and activates the interceptor if there are.
params ["_vehicle"];

// This function has been run so record that.
_vehicle setVariable ["njt_var_apsEnabled",true];

// If the APS is manually disabled or the vehicle is destroyed, exit
while {alive _vehicle && (_vehicle getVariable ["njt_var_apsEnabled",false])} do {
	// If this isn't currently our vehicle, it's not our problem
	if (!local _vehicle) then { continue };
	// If APS is on cooldown, skip this
	private _APScooldown = _vehicle getVariable ["njt_var_apsCooldown",false];
	if _APScooldown then { continue };
	
	// Detect nearby projectiles
	private _projectiles = [_vehicle] call njt_fnc_apsNearProjectiles;
	if (count _projectiles > 0) then {
		{
			// If the projectile hasn't already been handled, activate interceptor
			if !(_x getVariable ["njt_var_apsChecked",false]) then {
				[_x,_vehicle] spawn njt_fnc_apsIntercept;
			};
		} forEach _projectiles;
	};
	uisleep 0.001;
};