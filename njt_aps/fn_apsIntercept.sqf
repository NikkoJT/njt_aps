// APS - INTERCEPTOR MODULE
// This function determines if a nearby projectile is a threat, and if so, destroys it and creates appropriate effects.

params ["_projectile","_vehicle"];

// Check if the projectile is likely to hit the vehicle
if !([_projectile,_vehicle] call njt_fnc_apsIntersectCheck) exitWith {};

// Find out who did it so we can blame them
private _shooterVehicle = (getShotParents _projectile) select 0;
private _shooter = gunner _shooterVehicle;

// If we've accidentally detected our own projectile, ignore it
if (_shooterVehicle == _vehicle) exitWith {};

_projectilePos = getPosATL _projectile;
// If the projectile has already been handled, skip this
if (isNull _projectile) exitWith {};

// Don't touch me!
deleteVehicle _projectile;

// Create effects and warnings
private _flare = createVehicle ["CMFlareAmmo",_projectilePos,[],0,"CAN_COLLIDE"];
private _flareDir = (getPosASL _flare) vectorFromTo (getPosASL _vehicle);
_flare setVelocity (_flareDir vectorMultiply 40);

// Requires F3 FCS module!
["APS DEFEAT",3] remoteExec ["f_fnc_fcsLocalWarning",_shooter];
[["vtolAlarm",2]] remoteExec ["playSound",crew _vehicle];
["APS ACTIVATION",3] remoteExec ["f_fnc_fcsLocalWarning",crew _vehicle];
[_projectilePos,_vehicle] remoteExec ["njt_fnc_apsLocalEffects"];
playSound3D ["A3\Sounds_F\arsenal\explosives\rockets\Rocket_closeExp_02.wss",_vehicle,false,getPosASL _vehicle,1,1,150];
playSound3D ["A3\Sounds_F\arsenal\explosives\rockets\RocketHeavy_tailMeadows_01.wss",_vehicle,false,getPosASL _vehicle,1,1,150];

// APS aren't completely safe...
private _fxgrenade = createVehicle ["BombCluster_01_UXO1_Ammo_F",_projectilePos,[],0,"CAN_COLLIDE"];
triggerAmmo _fxgrenade;

// grace period during which any additional shots will still be intercepted
uisleep 2;

// Now we're on cooldown (but don't do this if we're a secondary activation, let the first activation take care of it)
_APScooldown = _vehicle getVariable ["njt_var_apsCooldown",false];
if !_APScooldown then {
	_vehicle setVariable ["njt_var_apsCooldown",true,true];
	if (njt_var_APScooldownTimer > 0) then {
		uisleep njt_var_APScooldownTimer;
		_vehicle setVariable ["njt_var_apsCooldown",false,true];
		[["beep",2]] remoteExec ["playSound",crew _vehicle];
		["APS ONLINE",3] remoteExec ["f_fnc_fcsLocalWarning",crew _vehicle];
	};
};