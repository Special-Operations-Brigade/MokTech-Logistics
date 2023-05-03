#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KPCF_cratefiller_fnc_showOverview

    File: fnc_showOverview.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-01-21
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Shows or hides the cratefiller overview display.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlOverviewGroup = _dialog displayCtrl KP_CRATEFILLER_IDC_GROUPOVERVIEW;

_ctrlOverviewGroup ctrlShow ([true, false] select (ctrlShown _ctrlOverviewGroup));

[] call FUNC(getGroups);

true
