#include "script_component.hpp"
/*
    mti_logistics_cratefiller_fnc_settings

    File: fnc_settings.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2019-05-09
    Last Update: 2022-10-01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        CBA Settings initialization for this module

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// GVAR(param_spawnAndDelete)
// Enables/Disables the ability to spawn and delete pre defined crates.
// Default: true
[
    QGVAR(param_spawnAndDelete),
    "CHECKBOX",
    [localize "STR_KP_CRATEFILLER_SPAWNDELETE", localize "STR_KP_CRATEFILLER_SPAWNDELETE_TT"],
    COMPONENT_NAME,
    true,
    1,
    {}
] call CBA_Settings_fnc_init;

// GVAR(param_inventoryBlacklist)
// Classnames of the inventories which will be ignored as valid storage.
// Default: []
[
    QGVAR(param_inventoryBlacklist),
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_INVENTORYBLACKLIST", localize "STR_KP_CRATEFILLER_INVENTORYBLACKLIST_TT"],
    COMPONENT_NAME,
    "[]",
    1,
    { call FUNC(presets) }
] call CBA_Settings_fnc_init;

// GVAR(param_usageRadius)
// Defines the range where inventories can be edited and crates will spawn.
// Default: 25
[
    QGVAR(param_usageRadius),
    "SLIDER",
    [localize "STR_KP_CRATEFILLER_USAGERADIUS", localize "STR_KP_CRATEFILLER_USAGERADIUS_TT"],
    COMPONENT_NAME,
    [1, 250, 25, 0],
    1,
    {}
] call CBA_Settings_fnc_init;

// GVAR(param_cratefillerOverview)
// Enables/Disables the cratefiller tools.
// Default: true
[
    QGVAR(param_cratefillerOverview),
    "CHECKBOX",
    [localize "STR_KP_CRATEFILLER_ACTIVATEOVERVIEW", localize "STR_KP_CRATEFILLER_ACTIVATEOVERVIEW_TT"],
    COMPONENT_NAME,
    true,
    1,
    {}
] call CBA_Settings_fnc_init;

true
