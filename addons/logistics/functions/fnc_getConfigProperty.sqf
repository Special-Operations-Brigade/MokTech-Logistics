#include "script_component.hpp"

/*
Function: mti_logistics_fnc_getConfigProperty

Description:
    Helper function to properly retrieve properties from the logistics config

Arguments:
    _category - Category to retrieve from
	_class - Class name to look up
	_property - Property to retrieve

Return Value:
    None

Example:
    (begin example)
        [] call mti_logistics_fnc_getConfigProperty;
    (end)

Author:
	Mokka
*/

params ["_category","_class","_property"];

TRACE_3("params",_category,_class,_property);

private _data = (missionConfigFile >> QGVAR(Config) >> _category >> _class >> _property) call BIS_fnc_getCfgData;

TRACE_1("mcfg",_data);

if (isNil "_data") then {
	_data = (configFile >> QGVAR(Config) >> _category >> _class >> _property) call BIS_fnc_getCfgData;
    TRACE_1("cfg",_data);
};

_data
