#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    Author: Dubjunk - https://github.com/KillahPotatoes
    Mod'ification: Cat Harsis
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
*/


class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "KPCF_main" };
        authors[] = {"Dubjunk", "Cat Harsis"};
        VERSION_CONFIG;
    };
};

// Configs
#include "CfgEventHandlers.hpp"

// UI
#include "ui\KPGUI\KPGUI_defines.hpp"
#include "ui\defines.hpp"
#include "ui\KP_cratefiller_dialog.hpp"
