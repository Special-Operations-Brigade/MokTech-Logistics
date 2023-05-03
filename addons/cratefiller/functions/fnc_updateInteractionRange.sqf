#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KPCF_cratefiller_fnc_updateInteractionRange

    File: fnc_updateInteractionRange.sqf
    Author: Cat Harsis
            
    Date: 2022-10-01
    Last Update: 2022-10-01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Updates interaction range on existing actions

    Parameter(s):
        none

    Returns:
        Function reached the end [BOOL]
*/

params [];

if(!hasInterface) exitWith { true };

private _crateFillerClasses = CGVAR("buildings", []);
{
    private _actionID = _x getVariable [QGVAR(actionID), -1];
    if(_actionID != -1) then {
        private _actionParams = _x actionParams _actionID;
       
        if(_actionParams # 8 != GVAR(param_interactRadius)) then {
            _x removeAction _actionID;
            _actionParams set [8, GVAR(param_interactRadius)];
            _actionParams deleteAt 11; // actionParams returns two more parameters than 
            _actionParams deleteAt 10; // you can pass to addAction
            
            _actionID = _x addAction _actionParams;
            _x setVariable [QGVAR(actionID), _actionID];
        };
    };
} forEach entities [_crateFillerClasses, []];



true
