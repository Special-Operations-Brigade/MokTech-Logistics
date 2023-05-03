#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    mti_logistics_cratefiller_fnc_postInit

    File: fnc_postInit.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2019-05-09
    Last Update: 2022-10-01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        The postInit function of a module takes care of starting/executing the modules functions or scripts.
        Basically it starts/initializes the module functionality to make all provided features usable.

    Parameter(s):
        NONE

    Returns:
        PostInit finished [BOOL]
*/

if (isServer) then {

    INFO("Module initializing...");

    // Create cratefiller presets on startup
    [] call FUNC(presets);

};

GVAR(cachedBuildingClasses) = [];

if (isServer) then {INFO("Module initialized");};

true
