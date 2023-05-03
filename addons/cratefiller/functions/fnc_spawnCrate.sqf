#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    mti_logistics_cratefiller_fnc_spawnCrate

    File: fnc_spawnCrate.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2022-10-01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Spawns the selected crate.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlCrate = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOCRATE;

// Read the controls
private _crateIndex = lbCurSel _ctrlCrate;

// Check for empty selection
if (_crateIndex == -1) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTSELECTION"] call CBA_fnc_notify;
};

// Crate selection
private _crateType = _ctrlCrate lbData _crateIndex;

private _object = CCGVAR("object", objNull);

private _deployedHash = _object getVariable [QEGVAR(logistics,deployedHash),createHashMap];
private _amountSpawned = _deployedHash getOrDefault [_crateType,0];

private _crateLimit = ["Crates",_crateType,"limit"] call EFUNC(logistics,getConfigProperty);

TRACE_CHAT_3("limit checking",_crateType,_amountSpawned,_crateLimit);

if ((_crateLimit >= 0) && {_amountSpawned >= _crateLimit}) exitWith {
    [format [localize "STR_KP_CRATEFILLER_LIMITEXCEEDED",_amountSpawned,_crateLimit]] call CBA_fnc_notify;
};

private _outputClear = _object getVariable QEGVAR(logistics,outputClear);
if !(_outputClear) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTZONE"] call CBA_fnc_notify;
};

// Spawn crate
_object animateSource ["drawer_translation",1,0.5];
[{(_this select 0) animateSource ["drawer_translation",0,1]},[_object],EGVAR(logistics,spawnDuration)] call CBA_fnc_waitAndExecute;

private _pos = [];
if (_object isKindOf "MTI_Logibox_Base") then {
    _pos = _object modelToWorld (_object selectionPosition ["helper_centre","Memory"]);
} else {
    _pos = (getPos _object) findEmptyPosition [0, GVAR(param_usageRadius), _crateType];
};
private _crate = createVehicle [_crateType, [0,0,100 + random (100)], [], 0, "CAN_COLLIDE"];
_crate setPosASL (AGLToASL _pos);

private _config = [_crateType] call FUNC(getConfigPath);
private _name = (getText (_config >> "displayName"));
[format [localize "STR_KP_CRATEFILLER_HINTSPAWN", _name]] call CBA_fnc_notify;

_deployedHash set [_crateType,_amountSpawned + 1];
_object setVariable [QEGVAR(logistics,deployedHash),_deployedHash,true];

[] call FUNC(getNearStorages);

true
