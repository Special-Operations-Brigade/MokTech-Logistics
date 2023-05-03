#include "script_component.hpp"
#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KPCF_cratefiller_fnc_getGroups

    File: fnc_getGroups.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-01-21
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Gets all player groups and adds them to the listbox.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlGroups = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOGROUPS;

// Clear the lists
lbClear _ctrlGroups;

// Get all player groups
private _groups = createHashMap;
private _allPlayersNoHeadless = allPlayers - (entities "HeadlessClient_F");
{
    private _side = _x;
    private _sidePlayers = _allPlayersNoHeadless select { side _x isEqualTo _side};
    private _sideGroups = [];
    {
        _sideGroups pushBackUnique group _x;
    } forEach _sidePlayers;

    _sideGroups = _sideGroups - [grpNull];
    _sideGroups sort true;
    _groups set [_side, _sideGroups];
} foreach [west,east,independent];
// Cache the groups
CCSVAR("groups", _groups, false);

// Fill the list
{
    _index = _ctrlGroups lbAdd groupId _x;
} forEach _groups getOrDefault [side player,[]];

true
