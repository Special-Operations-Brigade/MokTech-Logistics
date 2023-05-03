#include "script_component.hpp"

/*
Function: mti_logistics_fnc_aircraft_onUnload

Description:
    Handles resetting variables and systems when the aircraft logibox menu gets closed.

Arguments:
    _display - Display reference
    _exitCode - Exit code thrown by the display

Return Value:
    None

Example:
    (begin example)
        [] call mti_logistics_fnc_aircraft_onUnload;
    (end)

Author:
	Mokka
*/

disableSerialization;

params ["_display", "_exitCode"];

private _logibox = uiNamespace getVariable QGVAR(logibox);
uiNamespace setVariable [QGVAR(logibox),nil];

_logibox setVariable [QGVAR(owner),nil,true];
_logibox setVariable [QGVAR(display),nil];
_logibox setVariable [QGVAR(fnc_dialogPFH),nil];

TRACE_CHAT_2("unload vars",_logibox,_display);

switch (_exitCode) do {
    case 1: { // OK
        // ctrls
        private _selectedVehicle = uiNamespace getVariable QGVAR(selectedVehicle);
        private _selectedSkin = uiNamespace getVariable QGVAR(selectedSkin);
        private _configureLoadout = uiNamespace getVariable QGVAR(configureLoadout);

        TRACE_CHAT_3("data",_selectedVehicle,_selectedSkin,_configureLoadout);

        [1,_logibox,_selectedVehicle,_selectedSkin,_configureLoadout,ACE_player] remoteExecCall [QFUNC(spawnVehicle),2,false];
    };
    case 2: { // Cancel
        //
    };
    default { };
};
