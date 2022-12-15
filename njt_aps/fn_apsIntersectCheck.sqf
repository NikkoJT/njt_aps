// APS - INTERSECTION MODULE
// This function determines if a projectile is on course to hit the protected vehicle. Roughly.
params ["_projectile","_vehicle",["_checkCount",0]];
private _return = false;

// Skip if the projectile is already intercepted
if (isNull _projectile) exitWith {systemChat "APS PROJ IS NULL"; _return};
// Skip if this would exceed the max number of checks
if (_checkCount >= 3) exitWith {systemChat "APS TOO MANY CHECKS"; _return};

// Draw a line based on where the projectile is going
private _startPos = getPosASL _projectile;
private _endPos = _startPos vectorAdd (velocity _projectile vectorMultiply 0.5);

// If it intersects the protected vehile, report that
private _intersects = lineIntersectsSurfaces [_startPos,_endPos,_projectile,objNull,true,1,"FIRE"];
if (count _intersects > 0) then {
	private _intersectObj = (_intersects select 0) select 3;
	if (_intersectObj == _vehicle) then {
		_return = true;
	} else {
		_checkCount = (_checkCount + 1);
		uisleep 0.1;
		_return = [_projectile,_vehicle,_checkCount] call njt_fnc_apsIntersectCheck;
	};
};
// Report back
systemChat "APS INTERSECT RUN";
_return
