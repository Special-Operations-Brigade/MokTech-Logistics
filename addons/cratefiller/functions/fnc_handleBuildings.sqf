#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KPCF_cratefiller_fnc_handleBuildings

    File: fnc_handleBuildings.sqf
    Author: Cat Harsis
            
    Date: 2022-10-01
    Last Update: 2022-10-01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Manages class event handler on cratefiller buildings

    Parameter(s):
        none

    Returns:
        Function reached the end [BOOL]
*/

// params [];

if(!hasInterface) exitWith { true };



private _crateFillerClasses = CGVAR("buildings", []);
private _removedClasses = []; // no longer cratefillers

if(!isNil QGVAR(cachedBuildingClasses)) then { _removedClasses = GVAR(cachedBuildingClasses) - _crateFillerClasses; };

private _newClasses = _crateFillerClasses - _removedClasses;
_fnc_initFunction = { 
    if(typeOf _x in CGVAR("buildings", [])) then { 
        [_this select 0, true] call FUNC(manageActions);
    }; 
};

{
    [_x, "init", _fnc_initFunction, nil, nil, true] call CBA_fnc_addClassEventHandler;
} forEach _newClasses;

// if we passed [] to entities it would return all entities in the mission
if(!(_removedClasses isEqualTo [])) then {
    // remove actions from no longer valid class objects
    {
        [_x, false] call FUNC(manageActions);
    } forEach entities [_removedClasses, []];
};

GVAR(cachedBuildingClasses) = _crateFillerClasses;


true
