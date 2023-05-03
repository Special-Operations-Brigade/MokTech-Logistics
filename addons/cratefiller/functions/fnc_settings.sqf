#include "script_component.hpp"
/*
    KPCF_cratefiller_fnc_settings

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
    localize "STR_KP_CRATEFILLER_SETTINGS",
    true,
    1,
    {}
] call CBA_Settings_fnc_init;

// GVAR(param_generatePreset)
// Enables/Disables the item preset generation from configFile.
// Default: true
[
    QGVAR(param_generatePreset),
    "CHECKBOX",
    [localize "STR_KP_CRATEFILLER_GENERATEPRESET", localize "STR_KP_CRATEFILLER_GENERATEPRESET_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    true,
    1,
    {call FUNC(presets);}
] call CBA_Settings_fnc_init;

// GVAR(param_buildings)
// Classnames of the buildings which will get the cratefiller action.
// Default: ["Land_RepairDepot_01_tan_F", "Land_RepairDepot_01_green_F", "Land_RepairDepot_01_civ_F"]
[
    QGVAR(param_buildings),
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_BUILDINGS", localize "STR_KP_CRATEFILLER_BUILDINGS_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[""Land_RepairDepot_01_tan_F"", ""Land_RepairDepot_01_green_F"", ""Land_RepairDepot_01_civ_F""]",
    1,
    { call FUNC(presets) }
] call CBA_Settings_fnc_init;

// GVAR(param_crates)
// Classnames of the crates which will be available for spawn and delete.
// Default: ["B_supplyCrate_F", "CargoNet_01_box_F"]
[
    QGVAR(param_crates),
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_CRATES", localize "STR_KP_CRATEFILLER_CRATES_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[""B_supplyCrate_F"", ""CargoNet_01_box_F""]",
    1,
    { call FUNC(presets) }
] call CBA_Settings_fnc_init;

// GVAR(param_inventoryBlacklist)
// Classnames of the inventories which will be ignored as valid storage.
// Default: []
[
    QGVAR(param_inventoryBlacklist),
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_INVENTORYBLACKLIST", localize "STR_KP_CRATEFILLER_INVENTORYBLACKLIST_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[]",
    1,
    { call FUNC(presets) }
] call CBA_Settings_fnc_init;

// GVAR(param_items)
// Classnames of the items which should be available at the cratefiller on deactivated preset generation.
// Default: ["arifle_SPAR_01_snd_F", "MMG_01_tan_F", "HandGrenade", "MiniGrenade", "DemoCharge_Remote_Mag", "ATMine_Range_Mag", "FirstAidKit", "ToolKit", "B_FieldPack_cbr", "B_AssaultPack_cbr"]
[
    QGVAR(param_items_w),
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_ITEMS_W", localize "STR_KP_CRATEFILLER_ITEMS_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[""arifle_SPAR_01_snd_F"", ""MMG_01_tan_F"", ""HandGrenade"", ""MiniGrenade"", ""DemoCharge_Remote_Mag"", ""ATMine_Range_Mag"", ""FirstAidKit"", ""ToolKit"", ""B_FieldPack_cbr"", ""B_AssaultPack_cbr""]",
    1,
    { call FUNC(presets) }
] call CBA_Settings_fnc_init;

[
    QGVAR(param_items_e),
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_ITEMS_E", localize "STR_KP_CRATEFILLER_ITEMS_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[""arifle_SPAR_01_snd_F"", ""MMG_01_tan_F"", ""HandGrenade"", ""MiniGrenade"", ""DemoCharge_Remote_Mag"", ""ATMine_Range_Mag"", ""FirstAidKit"", ""ToolKit"", ""B_FieldPack_cbr"", ""B_AssaultPack_cbr""]",
    1,
    { call FUNC(presets) }
] call CBA_Settings_fnc_init;

[
    QGVAR(param_items_i),
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_ITEMS_I", localize "STR_KP_CRATEFILLER_ITEMS_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[""arifle_SPAR_01_snd_F"", ""MMG_01_tan_F"", ""HandGrenade"", ""MiniGrenade"", ""DemoCharge_Remote_Mag"", ""ATMine_Range_Mag"", ""FirstAidKit"", ""ToolKit"", ""B_FieldPack_cbr"", ""B_AssaultPack_cbr""]",
    1,
    { call FUNC(presets) }
] call CBA_Settings_fnc_init;

// GVAR(param_blacklist)
// Classnames of the items which should be blacklisted from the cratefiller.
// Default: []
[
    QGVAR(param_blacklist_w),
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_BLACKLIST_W", localize "STR_KP_CRATEFILLER_BLACKLIST_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[]",
    1,
    { call FUNC(presets) }
] call CBA_Settings_fnc_init;

[
    QGVAR(param_blacklist_e),
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_BLACKLIST_E", localize "STR_KP_CRATEFILLER_BLACKLIST_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[]",
    1,
    { call FUNC(presets) }
] call CBA_Settings_fnc_init;

[
    QGVAR(param_blacklist_i),
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_BLACKLIST_I", localize "STR_KP_CRATEFILLER_BLACKLIST_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[]",
    1,
    { call FUNC(presets) }
] call CBA_Settings_fnc_init;

// GVAR(param_additional)
// Classnames of the items which should be added after the generated to presets to prevent missing items due to bad config entries.
// Default: []
[
    QGVAR(param_additional_w),
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_ADDITIONAL_W", localize "STR_KP_CRATEFILLER_ADDITIONAL_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[]",
    1,
    { call FUNC(presets) }
] call CBA_Settings_fnc_init;

[
    QGVAR(param_additional_e),
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_ADDITIONAL_E", localize "STR_KP_CRATEFILLER_ADDITIONAL_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    "[]",
    1,
    { call FUNC(presets) }
] call CBA_Settings_fnc_init;

[
    QGVAR(param_additional_i),
    "EDITBOX",
    [localize "STR_KP_CRATEFILLER_ADDITIONAL_I", localize "STR_KP_CRATEFILLER_ADDITIONAL_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
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
    localize "STR_KP_CRATEFILLER_SETTINGS",
    [1, 250, 25, 0],
    1,
    {}
] call CBA_Settings_fnc_init;

// GVAR(param_interactRadius)
// Defines the range for the interaction (addAction / ACE).
// Default: 5
[
    QGVAR(param_interactRadius),
    "SLIDER",
    [localize "STR_KP_CRATEFILLER_INTERACTRADIUS", localize "STR_KP_CRATEFILLER_INTERACTRADIUS_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    [1, 50, 5, 0],
    1,
    {call FUNC(updateInteractionRange)}
] call CBA_Settings_fnc_init;

// GVAR(param_cratefillerOverview)
// Enables/Disables the cratefiller tools.
// Default: true
[
    QGVAR(param_cratefillerOverview),
    "CHECKBOX",
    [localize "STR_KP_CRATEFILLER_ACTIVATEOVERVIEW", localize "STR_KP_CRATEFILLER_ACTIVATEOVERVIEW_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    true,
    1,
    {}
] call CBA_Settings_fnc_init;

// GVAR(param_useAceActions)
// Enables/Disables the ACE interaction usage.
// Default: false
[
    QGVAR(param_useAceActions),
    "CHECKBOX",
    [localize "STR_KP_CRATEFILLER_USEACEACTIONS", localize "STR_KP_CRATEFILLER_USEACEACTIONS_TT"],
    localize "STR_KP_CRATEFILLER_SETTINGS",
    true,
    1,
    {},
	true
] call CBA_Settings_fnc_init;

true
