#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    mti_logistics_cratefiller_fnc_presets

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
private _weapons = [];
private _grenades = [];
private _explosives = [];
private _items = [];
private _backpacks = [];
private _attachements = [];
private _magazines = [];

private _crates = [];
private _inventoryBlacklist = [];
private _classNames = [];
private _blacklist = [];

// Grab data from config
private _cratesClasses = "(getNumber (_x >> 'limit')) != 0" configClasses (missionConfigFile >> QEGVAR(logistics,config) >> "Crates");
_cratesClasses append ("(getNumber (_x >> 'limit')) != 0" configClasses (configFile >> QEGVAR(logistics,config) >> "Crates"));
{
    private _class = configName _x;
    private _displayName = getText (configFile >> "CfgVehicles" >> _class >> "displayName");
    _crates pushBackUnique [_displayName,_class];
    TRACE_CHAT_2("crate",_displayName,_class);
} forEach _cratesClasses;


private _itemsClasses = "true" configClasses (configFile >> QEGVAR(logistics,config) >> "Items");
{
    if ((getNumber (_x >> "allowed")) == 1) then {
        _classNames pushBackUnique (getText (_x >> "name"));
        TRACE_CHAT_1("item allowed",_x);
    } else {
        _blacklist pushBackUnique (getText (_x >> "name"));
        TRACE_CHAT_1("item blacklisted",_x);
    };
} forEach _itemsClasses;

// Convert CBA settings array
_inventoryBlacklist = parseSimpleArray GVAR(param_inventoryBlacklist);

TRACE_CHAT_1("inv blacklist",_inventoryBlacklist);

// Populate categories
private _specialItems = [];

// Search for special items with wrong config entrys
{
    if (_x isKindOf ["CBA_MiscItem", configfile >> "CfgWeapons"]) then {_specialItems pushBack _x};
} forEach _classNames;

// Black- and Whitelisting
_classNames = _classNames - _blacklist;

// Sort all classnames into the different categories
{
    private _type = _x call BIS_fnc_itemType;
    TRACE_CHAT_2("item type",_x,_type);
    switch (_type select 0) do {
        case "Weapon": {if ((_type select 1) isEqualTo "UnknownWeapon") then {_items pushBack _x} else {if ((_x call BIS_fnc_baseWeapon) isEqualTo _x) then {_weapons pushBack _x;};};};
        case "Mine": {_explosives pushBack _x};
        case "Magazine": {if ((((_type select 1) isEqualTo "Grenade") || ((_type select 1) isEqualTo "SmokeShell")) && !((getNumber (configFile >> "CfgMagazines" >> _x >> "type")) isEqualTo 16)) then {_grenades pushBack _x}; if ((getNumber (configFile >> "CfgMagazines" >> _x >> "type")) isEqualTo 16) then {_magazines pushBack _x};};
        case "Equipment": {if ((_type select 1) isEqualTo "Backpack") then {_backpacks pushBack _x}};
        case "Item": {
            switch (_type select 1) do {
                case "AccessoryMuzzle" : {_attachements pushBack _x};
                case "AccessoryPointer" : {_attachements pushBack _x};
                case "AccessorySights" : {_attachements pushBack _x};
                case "AccessoryBipod" : {_attachements pushBack _x};
                default {_items pushBack _x};
            };
        };
    };
} forEach (_classNames arrayIntersect _classNames);

_items append _specialItems;
_attachements = _attachements - _specialItems;

_weapons = [_weapons] call FUNC(sortList);
_grenades = [_grenades] call FUNC(sortList);
_explosives = [_explosives] call FUNC(sortList);
_items = [_items] call FUNC(sortList);
_backpacks = [_backpacks] call FUNC(sortList);
_magazines = [_magazines] call FUNC(sortList);
_attachements = [_attachements] call FUNC(sortList);


// Set variables
CSVAR("crates", _crates);
CSVAR("inventoryBlacklist", _inventoryBlacklist);
CSVAR("blacklist", _blacklist);
CSVAR("weapons", _weapons);
CSVAR("grenades", _grenades);
CSVAR("explosives", _explosives);
CSVAR("items", _items);
CSVAR("backpacks", _backpacks);
CSVAR("attachments", _attachements);
CSVAR("magazines", _magazines);

true
