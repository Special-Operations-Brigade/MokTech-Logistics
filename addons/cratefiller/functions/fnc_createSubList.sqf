#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    mti_logistics_cratefiller_fnc_createSubList

    File: fnc_createSubList.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Creates a list with valueable magazines or attachments.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

TRACE_CHAT_1("fired",_this);

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlCat = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOEQUIPMENT;
private _ctrlWeapon = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOWEAPONS;
private _ctrlEquipment = _dialog displayCtrl KP_CRATEFILLER_IDC_EQUIPMENTLIST;

// Clear the lists
lbClear _ctrlEquipment;

// Read controls
private _catIndex = lbCurSel _ctrlCat;
private _weaponIndex = lbCurSel _ctrlWeapon;

TRACE_CHAT_2("indices",_catIndex,_weaponIndex);

private _blacklist = CGVAR("blacklist", []);
private _savedMagazines = CGVAR("magazines", []);
private _savedAttachements = CGVAR("attachments", []);

TRACE_CHAT_1("blacklist", _blacklist);
TRACE_CHAT_1("magazines", _savedMagazines);
TRACE_CHAT_1("attachements", _savedAttachements);

TRACE_CHAT_4("counts", _weaponIndex, count _blacklist, count _savedMagazines, count _savedAttachements);

// Check for empty selection
if (_weaponIndex isEqualTo -1) exitWith {
    switch (_catIndex) do {
        // Magazines
        case 1 : {
            // Fill controls
            {
                _config = [_x select 1] call FUNC(getConfigPath);
                _ctrlEquipment lnbAddRow ["", _x select 0];
                _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
            } forEach (_savedMagazines - _blacklist);
        };

        // Attachments
        case 2 : {
            // Fill controls
            {
                _config = [_x select 1] call FUNC(getConfigPath);
                _ctrlEquipment lnbAddRow ["", _x select 0];
                _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
            } forEach (_savedAttachements - _blacklist);
        };
    };
};

// Weapon selection
private _weaponType = _ctrlWeapon lbData _weaponIndex;

// Variables
private _config = "";

switch (_catIndex) do {

    // Magazines
    case 1 : {
        // Get compatible magazines
        private _glType = (getArray (configfile >> "CfgWeapons" >> _weaponType >> "muzzles")) select 1;
        private _magazines = [_weaponType] call CBA_fnc_compatibleMagazines;
        _magazines append ([configfile >> "CfgWeapons" >> _weaponType >> _glType] call CBA_fnc_compatibleMagazines);
        _magazines = _magazines - _blacklist;

        private _sortedMagazines = [_magazines] call FUNC(sortList);
        TRACE_CHAT_1("mags",_sortedMagazines);
        CSVAR("magazines", _sortedMagazines);

        // Fill controls
        {
            _config = [_x select 1] call FUNC(getConfigPath);
            _ctrlEquipment lnbAddRow ["", _x select 0];
            _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
        } forEach _sortedMagazines;
    };

    // Attachments
    case 2 : {
        // Get compatible attachments
        private _attachments = [_weaponType] call BIS_fnc_compatibleItems;
        _attachments = _attachments - _blacklist;

        private _sortedAttachments = [_attachments] call FUNC(sortList);
        TRACE_CHAT_1("attachs",_sortedAttachments);
        CSVAR("attachments", _sortedAttachments);

        // Fill controls
        {
            _config = [_x select 1] call FUNC(getConfigPath);
            _ctrlEquipment lnbAddRow ["", _x select 0];
            _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
        } forEach _sortedAttachments;
    };
};

true
