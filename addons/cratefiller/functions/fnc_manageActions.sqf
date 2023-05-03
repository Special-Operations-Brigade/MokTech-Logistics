#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KPCF_cratefiller_fnc_manageActions

    File: fnc_manageActions.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
            Cat Harsis
    Date: 2019-09-16
    Last Update: 2022-10-01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Adds actions to the cratefiller objects.

    Parameter(s):
        _object - defines the object to apply the action [OBJECT, defaults to objNull]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_object", objNull, [objNull]],
    ["_add", true, [false]]
];
if(_add) then {
    if (_object getVariable [QGVAR(actionSet), false]) exitWith { true };

    if(GVAR(aceLoaded)) then { [_object, true] call FUNC(manageAceActions); };
    private _actionID = _object addAction ["<t color='#FF8000'>" + localize "STR_KP_CRATEFILLER_ACTIONOPEN" + "</t>", {[_this] call FUNC(openDialog);}, nil, 20, false, true, "", QUOTE(!(GVAR(aceLoaded) && GVAR(param_useAceActions))), GVAR(param_interactRadius)];

    _object setVariable [QGVAR(actionID), _actionID];
    _object setVariable [QGVAR(actionSet), true];
} else {
    if (_object getVariable [QGVAR(actionSet), false]) then {
        
        if(GVAR(aceLoaded)) then { [_object, false] call FUNC(manageAceActions); };
        
        private _actionID = _object getVariable [QGVAR(actionID), -1];    
        if(_actionID != -1) then { _object removeAction _actionID; };

        _object setVariable [QGVAR(actionSet), nil];
    };
};

true
