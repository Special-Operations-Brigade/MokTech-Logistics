#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    mti_logistics_cratefiller_fnc_preInit

    File: fnc_preInit.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2019-05-09
    Last Update: 2020-10-14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        The preInit function defines global variables, adds event handlers and set some vital settings which are used in this module.

    Parameter(s):
        NONE

    Returns:
        PreInit finished [BOOL]
*/

if (isServer) then {diag_log format [INFO("Module pre-initializing...")];};

/*
    ----- Module Initialization -----
*/

// Check for ACE
GVAR(aceLoaded)= isClass (configFile >> "CfgPatches" >> "ace_main");


// Process CBA Settings
[] call FUNC(settings);

// Server section (dedicated and player hosted)
if (isServer) then {

    GVAR(data) = true call CBA_fnc_createNamespace;
    publicVariable QGVAR(data);

    GVAR(cache) = true call CBA_fnc_createNamespace;
    publicVariable QGVAR(cache);

};

if (isServer) then {diag_log format [INFO("Module pre-initialized")];};

true
