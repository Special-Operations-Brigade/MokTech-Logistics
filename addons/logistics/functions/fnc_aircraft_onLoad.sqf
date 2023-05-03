#include "script_component.hpp"
#include "..\ui\idDefines.hpp"

/*
Function: mti_logistics_fnc_aircraft_onLoad

Description:
    Handles setting up the display, populating it with data and getting everything ready when the aircraft logibox menu is opened.

Arguments:
    _display - Display reference

Return Value:
    None

Example:
    (begin example)
        [] call mti_logistics_fnc_aircraft_onLoad;
    (end)

Author:
	Mokka
*/

disableSerialization;

params ["_display"];

private _logibox = uiNamespace getVariable QGVAR(logibox);
_logibox setVariable [QGVAR(display),_display];
_logibox setVariable [QGVAR(fnc_dialogPFH),QFUNC(aircraft_dialogPFH)];

if (isNil "_logibox") exitWith {
    ERROR_1("%1 could not find logibox reference, closing dialog",ACE_player);
    closeDialog 2;
};

// get ctrls
private _textSelectVehicle = _display displayCtrl IDC_RSCMTILOGIMENU_TEXTSELECTVEHICLE;
private _textSelectSkin = _display displayCtrl IDC_RSCMTILOGIMENU_TEXTSELECTSKIN;

private _textOutputArea = _display displayCtrl IDC_RSCMTILOGIMENU_TEXTOUTPUTAREA;
private _textAssetLimit = _display displayCtrl IDC_RSCMTILOGIMENU_TEXTASSETLIMIT;
private _textLogiboxStatus = _display displayCtrl IDC_RSCMTILOGIMENU_TEXTLOGIBOXSTATUS;
private _textConfigureLoadout = _display displayCtrl IDC_RSCMTILOGIMENU_TEXTCONFIGURELOADOUT;

private _textOutputAreaEdit = _display displayCtrl IDC_RSCMTILOGIMENU_TEXTOUTPUTAREAEDIT;
private _textAssetLimitEdit = _display displayCtrl IDC_RSCMTILOGIMENU_TEXTASSETLIMITEDIT;
private _textLogiboxStatusEdit = _display displayCtrl IDC_RSCMTILOGIMENU_TEXTLOGIBOXSTATUSEDIT;
private _checkboxConfigureLoadoutEdit = _display displayCtrl IDC_RSCMTILOGIMENU_CHECKBOXCONFIGURELOADOUTEDIT;

private _pictureVehiclePreview = _display displayCtrl IDC_RSCMTILOGIMENU_PICTUREVEHICLEPREVIEW;
private _listBoxVehicle = _display displayCtrl IDC_RSCMTILOGIMENU_LISTBOXVEHICLE;
private _listBoxSkin = _display displayCtrl IDC_RSCMTILOGIMENU_LISTBOXSKIN;

private _textProgress = _display displayCtrl IDC_RSCMTILOGIMENU_TEXTOPERATIONPROGRESS;
private _textBlocked = _display displayCtrl IDC_RSCMTILOGIMENU_TEXTOPERATIONBLOCKED;
private _barProgress = _display displayCtrl IDC_RSCMTILOGIMENU_PROGRESSOPERATIONPROGRESS;

_textSelectVehicle ctrlShow false;
_textSelectSkin ctrlShow false;
_textOutputArea ctrlShow false;
_textAssetLimit ctrlShow false;
_textLogiboxStatus ctrlShow false;
_textConfigureLoadout ctrlShow false;
_textOutputAreaEdit ctrlShow false;
_textAssetLimitEdit ctrlShow false;
_textLogiboxStatusEdit ctrlShow false;
_checkboxConfigureLoadoutEdit ctrlShow false;
_pictureVehiclePreview ctrlShow false;
_listBoxVehicle ctrlShow false;
_listBoxSkin ctrlShow false;
_textProgress ctrlShow false;
_textBlocked ctrlShow false;
_barProgress ctrlShow false;

// populate vehicle listbox
// todo: maybe outright hide assets with limit = 0?
[_display,_logibox] call FUNC(aircraft_updateVehLb);

_listBoxVehicle lbSetCurSel 0;

// update the remaining elements based on currently selected vehicle
[_listBoxVehicle, 0] call FUNC(aircraft_updateDialog);

// add vehicle list box EH
_listBoxVehicle ctrlAddEventHandler ["LBSelChanged", { _this call FUNC(aircraft_updateDialog); }];
