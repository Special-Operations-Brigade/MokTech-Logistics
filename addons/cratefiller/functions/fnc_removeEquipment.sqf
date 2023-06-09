#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    mti_logistics_cratefiller_fnc_removeEquipment

    File: fnc_removeEquipment.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Removes one of the selected item from the storage.

    Parameter(s):
        _controlId - Id of the control which is selected [NUMBER, defaults to 0]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_controlId", 0, [0]]
];

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlActive = _dialog displayCtrl _controlId;

// Read controls
private _indexActive = lbCurSel _ctrlActive;

// Get the storage object
private _storage = [] call FUNC(getStorage);

// Get the storage inventory
private _inventory = [] call FUNC(getInventory);

// Variables
private _item = "";
private _index = 0;

// Check for empty selection
if (_indexActive isEqualTo -1 || ((lnbSize _ctrlActive) select 0) isEqualTo 0) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTSELECTION"] call CBA_fnc_notify;
};


private _amount = 1;
if (GVAR(keyMods) select 0) then { _amount = 5;};
if (GVAR(keyMods) select 1) then { _amount = 10;};
if (GVAR(keyMods) select 2) then { _amount = 50;};

if (_controlId isEqualTo KP_CRATEFILLER_IDC_INVENTORYLIST) then {
    // Item selection
    _item = ((_inventory select _indexActive) select 1);

    // Modify array
    (_inventory select _indexActive) set [2, (((_inventory select _indexActive) select 2) - _amount) max 0];
} else {
    private _cat = CCGVAR("activeCat", "");
    private _catStuff = CGVAR(_cat, []);
    _item = (_catStuff select _indexActive) select 1;
    _index = _inventory findIf {(_x select 1) isEqualTo _item};
    if (_index isEqualTo -1) exitWith {};
    // Modify array
    (_inventory select _index) set [2, (((_inventory select _index) select 2) - _amount) max 0];
};

// Exit the function if nothing changed
if (_index isEqualTo -1) exitWith {};

// Apply the changed inventory
[_inventory] call FUNC(setInventory);

private _config = [_item] call FUNC(getConfigPath);
private _name = (getText (_config >> "displayName"));
private _picture = (getText (_config >> "picture"));
CBA_ui_notifyQueue = [];
[
    [_picture, 2],
    [format [localize "STR_KP_CRATEFILLER_HINTUNLOAD", _name, 1]]
] call CBA_fnc_notify;

true
