#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    mti_logistics_cratefiller_fnc_createEquipmentList

    File: fnc_createEquipmentList.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Changes the shown equipment category.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlCat = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOEQUIPMENT;
private _ctrlWeapon = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOWEAPONS;
private _ctrlSearch = _dialog displayCtrl KP_CRATEFILLER_IDC_SEARCHBAR;
private _ctrlEquipment = _dialog displayCtrl KP_CRATEFILLER_IDC_EQUIPMENTLIST;

// Clear the lists
lbClear _ctrlWeapon;
lbClear _ctrlEquipment;

// Hide controls
_ctrlWeapon ctrlShow false;
_ctrlSearch ctrlShow false;

// Read controls
private _catIndex = lbCurSel _ctrlCat;

// Check for empty selection
if (_catIndex isEqualTo -1) exitWith {};

// Variables
private _config = "";
private _weapons = CGVAR("weapons", []);
private _grenades = CGVAR("grenades", []);
private _explosives = CGVAR("explosives", []);
private _items = CGVAR("items", []);
private _backpacks = CGVAR("backpacks", []);

TRACE_CHAT_1("weapons", _weapons);
TRACE_CHAT_1("grenades", _grenades);
TRACE_CHAT_1("explosives", _explosives);
TRACE_CHAT_1("items", _items);
TRACE_CHAT_1("backpacks", _backpacks);

TRACE_CHAT_6("counts",_catIndex, count _weapons, count _grenades, count _explosives, count _items, count _backpacks);

switch (_catIndex) do {

    // Weapons
    case 0 : {
        {
            diag_log format["_x: %1",_x];
            _config = [_x select 1] call FUNC(getConfigPath);
            _ctrlEquipment lnbAddRow ["", _x select 0];
            _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
        } forEach (_weapons);
        CCSVAR("activeCat", "weapons", false);
    };

    // Magazines
    case 1 : {
        _ctrlWeapon ctrlShow true;
        _ctrlSearch ctrlShow true;
        {
            _index = _ctrlWeapon lbAdd (_x select 0);
            _ctrlWeapon lbSetData [_index , _x select 1];
            _config = [_x select 1] call FUNC(getConfigPath);
            _ctrlWeapon lbSetPicture [_index, getText (_config >> "picture")];
        } forEach (_weapons);
        CCSVAR("activeCat", "magazines", false);
        [] call FUNC(createSubList);
    };

    // Attachments
    case 2 : {
        _ctrlWeapon ctrlShow true;
        _ctrlSearch ctrlShow true;
        {
            _index = _ctrlWeapon lbAdd (_x select 0);
            _ctrlWeapon lbSetData [_index , _x select 1];
            _config = [_x select 1] call FUNC(getConfigPath);
            _ctrlWeapon lbSetPicture [_index, getText (_config >> "picture")];
        } forEach (_weapons);
        CCSVAR("activeCat", "attachments", false);
        [] call FUNC(createSubList);
    };

    // Grenades
    case 3 : {
        {
            _config = [_x select 1] call FUNC(getConfigPath);
            _ctrlEquipment lnbAddRow ["", _x select 0];
            _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
        } forEach (_grenades);
        CCSVAR("activeCat", "grenades", false);
    };

    // Explosives
    case 4 : {
        {
            _config = [_x select 1] call FUNC(getConfigPath);
            _ctrlEquipment lnbAddRow ["", _x select 0];
            _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
        } forEach (_explosives);
        CCSVAR("activeCat", "explosives", false);
    };

    // Items
    case 5 : {
        {
            _config = [_x select 1] call FUNC(getConfigPath);
            _ctrlEquipment lnbAddRow ["", _x select 0];
            _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
        } forEach (_items);
        CCSVAR("activeCat", "items", false);
    };

    // Backpacks
    case 6 : {
        {
            _config = [_x select 1] call FUNC(getConfigPath);
            _ctrlEquipment lnbAddRow ["", _x select 0];
            _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
        } forEach (_backpacks);
        CCSVAR("activeCat", "backpacks", false);
    };
};

true
