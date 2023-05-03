#include "script_component.hpp"

/*
Function: mti_logistics_fnc_logibox_init

Description:
    Handles local initilization for the logibox.

Arguments:
    _logibox - LogiBox reference

Return Value:
    If area is clear

Example:
    (begin example)
        [] call mti_logistics_fnc_logibox_init;
    (end)

Author:
	Mokka
*/

params ["_logibox"];

// area check
// do maths here once
private _centrePos = _logibox selectionPosition ["helper_centre","Memory"];
private _boundingBox = _logibox selectionPosition  ["helper","Memory","BoundingBox"];

// length of the diagonal
private _diag = vectorMagnitude ((_boundingBox select 0) vectorDiff (_boundingBox select 1));

// get the lengths of the bounding box in a format suitable for inArea
private _bbX = (abs (((_boundingBox select 0) select 0) - ((_boundingBox select 1) select 0))) / 2;
private _bbY = (abs (((_boundingBox select 0) select 1) - ((_boundingBox select 1) select 1))) / 2;
private _bbZ = (abs (((_boundingBox select 0) select 2) - ((_boundingBox select 1) select 2))) / 2;

// adjust centrePos upwards (since it is on ground level in the model)
_centrePos = [_centrePos select 0, _centrePos select 1, (_centrePos select 2) + _bbZ];

[QEGVAR(aircraft,laatc_loadingStarted),{[_this,_thisArgs,_thisId,_thisType] call FUNC(handleSlingload)},[_logibox]] call CBA_fnc_addEventHandlerArgs;
[QEGVAR(aircraft,laatc_unloadingDone),{[_this,_thisArgs,_thisId,_thisType] call FUNC(handleSlingload)},[_logibox]] call CBA_fnc_addEventHandlerArgs;

private _uid = format ["%1:%2",typeOf _logibox,netId _logibox];
_logibox setObjectTexture ["screen",format ["#(rgb,1024,512,1)ui('RscMTILogiBoxScreen','%1')",_uid]];

// create and attach helper
private ["_helper"];
if (isServer) then {
	private ["_helperType"];

	switch (typeOf _logibox) do {
		case "MTI_LogiBox_aircraft";
		case "MTI_LogiBox_aircraft_alt": { _helperType = QGVAR(helper_aircraft); };
		case "MTI_LogiBox_vehicles";
		case "MTI_LogiBox_vehicles_alt": { _helperType = QGVAR(helper_vehicles); };
		case "MTI_LogiBox_crates";
		case "MTI_LogiBox_crates_alt": { _helperType = QGVAR(helper_crates); };
		default {
			WARNING_1("%1 is an unknown type of helper, falling back to default");
			_helperType = QGVAR(helper_crates);
		};
	};

	TRACE_CHAT_3("helper generation",_logibox,typeof _logibox,_helperType);

	_helper = _helperType createVehicle [0,0,100 + random (100)];
	_helper attachTo [_logibox,[0,0,0],"helper_centre"];
	_helper setVectorDirAndUp [[0,1,0],[0,0,1]];
	_logibox setVariable [QGVAR(helper),_helper];
} else {
	_helper = objNull;
};


// pfh for area checks and ui code
[
	{
		params ["_args", "_handle"];
		_args params ["_logibox","_positions","_uid",["_helper",objNull]];

		if !(alive _logibox) exitWith {
			[_handle] call CBA_fnc_removePerFrameHandler;

			if (isServer) then {
				private _helper = _logibox getVariable [QGVAR(helper),objNull];

				if (alive _helper) then {
					deleteVehicle _helper;
				};
			};
		};

		// run area check
		if (isServer) then {
			private _areaClear = [_logibox,_positions,_helper] call FUNC(logibox_checkArea);
		};

		// update dialog if open
		if !(hasInterface) exitWith {};
		private _display = _logibox getVariable [QGVAR(display),displayNull];

		if !(isNull _display) then {
			private _fnc_dialogPFH = _logibox getVariable [QGVAR(fnc_dialogPFH),""];
			_fnc_dialogPFH = missionNamespace getVariable [_fnc_dialogPFH,scriptNull];

			[_display,_logibox] call _fnc_dialogPFH;
		};

		// update screen UI
		if ((ACE_player distance2D _logibox) > 100) exitWith {};
		private _screenDisplay = findDisplay _uid;
		if !(isNull _screenDisplay) then {
			[_logibox,_screenDisplay] call FUNC(updateScreenDisplay);
		};
	},
	1,
	[_logibox,[_centrePos,_bbX,_bbY,_bbZ,_diag],_uid,_helper]
] call CBA_fnc_addPerFrameHandler;
