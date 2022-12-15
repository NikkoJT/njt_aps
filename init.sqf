// Active Protection System Module
// Specify cooldown (0 for single-use system)
njt_var_apsCooldownTimer = 90;
// Initialise APS
{
	[_x] spawn njt_fnc_apsLoop;
// Insert vehicles here
} forEach [];