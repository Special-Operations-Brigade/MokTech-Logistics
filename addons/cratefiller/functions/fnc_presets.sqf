#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KPCF_cratefiller_fnc_presets

    File: fnc_presets.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-01-21
    Last Update: 2022-10-01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Creates the different categories of the whitelisted items.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Variables
private _weapons = createHashMapFromArray [[west,[]],[east,[]],[independent,[]]];
private _grenades = createHashMapFromArray [[west,[]],[east,[]],[independent,[]]];
private _explosives = createHashMapFromArray [[west,[]],[east,[]],[independent,[]]];
private _items = createHashMapFromArray [[west,[]],[east,[]],[independent,[]]];
private _backpacks = createHashMapFromArray [[west,[]],[east,[]],[independent,[]]];

private _specialItems = createHashMapFromArray [[west,[]],[east,[]],[independent,[]]];
private _buildings = [];
private _crates = [];
private _inventoryBlacklist = [];
private _classNames = createHashMap;
private _additional = createHashMap;
private _blacklist = createHashMap;

// Convert CBA settings array
_buildings = parseSimpleArray GVAR(param_buildings);
_crates = [parseSimpleArray GVAR(param_crates)] call FUNC(sortList);
_inventoryBlacklist = parseSimpleArray GVAR(param_inventoryBlacklist);
_classNames = createHashMapFromArray [
    [west,parseSimpleArray GVAR(param_items_w)],
    [east,parseSimpleArray GVAR(param_items_e)],
    [independent,parseSimpleArray GVAR(param_items_i)]
];
_additional = createHashMapFromArray[
    [west,parseSimpleArray GVAR(param_additional_w)],
    [east,parseSimpleArray GVAR(param_additional_e)],
    [independent,parseSimpleArray GVAR(param_additional_i)]
];
_blacklist = createHashMapFromArray[
    [west,parseSimpleArray GVAR(param_blacklist_w)],
    [east,parseSimpleArray GVAR(param_blacklist_e)],
    [independent,parseSimpleArray GVAR(param_blacklist_i)]
];

CSVAR("buildings", _buildings);
call FUNC(handleBuildings);

CSVAR("crates", _crates);
CSVAR("inventoryBlacklist", _inventoryBlacklist);
CSVAR("blacklist", _blacklist);

if (GVAR(param_generatePreset)) then {
    private _generatedClassNames = [];
    // Fetch all needed config classes
    private _type = [];
    private _configClasses = [];
    {
        _configClasses append (
            "
                _type = (configName _x) call BIS_fnc_itemType;
                (getNumber (_x >> 'scope') isEqualTo 2) &&
                ((_type select 0) != '') &&
                ((_type select 0) != 'VehicleWeapon')
            " configClasses _x
        );
    } forEach [(configFile >> "CfgWeapons"), (configFile >> "CfgMagazines"), (configFile >> "CfgVehicles"), (configFile >> "CfgGlasses")];

    // Fetch classnames
    {
        _generatedClassNames pushBack (configName _x);
    } forEach _configClasses;

    {
        _classNames set [_x,_generatedClassNames];
    } foreach [west,east,independent];
};



{
    private _side = _x;
    private _sideClassNames = _classNames get _side;
    private _sideSpecialItems = _specialItems get _side;
    private _sideBlacklist = _blacklist get _side;
    private _sideAdditional = _additional get _side;
    private _sideItems = _items get _side;
    private _sideWeapons = _weapons get _side;
    private _sideBackpacks = _backpacks get _side;
    private _sideExplosives = _explosives get _side;
    private _sideGrenades = _grenades get _side;


    // Search for special items with wrong config entrys
    {
        if (_x isKindOf ["CBA_MiscItem", configfile >> "CfgWeapons"]) then {_sideSpecialItems pushBack _x};
    } forEach _sideClassNames;

    // Black- and Whitelisting
    _sideClassNames = _sideClassNames - _sideBlacklist;
    _sideClassNames append _sideAdditional;

    // Sort all classnames into the different categories
    {
        private _type = _x call BIS_fnc_itemType;
        switch (_type select 0) do {
            case "Weapon": {if ((_type select 1) isEqualTo "UnknownWeapon") then {_sideItems pushBack _x} else {if ((_x call BIS_fnc_baseWeapon) isEqualTo _x) then {_sideWeapons pushBack _x;};};};
            case "Mine": {_sideExplosives pushBack _x};
            case "Magazine": {if ((((_type select 1) isEqualTo "Grenade") || ((_type select 1) isEqualTo "SmokeShell")) && !((getNumber (configFile >> "CfgMagazines" >> _x >> "type")) isEqualTo 16)) then {_sideGrenades pushBack _x}};
            case "Equipment": {if ((_type select 1) isEqualTo "Backpack") then {_sideBackpacks pushBack _x}};
            case "Item": {
                switch (_type select 1) do {
                    case "AccessoryMuzzle" : {};
                    case "AccessoryPointer" : {};
                    case "AccessorySights" : {};
                    case "AccessoryBipod" : {};
                    default {_sideItems pushBack _x};
                };
            };
        };
    } forEach (_sideClassNames arrayIntersect _sideClassNames);

    _sideItems append _sideSpecialItems;

    _sideWeapons = [_sideWeapons] call FUNC(sortList);
    _weapons set [_side,_sideWeapons];
    _sideGrenades = [_sideGrenades] call FUNC(sortList);
    _grenades set [_side,_sideGrenades];
    _sideExplosives = [_sideExplosives] call FUNC(sortList);
    _explosives set [_side,_sideExplosives];
    _sideItems = [_sideItems] call FUNC(sortList);
    _items set [_side,_sideItems];
    _sideBackpacks = [_sideBackpacks] call FUNC(sortList);
    _backpacks set [_side,_sideBackpacks];
} foreach [west,east,independent];

CSVAR("weapons", _weapons);
CSVAR("grenades", _grenades);
CSVAR("explosives", _explosives);
CSVAR("items", _items);
CSVAR("backpacks", _backpacks);
private _attachements = createHashMapFromArray [[west,[]],[east,[]],[independent,[]]];
CSVAR("attachments", _attachements);
private _magazines = createHashMapFromArray [[west,[]],[east,[]],[independent,[]]];
CSVAR("magazines", _magazines);

true
