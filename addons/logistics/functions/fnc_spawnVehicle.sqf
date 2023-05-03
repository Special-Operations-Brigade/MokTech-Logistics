#include "script_component.hpp"

/*
Function: mti_logistics_fnc_spawnVehicle

Description:
    Server-side spawning the vehicle and setting various timers on the logibox.

Arguments:
    _mode - 1 for aircraft, 2 for vehicles
    _logibox - The logibox
    _selectedVehicle - Vehicle to spawn
    _selectedSkin - Skin that was selected, "" if using default
    _configureLoadout - If vehicle loadout should be adjusted after spawning (aircraft only)
    _player - Player that initiated the spawn

Return Value:
    None

Example:
    (begin example)
        [] call mti_logistics_fnc_spawnVehicle;
    (end)

Author:
	Mokka
*/

params ["_mode","_logibox","_selectedVehicle","_selectedSkin","_configureLoadout","_player"];
TRACE_CHAT_6("spawn params",_mode,_logibox,_selectedVehicle,_selectedSkin,_configureLoadout,_player);

// setup

// begin spawn
_logibox animateSource ["drawer_translation",1,0.5];

// initiate timer
_logibox setVariable [QGVAR(inProgress),true,true];
_logibox setVariable [QGVAR(inProgressTime),[CBA_missionTime,CBA_missionTime + GVAR(spawnDuration)],true];
_logibox setVariable [QGVAR(inProgressVehicle),_selectedVehicle,true];
_logibox setVariable [QGVAR(paused),false,true];

// PFH
[
    {
        params ["_args","_handle"];
        _args params ["_mode","_logibox","_selectedVehicle","_selectedSkin","_configureLoadout","_player"];

        private _paused = _logibox getVariable QGVAR(paused);
        private _progressTime = _logibox getVariable QGVAR(inProgressTime);
        private _outputClear = _logibox getVariable QGVAR(outputClear);

        TRACE_CHAT_3("pfh vars",_paused,_progressTime,_outputClear);

        if (!(_paused) && {CBA_missionTime >= (_progressTime select 1)}) exitWith {
            _args call FUNC(spawnVehicleComplete);
            [_handle] call CBA_fnc_removePerFrameHandler;
        };

        if !(_paused || _outputClear) exitWith {
            _logibox setVariable [QGVAR(paused),true,true];
        };

        if (_paused && _outputClear) exitWith {
            _logibox setVariable [QGVAR(paused),false,true];
        };

        if (_paused) exitWith {
            _logibox setVariable [QGVAR(inProgressTime),[(_progressTime select 0) + 1, (_progressTime select 1) + 1],true];
        };
    },
    1,
    _this
] call CBA_fnc_addPerFrameHandler;

