params ["_vehicle","_cooldown","_allowReload"];

// Active Protection System Module
njt_var_apsCooldownTimer = _cooldown;

// Check if APS has already been set up, and subsequently turned off, on this vehicle
private _isAllowed = _vehicle getVariable ["njt_var_apsEnabled",true];
if (_isAllowed) then {

	// This function has been run so record that.
	if (local _vehicle) then {_vehicle setVariable ["njt_var_apsEnabled",true,true];
	sleep 1;
	// Initialise APS
	[_vehicle] spawn njt_fnc_apsLoop;
};

// If reloading is allowed, add an action to let players do that
if _allowReload then {
	private _apsReloadAction = [
		_vehicle, // Target
		"Reload APS", // Title
		"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", // Idle icon
		"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", // Progress icon
		"(_this getUnitTrait 'engineer') && {(_target getVariable ['njt_var_apsCooldown',false]) && (vehicle _this == _this) && (alive _target) && (_this distance _target < 5)}", // Condition to show
		"(_this getUnitTrait 'engineer') && {(_target getVariable ['njt_var_apsCooldown',false]) && (vehicle _this == _this) && (alive _target) && (_this distance _target < 5)}", // Condition to progress
		{}, // Code on start
		{}, // Code on tick
		{ 
			params ["_target", "_caller", "_actionId", "_arguments"];
			_target setVariable ["njt_var_apsCooldown",false,true];
		}, // Code on completed
		{}, // Code on interrupt
		[], // Arguments to pass
		20, // Duration
		1, // Priority
		false, // Remove on completion
		false, // Show when unconscious
		true // Show on screen
	] call BIS_fnc_holdActionAdd;
	
	_vehicle setVariable ["njt_apsReloadAction",_apsReloadAction];
};

// Add action to toggle APS
private _apsArmAction = [
	"Arm APS",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		_vehicle setVariable ["njt_var_apsEnabled",true,true];
		_target spawn {
			sleep 1;
			[_this] remoteExec ["njt_fnc_apsLoop",0,true];
		};
	},
	nil,	
	-1,	
	false,	
	true,	
	"",	
	"(_this == commander _target) && {!(_target getVariable ['njt_var_apsEnabled',false])}", 
	0,		
	false,	
	"",	
	""	
];
_vehicle setVariable ["njt_apsArmAction",_apsArmAction];

private _apsDisarmAction = [
	"Disarm APS",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		_vehicle setVariable ["njt_var_apsEnabled",false,true];
	},
	nil,	
	-1,	
	false,	
	true,	
	"",	
	"(_this == commander _target) && {(_target getVariable ['njt_var_apsEnabled',false])}", 
	0,		
	false,	
	"",	
	""	
];
_vehicle setVariable ["njt_apsDisarmAction",_apsDisarmAction];