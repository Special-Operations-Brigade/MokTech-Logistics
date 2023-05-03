#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    mti_logistics_cratefiller_fnc_getStorage

    File: fnc_getStorage.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2022-10-01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns the active storage.

    Parameter(s):
        NONE

    Returns:
        Active Storage [OBJECT]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlStorage = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOSTORAGE;

// Read controls
private _storageIndex = lbCurSel _ctrlStorage;

// Check for empty variable
if (_storageIndex isEqualTo -1) exitWith {
    objNull
};

// Get the storage object
private _storage = (_ctrlStorage lbData _storageIndex) call BIS_fnc_objectFromNetId;

// Check if the storage is in range
private _object = CCGVAR("object", objNull);

//TODO: what is this doing?
if ((_object distance2D _object) > GVAR(param_usageRadius)) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTRANGE"] call CBA_fnc_notify;
    [] remoteExecCall [QFUNC(getNearStorages), (allPlayers - entities "HeadlessClient_F")];
    objNull
};

_storage
