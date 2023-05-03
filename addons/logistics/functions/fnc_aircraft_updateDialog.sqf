#include "script_component.hpp"
#include "..\ui\idDefines.hpp"

/*
Function: mti_logistics_fnc_aircraft_updateDialog

Description:
    Updates the LogiBox dialog based on currently selected vehicle.

Arguments:
    _listBoxVehicle - Vehicle listbox ctrl
    _curSel - Current selection

Return Value:
    None

Example:
    (begin example)
        [] call mti_logistics_fnc_aircraft_updateDialog;
    (end)

Author:
	Mokka
*/

disableSerialization;

params ["_listBoxVehicle","_curSel"];

TRACE_CHAT_2("params",_listBoxVehicle,_curSel);

private _display = ctrlParent _listBoxVehicle;
private _logibox = uiNamespace getVariable QGVAR(logibox);

TRACE_CHAT_2("vars",_display,_logibox);

if (isNil "_logibox") exitWith {
    ERROR_1("%1 could not find logibox reference, closing dialog",ACE_player);
    closeDialog 2;
};

// get vars
private _deployedHash = _logibox getVariable [QGVAR(deployedHash),createHashMap];

// get ctrls
private _textAssetLimitEdit = _display displayCtrl IDC_RSCMTILOGIMENU_TEXTASSETLIMITEDIT;
private _checkboxConfigureLoadoutEdit = _display displayCtrl IDC_RSCMTILOGIMENU_CHECKBOXCONFIGURELOADOUTEDIT;

private _pictureVehiclePreview = _display displayCtrl IDC_RSCMTILOGIMENU_PICTUREVEHICLEPREVIEW;
private _listBoxSkin = _display displayCtrl IDC_RSCMTILOGIMENU_LISTBOXSKIN;

// update based on currently selected vehicle
// if no vehicle selected (or available), just exit with default values
if (_curSel < 0) exitWith {
    _textAssetLimitEdit ctrlSetText "N/A";
    _checkboxConfigureLoadoutEdit cbSetChecked false;
    _checkboxConfigureLoadoutEdit ctrlEnable false;

    lbClear _listBoxSkin;
    _pictureVehiclePreview ctrlSetText "#(argb,8,8,3)color(0,0,0,0)";
};

private _curVehicle = _listBoxVehicle lbData _curSel;
private _curVehicleCfg = (configFile >> "CfgVehicles" >> _curVehicle);

// set limit text
private _limit = ["Aircraft",_curVehicle,"limit"] call FUNC(getConfigProperty);
private _deployed = _deployedHash getOrDefault [_curVehicle,0];

if (_limit >= 0) then {
    _textAssetLimitEdit ctrlSetText format ["%1 / %2",_deployed,_limit];
} else {
    _textAssetLimitEdit ctrlSetText format ["%1 / Unlimited",_deployed];
};

// set preview picture
private _previewPicture = getText (_curVehicleCfg >> "editorPreview");

_pictureVehiclePreview ctrlSetText _previewPicture;

// populate skin list box
lbClear _listBoxSkin;
private _hasSkins = GET_NUMBER(_curVehicleCfg >> QEGVAR(aircraft,hasSkins),0) > 0;

if (_hasSkins) then {
    private _skins = QUOTE(GET_NUMBER(_x >> QQEGVAR(aircraft,scope),0) > 0) configClasses (_curVehicleCfg >> "TextureSources");

    {
        private _skin = configName _x;
        private _displayName = getText (_x >> "displayName");

        private _lbIdx = _listBoxSkin lbAdd _displayName;
        _listBoxSkin lbSetData [_lbIdx,_skin];
    } forEach _skins;
} else {
    private _lbIdx = _listBoxSkin lbAdd "Default";
    _listBoxSkin lbSetData [_lbIdx,""];
};

// enable/disable loadout selection based on if selected aircraft actually has pylons
if ([_curVehicle] call zen_common_fnc_hasPylons) then {
    _checkboxConfigureLoadoutEdit ctrlEnable true;
} else {
    _checkboxConfigureLoadoutEdit cbSetChecked false;
    _checkboxConfigureLoadoutEdit ctrlEnable false;
};

_listBoxSkin lbSetCurSel 0;
