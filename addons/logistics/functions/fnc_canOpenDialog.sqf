#include "script_component.hpp"

/*
Function: mti_logistics_fnc_canOpenDialog

Description:
    Checks whether player can currently open the logibox menu.

Arguments:
    _logibox - LogiBox reference

Return Value:
    canOpenDialog?

Example:
    (begin example)
        [] call mti_logistics_fnc_canOpenDialog;
    (end)

Author:
	Mokka
*/

params ["_logibox"];

private _isSlingload = _logibox getVariable [QGVAR(slingload),false];

!(_isSlingload)
