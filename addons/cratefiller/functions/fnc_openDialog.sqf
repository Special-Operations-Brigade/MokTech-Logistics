#include "script_component.hpp"
#include "..\ui\defines.hpp"
#include "\a3\ui_f\hpp\definedikcodes.inc"
/*
    Killah Potatoes Cratefiller v1.2.0

    mti_logistics_cratefiller_fnc_openDialog

    File: fnc_openDialog.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-01-21
    Last Update: 2020-07-07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Opens the cratefiller dialog.

    Parameter(s):
        _data - gets all data from the used base object [ARRAY, defaults to []]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_data", [], [[]]]
];

// Get the cratefiller object and store it
CCSVAR("object", _data select 0, false);

// Create dialog
createDialog "mti_logistics_cratefiller_dialog";
disableSerialization;

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlCrate = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOCRATE;
private _ctrlSpawn = _dialog displayCtrl KP_CRATEFILLER_IDC_BUTTONSPAWNCRATE;
private _ctrlDelete = _dialog displayCtrl KP_CRATEFILLER_IDC_BUTTONDELETECRATE;
private _ctrlCategory = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOEQUIPMENT;
private _ctrlWeapon = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOWEAPONS;
private _ctrlSearch = _dialog displayCtrl KP_CRATEFILLER_IDC_SEARCHBAR;
private _ctrlOverviewGroup = _dialog displayCtrl KP_CRATEFILLER_IDC_GROUPOVERVIEW;
private _ctrlToggleOverview = _dialog displayCtrl KP_CRATEFILLER_IDC_BUTTONOVERVIEW;

// Hide controls
_ctrlWeapon ctrlShow false;
_ctrlSearch ctrlShow false;
_ctrlOverviewGroup ctrlShow false;

// Disable the tools button on deactivation
if !(GVAR(param_cratefillerOverview)) then {
    _ctrlToggleOverview ctrlShow false;
};

// Disable spawn and delete functionalities on disabled param
if !(GVAR(param_spawnAndDelete)) then {
    _ctrlCrate ctrlShow false;
    _ctrlSpawn ctrlShow false;
    _ctrlDelete ctrlShow false;
} else {
    // Fill the controls
    {
        _index = _ctrlCrate lbAdd (_x select 0);
        _ctrlCrate lbSetData [_index , _x select 1];
    } forEach CGVAR("crates", []);
};

_dialog displayAddEventHandler ["KeyDown", {
    params ["","_key","_shift","_ctrl","_alt"];
    if (_key isEqualTo DIK_LSHIFT) then { GVAR(keyMods) set [0,true]; };
    if (_key isEqualTo DIK_LCONTROL) then { GVAR(keyMods) set [1,true]; };
    if (_key isEqualTo DIK_LALT) then { GVAR(keyMods) set [2,true]; };
}];

_dialog displayAddEventHandler ["KeyUp", {
    params ["","_key","_shift","_ctrl","_alt"];
    if (_key isEqualTo DIK_LSHIFT) then { GVAR(keyMods) set [0,false]; };
    if (_key isEqualTo DIK_LCONTROL) then { GVAR(keyMods) set [1,false]; };
    if (_key isEqualTo DIK_LALT) then { GVAR(keyMods) set [2,false]; };
}];

// Add category strings
_ctrlCategory lbAdd localize "STR_KP_CRATEFILLER_LISTWEAPONS";
_ctrlCategory lbAdd localize "STR_KP_CRATEFILLER_LISTMAGAZINES";
_ctrlCategory lbAdd localize "STR_KP_CRATEFILLER_LISTATTACHMENTS";
_ctrlCategory lbAdd localize "STR_KP_CRATEFILLER_LISTGRENADES";
_ctrlCategory lbAdd localize "STR_KP_CRATEFILLER_LISTEXPLOSIVES";
_ctrlCategory lbAdd localize "STR_KP_CRATEFILLER_LISTVARIOUS";
_ctrlCategory lbAdd localize "STR_KP_CRATEFILLER_LISTBACKPACKS";

[] call FUNC(showPresets);
[] call FUNC(getNearStorages);

true
