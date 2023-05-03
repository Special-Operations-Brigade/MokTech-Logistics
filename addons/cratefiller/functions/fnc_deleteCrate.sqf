#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KPCF_cratefiller_fnc_deleteCrate

    File: fnc_deleteCrate.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Deletes the selected crate.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Get the active storage
private _storage = [] call FUNC(getStorage);

// Check for empty variable
if (isNull _storage) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTSELECTION"] call CBA_fnc_notify;
};

// Check if the active storage is a pre defined crate
if ((typeOf _storage) in CGVAR("crates", [])) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTNONDELETEABLE"] call CBA_fnc_notify;
};

// Delete crate
deleteVehicle _storage;

private _config = [typeOf _storage] call FUNC(getConfigPath);
private _name = (getText (_config >> "displayName"));

_storage = objNull;

[] remoteExecCall [QFUNC(getInventory), (allPlayers - entities "HeadlessClient_F")];
[{[] remoteExecCall [QFUNC(getNearStorages), (allPlayers - entities "HeadlessClient_F")];}, [], 1] call CBA_fnc_waitAndExecute;

[format [localize "STR_KP_CRATEFILLER_HINTDELETE", _name]] call CBA_fnc_notify;

true
