#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KPCF_cratefiller_fnc_spawnCrate

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

private _checkSpawn = false;


//TODO: the check here considers the player an obstruction and hence prevents any crate creation.

// _nearbyObjects = ((getPos _object) nearEntities 5);
// _nearbyObjectsNotBuilding = _nearbyObjects select {!(typeOf _x in CGVAR("buildings", []))};
// if !(_nearbyObjectsNotBuilding isEqualTo []) exitWith {
//     [localize "STR_KP_CRATEFILLER_HINTZONE"] call CBA_fnc_notify;
// };

// Spawn crate
private _crate = createVehicle [_crateType, ((getPos _object) findEmptyPosition [0, GVAR(param_usageRadius), _crateType]), [], 0, "NONE"];

// Clear the storage
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

private _config = [_crateType] call FUNC(getConfigPath);
private _name = (getText (_config >> "displayName"));
[format [localize "STR_KP_CRATEFILLER_HINTSPAWN", _name]] call CBA_fnc_notify;

[] call FUNC(getNearStorages);

true
