#include "script_component.hpp"

/*
Function: mti_logistics_fnc_logibox_checkArea

Description:
    Checks the helper area next to the logibox, if anything is blocking the output.

Arguments:
    _logibox - LogiBox reference
    _positions - Helper centre position and bounding box lengths
    _helper - The helper visual object

Return Value:
    If area is clear

Example:
    (begin example)
        [] call mti_logistics_fnc_logibox_checkArea;
    (end)

Author:
	Mokka
*/

params ["_logibox", "_positions","_helper"];
_positions params ["_centrePos", "_bbX", "_bbY", "_bbZ", "_diag"];

private _clear = false;

private _slingload = _logibox getVariable [QGVAR(slingload),false];
if (_slingload) exitWith {
    _helper setObjectTextureGlobal ["helper", ""];
    _logibox setVariable [QGVAR(outputClear),false,true];

    false
};

_centrePos = _logibox modelToWorld _centrePos;

private _nearObjects = nearestObjects [_centrePos,["AllVehicles","CAManBase","thingx"],_diag];
private _intersects = _nearObjects inAreaArray [_centrePos,_bbX,_bbY,getDir _logibox,true,1.2 * _bbZ];

TRACE_3("area check",typeof _logibox,_nearObjects,_intersects);

if ((count _intersects) isEqualTo 0) then {
    // all clear
    _logibox setVariable [QGVAR(outputClear),true,true];
    _helper setObjectTextureGlobal ["helper", COLOUR_LOGIBOX_AREA_CLEAR];
    _clear = true;
} else {
    // not all clear
    _logibox setVariable [QGVAR(outputClear),false,true];
    _helper setObjectTextureGlobal ["helper", COLOUR_LOGIBOX_AREA_BLOCKED];
};

(_clear)
