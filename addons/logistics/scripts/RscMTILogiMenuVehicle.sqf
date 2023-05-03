#include "..\script_component.hpp"
#include "..\ui\idDefines.hpp"

params ["_mode", "_params", "_class"];

TRACE_CHAT_3("ui params",_mode,_params,_class);

switch (_mode) do {
	case "onLoad": {
		_params params ["_display", ["_config", configNull]];

		[_display] call FUNC(vehicle_onLoad);
	};
	case "onUnload": {
		_params params ["_display", "_exitCode"];

		[_display,_exitCode] call FUNC(vehicle_onUnload);
	};
	default { };
};
