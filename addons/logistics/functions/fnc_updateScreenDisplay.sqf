#include "script_component.hpp"
#include "..\ui\idDefines.hpp"
/*
Function: mti_logistics_fnc_updateScreenDisplay

Description:
    Updates the screen UI of the given logibox

Arguments:
    _logibox - The logibox
	_display - The screen display

Return Value:
    None

Example:
    (begin example)
        [] call mti_logistics_fnc_updateScreenDisplay;
    (end)

Author:
	Mokka
*/

params ["_logibox","_display"];

TRACE_2("params",_logibox,_display);

// get ctrls
private _ctrlStatusEdit = _display displayCtrl IDC_RSCMTILOGIBOX_SCREEN_TEXTLOGIBOXSTATUSEDIT;
private _ctrlSpawning = _display displayCtrl IDC_RSCMTILOGIBOX_SCREEN_TEXTSPAWNING;
private _ctrlSpawningEdit = _display displayCtrl IDC_RSCMTILOGIBOX_SCREEN_TEXTSPAWNINGEDIT;
private _ctrlProgress = _display displayCtrl IDC_RSCMTILOGIMENU_PROGRESSOPERATIONPROGRESS;

TRACE_4("ctrls",_ctrlStatusEdit,_ctrlSpawning,_ctrlSpawningEdit,_ctrlProgress);

// get other vars
private _inProgress = _logibox getVariable [QGVAR(inProgress),false];
private _inProgressTime = _logibox getVariable [QGVAR(inProgressTime),[0,0]];
private _inProgressVehicle = _logibox getVariable [QGVAR(inProgressVehicle),""];
private _paused = _logibox getVariable [QGVAR(paused),false];
private _coolDown = _logibox getVariable [QGVAR(cooldown),0];
private _owner = _logibox getVariable [QGVAR(owner),ACE_Player];
private _outputClear = _logibox getVariable [QGVAR(outputClear),false];

TRACE_7("logibox vars",_inProgress,_inProgressTime,_inProgressVehicle,_paused,_coolDown,_owner,_outputClear);

private _textStatus = "Ready";
_ctrlStatusEdit ctrlSetTextColor [COLOUR_LOGIBOX_GREEN_RGBA];

if (_inProgress) exitWith {
	_ctrlSpawning ctrlShow true;
	_ctrlSpawningEdit ctrlShow true;
	_ctrlProgress ctrlShow true;

	TRACE_CHAT_1("in progress",_logibox);

	_textStatus = "Operation in Progress";
	if (_paused) then {
		if !(_outputClear) then {
			_textStatus = "Output Area Blocked";
			_ctrlStatusEdit ctrlSetTextColor [COLOUR_LOGIBOX_RED_RGBA];
		} else {
			_textStatus = "Operation Paused";
			_ctrlStatusEdit ctrlSetTextColor [COLOUR_LOGIBOX_YELLOW_RGBA];
		};
	};
	_ctrlStatusEdit ctrlSetText _textStatus;
	TRACE_CHAT_1("status",_textStatus);

	private _vehicleName = getText (configFile >> "CfgVehicles" >> _inProgressVehicle >> "displayName");
	_ctrlSpawningEdit ctrlSetText _vehicleName;
	TRACE_CHAT_1("spawning",_vehicleName);

	private _progress = linearConversion [
        _inProgressTime select 0,
        _inProgressTime select 1,
        CBA_missionTime,
        0, 1, false
    ];
	_ctrlProgress progressSetPosition _progress;
	TRACE_CHAT_1("progress",_progress);

	displayUpdate _display;
};

_ctrlSpawning ctrlShow false;
_ctrlSpawningEdit ctrlShow false;
_ctrlProgress ctrlShow false;

// output area
if !(_outputClear) then {
    _textStatus = "Output Area Blocked";
    _ctrlStatusEdit ctrlSetTextColor [COLOUR_LOGIBOX_RED_RGBA];
};

// on cooldown
if (_coolDown > CBA_missionTime) then {
    _textStatus = format ["On Cooldown: %1s",round(_coolDown - CBA_missionTime)];
    _ctrlStatusEdit ctrlSetTextColor [COLOUR_LOGIBOX_YELLOW_RGBA];
};

// logibox status
if (_owner isNotEqualTo ACE_player) then {
    _textStatus = "In Use";
    _ctrlStatusEdit ctrlSetTextColor [COLOUR_LOGIBOX_YELLOW_RGBA];
};

_ctrlStatusEdit ctrlSetText _textStatus;

displayUpdate _display;
