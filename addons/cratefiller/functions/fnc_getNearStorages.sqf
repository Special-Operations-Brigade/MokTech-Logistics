#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KPCF_cratefiller_fnc_getNearStorages

    File: fnc_getNearStorages.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-01-21
    Last Update: 2022-10-01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Scans for possible storages.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlStorage = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOSTORAGE;

// Clear the lists
lbClear _ctrlStorage;

// Variables
private _type = objNull;
private _config = "";
private _number = 0;
private _index = 0;
private _picture = "";
private _blacklist = [
    "GroundWeaponHolder",
    "WeaponHolderSimulated",
    ""
];
private _object = CCGVAR("object", objNull);
private _objects = _object nearObjects GVAR(param_usageRadius);
_blacklist append CGVAR("inventoryBlacklist", []);

// Convert CBA settings array
_blacklist append (GVAR(param_inventoryBlacklist) splitString ", ");

// Get near objects and check for storage capacity
{
    _type = typeOf _x;
    _config = [_type] call FUNC(getConfigPath);
    _number = getNumber (_config >> "maximumLoad");
    // If the object has an inventory add it to the list
    if (_number > 0) then {
        _index = _ctrlStorage lbAdd format ["%1m - %2", round ((getPos _object) distance2D _x), getText (_config >> "displayName")];
        _netId = _x call BIS_fnc_netId;
        _ctrlStorage lbSetData [_index, _netId];
        _picture = getText (_config >> "picture");
        if (_picture isEqualTo "pictureThing") then {
            _ctrlStorage lbSetPicture [_index, "\z\KPCF\addons\cratefiller\ui\res\icon_help"];
        } else {
            _ctrlStorage lbSetPicture [_index, _picture];
        };
    };
} forEach (_objects select {!(typeOf _x in _blacklist) && !((typeOf _x select [0,1]) isEqualTo "#") && !(_x isKindOf "Building") && !(typeOf _x in CGVAR("buildings", [])) && ((attachedTo _x) isEqualTo objNull)});

true
