// APS - PROJECTILE DETECTOR MODULE
// This function finds and reports nearby projectiles of valid types.
params ["_vehicle"];
private _projectiles = [];
{
	_projectiles = _projectiles + (_vehicle nearObjects [_x,50]);
} forEach ["ShellBase","RocketBase","MissileBase"];
_projectiles