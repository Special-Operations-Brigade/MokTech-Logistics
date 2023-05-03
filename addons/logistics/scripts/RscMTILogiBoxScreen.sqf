#include "..\script_component.hpp"
#include "..\ui\idDefines.hpp"

params ["_mode", "_params", "_class"];

TRACE_CHAT_3("ui params",_mode,_params,_class);

switch (_mode) do {
	case "onLoad": {
		_params params ["_display", ["_config", configNull]];
	};
	case "onUnload": {
		_params params ["_display", "_exitCode"];
	};
	default { };
};
