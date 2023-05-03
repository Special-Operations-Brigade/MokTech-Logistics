#include "script_component.hpp"

/*
Function: mti_logistics_fnc_openDialog

Description:
    Wrapper function to open desired logibox dialog.

Arguments:
    _logibox - Logibox reference

Return Value:
    None

Example:
    (begin example)
        [] call mti_logistics_fnc_openDialog;
    (end)

Author:
	Mokka
*/
disableSerialization;

params ["_logibox"];

TRACE_CHAT_1("params",_logibox);

uiNamespace setVariable [QGVAR(logibox),_logibox];

private _dialog = GET_TEXT(configFile >> "CfgVehicles" >> (typeOf _logibox) >> QGVAR(dialog),"");

if (_dialog isEqualTo "") exitWith { WARNING_1("no dialog set up for logibox %1",typeOf _logibox); };


if (_dialog isEqualTo QEGVAR(logistics_cratefiller,dialog)) exitWith {
    [[_logibox]] call EFUNC(logistics_cratefiller,openDialog);
};

private _owner = _logibox getVariable QGVAR(owner);
if (isNil "_owner") then {
    _logibox setVariable [QGVAR(owner),ACE_Player,true];
};

createDialog [_dialog, true];
