#include "script_component.hpp"

/*
Function: mti_logistics_fnc_spawnVehicleComplete

Description:
    Takes care of the actual spawning of the vehicle once all the fancy visual stuff is done.

Arguments:
    _mode - 1 for aircraft, 2 for vehicles
    _logibox - The logibox
    _selectedVehicle - Vehicle to spawn
    _selectedSkin - Skin that was selected, "" if using default
    _configureLoadout - If vehicle loadout should be adjusted after spawning (aircraft only)
    _player - Player that initiated the spawn

Return Value:
    None

Example:
    (begin example)
        [] call mti_logistics_fnc_spawnVehicleComplete;
    (end)

Author:
	Mokka
*/

params ["_mode","_logibox","_selectedVehicle","_selectedSkin","_configureLoadout","_player"];
TRACE_CHAT_6("spawn finish params",_mode,_logibox,_selectedVehicle,_selectedSkin,_configureLoadout,_player);

private _spawnPos = _logibox modelToWorld (_logibox selectionPosition ["helper_centre","Memory"]);

// spawn vehicle
private _vehicle = _selectedVehicle createVehicle [0, 0, 100 + (random 1000)];

// apply skin
if (_selectedSkin isNotEqualTo "") then {
    private _textures = getArray (configFile >> "CfgVehicles" >> _selectedVehicle >> "TextureSources" >> _selectedSkin >> "textures");
    {
        _vehicle setObjectTextureGlobal [_forEachIndex,_x];
    } forEach _textures;
};

// move to spawn pos, disabling collision to be safe
_vehicle disableCollisionWith _logibox;
_vehicle setPosASL (AGLToASL _spawnPos);

// re-enable position after "drawer" has been retracted
[
    {(_this select 1) disableCollisionWith (_this select 0)},
    [_logibox,_vehicle],
    5
] call CBA_fnc_waitAndExecute;

// update variables
_logibox setVariable [QGVAR(inProgress),false,true];

private _deployedHash = _logibox getVariable [QGVAR(deployedHash),createHashMap];
private _count = _deployedHash getOrDefault [_selectedVehicle,0,true];
_deployedHash set [_selectedVehicle,_count + 1];
_logibox setVariable [QGVAR(deployedHash),_deployedHash,true];

_logibox setVariable [QGVAR(cooldown),CBA_missionTime + GVAR(spawnCooldown),true];

// animate
_logibox animateSource ["drawer_translation",0,1];

if (_configureLoadout && ((ace_player distance2D _logibox) <= CONST_LOADOUT_CONFIG_MAX_DIST)) then {
    [_vehicle] call zen_pylons_fnc_configure;
};
