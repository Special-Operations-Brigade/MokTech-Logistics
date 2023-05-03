#include "script_component.hpp"
#include "..\ui\idDefines.hpp"

/*
Function: mti_logistics_fnc_aircraft_updateVehLb

Description:
    Updates the vehicle listbox for the logibox menu.

Arguments:
    _display - Display reference
	_logibox - LogiBox reference

Return Value:
    None

Example:
    (begin example)
        [] call mti_logistics_fnc_aircraft_updateVehLb;
    (end)

Author:
	Mokka
*/

disableSerialization;

params ["_display","_logibox"];

private _listBoxVehicle = _display displayCtrl IDC_RSCMTILOGIMENU_LISTBOXVEHICLE;
private _allVehicles = "true" configClasses (missionConfigFile >> QGVAR(Config) >> "Aircraft");
_allVehicles append ("true" configClasses (configFile >> QGVAR(Config) >> "Aircraft"));
private _deployedHash = _logibox getVariable [QGVAR(deployedHash),createHashMap];

lbClear _listBoxVehicle;

{
    // get vehicle info from config
    private _vehicle = configName _x;
    private _vehicleCfg = (configFile >> "CfgVehicles" >> _vehicle);
    if !(isClass _vehicleCfg) then {WARNING_1("%1 could not be found in cfgvehicles",_vehicle); continue;};

    private _displayName = getText (_vehicleCfg >> "displayName");

    private _lbIdx = _listBoxVehicle lbAdd _displayName;
    _listBoxVehicle lbSetData [_lbIdx,_vehicle];

    private _limit = ["Aircraft",configName _x,"limit"] call FUNC(getConfigProperty);
    private _deployed = _deployedHash getOrDefault [_vehicle,0];

    if ((_limit >= 0) && {_deployed >= _limit}) then {
        _listBoxVehicle lbSetColor [_lbIdx,[COLOUR_LOGIBOX_LIMITREACHED_RGBA]];
    };
} forEach _allVehicles;
