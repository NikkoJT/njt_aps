// APS - INTERSECTION MODULE
// This function determines if a projectile is on course to hit the protected vehicle. Roughly.
params ["_projectile","_vehicle"];
private _return = false;

// Skip if we've previously checked this one - hopefully it won't change course!
if ((_projectile getVariable ["njt_var_apsChecked",false]) or (isNull _projectile)) exitWith {_return};
// Draw a line based on where the projectile is going
private _startPos = getPosASL _projectile;
private _endPos = _startPos vectorAdd (velocity _projectile vectorMultiply 0.5);
// If it intersects the protected vehile, report that
private _intersects = lineIntersectsSurfaces [_startPos,_endPos,_projectile,objNull,true,1,"FIRE"];
if (count _intersects > 0) then {
	private _intersectObj = (_intersects select 0) select 3;
	if (_intersectObj == _vehicle) then {
		_return = true;
	};
};
_projectile setVariable ["njt_var_apsChecked",true];
// Report back
_return