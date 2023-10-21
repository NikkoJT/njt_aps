// APS module
// Parameters: vehicle, cooldown (0 for single-use), allow manual reload
// Default configuration: the system will activate once before requiring a manual reload.
{
	[_x,0,true] call njt_fnc_apsInit;
} forEach [];
