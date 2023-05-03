#include "script_component.hpp"

/*
Function: mti_logistics_fnc_handleSlingload

Description:
    Handles the logibox getting picked up by a LAAT/c (hiding/unhiding the helpers)

Arguments:
	_ehArgs - The args passed as part of the event
	_args - The args passed directly from the event handler (the logibox object)
	_id - The ID of the eh
	_type - The type of the eh, to differentiate behaviour

Return Value:
    None

Example:
    (begin example)
        [] call mti_logistics_fnc_handleSlingload;
    (end)

Author:
	Mokka
*/
if !(isServer) exitWith {};

params ["_ehArgs","_args","_id","_type"];
TRACE_CHAT_4("params",_ehArgs,_args,_id,_type);
_args params ["_logibox"];

if !(alive _logibox) exitWith {
	[_type,_id] call CBA_fnc_removeEventHandler;
};

switch (_type) do {
	case QEGVAR(aircraft,laatc_loadingStarted): {
		_ehArgs params ["_aircraft","_objectToLoad","_loadVars"];

		if (_objectToLoad isNotEqualTo _logibox) exitWith {};

		_logibox setVariable [QGVAR(slingload),true,true];
	};
	case QEGVAR(aircraft,laatc_unloadingDone): {
		_ehArgs params ["_aircraft","_loaded"];

		if !(_logibox in _loaded) exitWith {};

		_logibox setVariable [QGVAR(slingload),false,true];
	};
	default { };
};
