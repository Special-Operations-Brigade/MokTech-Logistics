#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    mti_logistics_cratefiller_fnc_export

    File: fnc_export.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Exports the active inventory.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlExport = _dialog displayCtrl KP_CRATEFILLER_IDC_EXPORTNAME;

// Read the presets from profileNamespace
private _preset = profileNamespace getVariable [QGVAR(preset), []];

// Read the export name
private _exportName = ctrlText _ctrlExport;
_ctrlExport ctrlSetText "";

// Check if the name is empty
if (_exportName isEqualTo "") exitWith {
    [localize "STR_KP_CRATEFILLER_HINTNAME"] call CBA_fnc_notify;
};

// Check if the variable is empty
if !(_preset isEqualTo []) then {
    // Check if the exportname already exists
    _preset deleteAt (_preset findIf {(_x select 0) isEqualTo _exportName});
};

// Get the storage inventory
private _inventory = [] call FUNC(getInventory);

// Save the inventory into profileNamespace
_preset pushBack [_exportName, +_inventory];

profileNamespace setVariable [QGVAR(preset), _preset];
saveProfileNamespace;

[] call FUNC(showPresets);

true
