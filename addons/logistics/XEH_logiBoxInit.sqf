#include "script_component.hpp"
#include "ui\idDefines.hpp"

params ["_logibox"];

if (is3DEN) exitWith {};

/*
private _inProgress = _logibox getVariable [QGVAR(inProgress),false];
private _inProgressTime = _logibox getVariable [QGVAR(inProgressTime),[0,0]];
private _deployedHash = _logibox getVariable [QGVAR(deployedHash),createHashMap];
private _coolDown = _logibox getVariable [QGVAR(cooldown),0];
private _owner = _logibox getVariable [QGVAR(owner),ACE_Player];
private _outputClear = _logibox getVariable [QGVAR(outputClear),false];
*/
// init some vars
if (isServer) then {
	_logibox setVariable [QGVAR(deployedHash),createHashMap,true];

	private _jipID = [QGVAR(logibox_init),[_logibox]] call CBA_fnc_globalEventJIP;
	_logibox setVariable [QGVAR(jipID),_jipID];
	[_jipID,_logibox] call CBA_fnc_removeGlobalEventJIP;
};
