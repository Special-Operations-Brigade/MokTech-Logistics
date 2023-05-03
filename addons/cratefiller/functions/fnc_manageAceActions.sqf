#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KPCF_cratefiller_fnc_manageAceActions

    File: fnc_manageAceActions.sqf
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
    private _action = [QGVAR(action), localize "STR_KP_CRATEFILLER_TITLE", "\z\KPCF\addons\cratefiller\ui\res\kp512_CA", {[_this] call FUNC(openDialog);}, { GVAR(param_useAceActions) }] call ace_interact_menu_fnc_createAction;
    _return = [_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

} else {
    [_object, 0, ["ACE_MainActions", QGVAR(action)]] call ace_interact_menu_fnc_removeActionFromObject;
};

true
