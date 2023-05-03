#include "script_component.hpp"
#include "..\ui\idDefines.hpp"
/*
Function: mti_logistics_fnc_dialogPFH

Description:
    PFH that runs some recurring checks on the logibox dialog.

Arguments:
    _display - Display reference
    _logibox - LogiBox reference

Return Value:
    None

Example:
    (begin example)
        [] call mti_logistics_fnc_dialogPFH;
    (end)

Author:
	Mokka
*/

disableSerialization;

params ["_display","_logibox"];

//TRACE_CHAT_2("pfh params",_display,_logibox);
TRACE_2("pfh params",_display,_logibox);

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

private _buttonOK = _display displayCtrl IDC_RSCMTILOGIMENU_BUTTONOK;
private _buttonCancel = _display displayCtrl IDC_RSCMTILOGIMENU_BUTTONCANCEL;

// get other vars
private _inProgress = _logibox getVariable [QGVAR(inProgress),false];
private _inProgressTime = _logibox getVariable [QGVAR(inProgressTime),[0,0]];
private _paused = _logibox getVariable [QGVAR(paused),false];
private _deployedHash = _logibox getVariable [QGVAR(deployedHash),createHashMap];
private _coolDown = _logibox getVariable [QGVAR(cooldown),0];
private _owner = _logibox getVariable [QGVAR(owner),ACE_Player];
private _outputClear = _logibox getVariable [QGVAR(outputClear),false];
private _curSel = lbCurSel _listBoxVehicle;

TRACE_7("logibox vars",_inProgress,_inProgressTime,_deployedHash,_coolDown,_owner,_outputClear,_curSel);

// ctrl visibility based on progress status
_textSelectVehicle ctrlShow !(_inProgress);
_textSelectSkin ctrlShow !(_inProgress);
_textOutputArea ctrlShow !(_inProgress);
_textAssetLimit ctrlShow !(_inProgress);
_textLogiboxStatus ctrlShow !(_inProgress);
_textConfigureLoadout ctrlShow !(_inProgress);
_textOutputAreaEdit ctrlShow !(_inProgress);
_textAssetLimitEdit ctrlShow !(_inProgress);
_textLogiboxStatusEdit ctrlShow !(_inProgress);
_checkboxConfigureLoadoutEdit ctrlShow !(_inProgress);
_pictureVehiclePreview ctrlShow !(_inProgress);
_listBoxVehicle ctrlShow !(_inProgress);
_listBoxSkin ctrlShow !(_inProgress);

_textProgress ctrlShow _inProgress;
_textBlocked ctrlShow (_inProgress && _paused);
_barProgress ctrlShow _inProgress;

// if operation in progress, handle that instead
if (_inProgress) exitWith {
    private _progress = linearConversion [
        _inProgressTime select 0,
        _inProgressTime select 1,
        CBA_missionTime,
        0, 1, false
    ];

    if (_paused) then {
        _textBlocked ctrlSetTextColor [COLOUR_LOGIBOX_RED_RGBA];
    };

    _barProgress progressSetPosition _progress;
    _buttonOK ctrlEnable false;
};

// checks
private _statusExit = false;

// output area
if !(_outputClear) then {
    _textOutputAreaEdit ctrlSetText "Blocked";
    _textLogiboxStatusEdit ctrlSetText "Output Area Blocked";
    _textOutputAreaEdit ctrlSetTextColor [COLOUR_LOGIBOX_RED_RGBA];
    _textLogiboxStatusEdit ctrlSetTextColor [COLOUR_LOGIBOX_RED_RGBA];
    _statusExit = true;
} else {
    _textOutputAreaEdit ctrlSetText "Clear";
    _textOutputAreaEdit ctrlSetTextColor [COLOUR_LOGIBOX_GREEN_RGBA];
};

// on cooldown
if (_coolDown > CBA_missionTime) then {
    _textLogiboxStatusEdit ctrlSetText format ["On Cooldown For %1s",round(_coolDown - CBA_missionTime)];
    _textLogiboxStatusEdit ctrlSetTextColor [COLOUR_LOGIBOX_YELLOW_RGBA];
    _statusExit = true;
};

// logibox status
if (_owner isNotEqualTo ACE_player) then {
    _textLogiboxStatusEdit ctrlSetText format ["In Use By: %1",name _owner];
    _textLogiboxStatusEdit ctrlSetTextColor [COLOUR_LOGIBOX_RED_RGBA];
    _statusExit = true;
};

// check for invalid selection
if (_curSel < 0) then {
    _textLogiboxStatusEdit ctrlSetText "Invalid Selection";
    _textLogiboxStatusEdit ctrlSetTextColor [COLOUR_LOGIBOX_RED_RGBA];
    _statusExit = true;
};

// we have to do a staggered exit check since we *need* to have a valid selection to verify limit etc
// so exit now if desired, reset the check variable and then do one more check for the limit
if (_statusExit) exitWith { _buttonOK ctrlEnable false; };

// currently selected
private _curSelVehicle = _listBoxVehicle lbData _curSel;

private _limit = ["Aircraft",_curSelVehicle,"limit"] call FUNC(getConfigProperty);
private _deployed = _deployedHash getOrDefault [_curSelVehicle,0];

//TRACE_CHAT_3("limit check",_limit,_deployed,_curSelVehicle);
TRACE_3("limit check",_limit,_deployed,_curSelVehicle);

if ((_limit >= 0) && {_deployed >= _limit}) exitWith {
    _textLogiboxStatusEdit ctrlSetText "Asset Limit Reached";
    _textLogiboxStatusEdit ctrlSetTextColor [COLOUR_LOGIBOX_RED_RGBA];
    _buttonOK ctrlEnable false;
};

// all good
uiNamespace setVariable [QGVAR(selectedVehicle),_curSelVehicle];
uiNamespace setVariable [QGVAR(selectedSkin),_listBoxSkin lbData (lbCurSel _listBoxSkin)];
uiNamespace setVariable [QGVAR(configureLoadout),cbChecked _checkboxConfigureLoadoutEdit];

_textLogiboxStatusEdit ctrlSetText "Ready";
_textLogiboxStatusEdit ctrlSetTextColor [COLOUR_LOGIBOX_GREEN_RGBA];
_buttonOK ctrlEnable true;
