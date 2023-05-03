#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    Author: Dubjunk - https://github.com/KillahPotatoes
    Mod'ification: Cat Harsis
    Further modified by: Mokka
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
*/


class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "mti_logistics_main","mti_logistics_logistics" };
        author = AUTHOR;
        authors[] = {"Dubjunk", "Cat Harsis"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

// Configs
#include "CfgEventHandlers.hpp"

// UI
#include "ui\KPGUI\KPGUI_defines.hpp"
#include "ui\defines.hpp"
#include "ui\KP_cratefiller_dialog.hpp"
