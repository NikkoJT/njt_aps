params ["_vehicle","_cooldown","_allowReload"];

// Active Protection System Module
njt_var_apsCooldownTimer = _cooldown;

// Check if APS has already been set up, and subsequently turned off, on this vehicle
private _isAllowed = _vehicle getVariable ["njt_var_apsEnabled",true];
if (_isAllowed) then {

	// This function has been run so record that.
	if (local _vehicle) then {_vehicle setVariable ["njt_var_apsEnabled",true,true];};
	[_vehicle] spawn {
		sleep 1;
		// Initialise APS
		[_this#0] spawn njt_fnc_apsLoop;
	};
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
		{
			params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
			playSound3D ["\a3\Ui_f\data\Sound\CfgCutscenes\repair.wss",_caller];
		}, // Code on tick
		{ 
			params ["_target", "_caller", "_actionId", "_arguments"];
			_target setVariable ["njt_var_apsCooldown",false,true];
			playSound3D ["A3\Sounds_F\arsenal\weapons\LongRangeRifles\DMR_01_Rahim\DMR_01_reload.wss",_caller];
			["APS READY",2,1] remoteExec ["f_fnc_fcsLocalWarning",crew _target];
			[["beep",2]] remoteExec ["playSound",crew _target];
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
private _apsArmAction = _vehicle addAction [
	"Arm APS",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		_target setVariable ["njt_var_apsEnabled",true,true];
		private _isReloaded = _target getVariable ["njt_var_apsCooldown",false];
		private _text = format ["APS ARM%1",[""," - NO CHARGE"] select _isReloaded];
		[_text,2,1] remoteExec ["f_fnc_fcsLocalWarning",crew _target];
		[["beep",2]] remoteExec ["playSound",crew _target];
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

private _apsDisarmAction = _vehicle addAction [
	"Disarm APS",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		_target setVariable ["njt_var_apsEnabled",false,true];
		["APS DISARM",2,1] remoteExec ["f_fnc_fcsLocalWarning",crew _target];
		[["beep",2]] remoteExec ["playSound",crew _target];
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

// Add briefing
if (isNil "njt_var_aps_briefingDone") then {
	[_allowReload] call njt_fnc_apsBriefing;
};