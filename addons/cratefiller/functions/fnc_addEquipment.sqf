
#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    mti_logistics_cratefiller_fnc_addEquipment

    File: fnc_addEquipment.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Adds one of the selected item to the inventory.

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

// Check for empty selection
if (_indexActive isEqualTo -1 || ((lnbSize _ctrlActive) select 0) isEqualTo 0) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTSELECTION"] call CBA_fnc_notify;
};

// Get the storage object
private _storage = [] call FUNC(getStorage);
private _inventory = [] call FUNC(getInventory);

// Exit on missing storage
if (isNull _storage) exitWith {
	[localize "STR_KP_CRATEFILLER_HINTNOSTORAGE"] call CBA_fnc_notify;
};

// Variables
private _item = "";

if (_controlId isEqualTo KP_CRATEFILLER_IDC_INVENTORYLIST) then {
    // Item selection
    _item = (_inventory select _indexActive) select 1;
} else {
    private _cat = CCGVAR("activeCat", "");
    private _catStuff = CGVAR(_cat, []);
    TRACE_CHAT_4("catstuff",_cat,_catStuff,_indexActive,(_catStuff select _indexActive));
    _item = (_catStuff select _indexActive) select 1;
};

// Check for enough inventory capacity
if (!(_storage canAdd _item)) exitWith {
    CBA_ui_notifyQueue = [];
    [localize "STR_KP_CRATEFILLER_HINTFULL"] call CBA_fnc_notify;
};

private _amount = 1;
if (GVAR(keyMods) select 0) then { _amount = 5;};
if (GVAR(keyMods) select 1) then { _amount = 10;};
if (GVAR(keyMods) select 2) then { _amount = 50;};

// Add the given item
if (_item isKindOf "Bag_Base") then {
    _storage addBackpackCargoGlobal [_item, _amount];
} else {
    _storage addItemCargoGlobal [_item, _amount];
};

[] remoteExecCall [QFUNC(showInventory), (allPlayers - entities "HeadlessClient_F")];

private _config = [_item] call FUNC(getConfigPath);
private _name = (getText (_config >> "displayName"));
private _picture = (getText (_config >> "picture"));
CBA_ui_notifyQueue = [];
[
    [_picture, 2],
    [format [localize "STR_KP_CRATEFILLER_HINTADDED", _name, _amount]]
] call CBA_fnc_notify;

true
