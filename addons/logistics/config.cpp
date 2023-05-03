#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            "MTI_LogiBox_aircraft",
            "MTI_LogiBox_vehicles",
            "MTI_LogiBox_crates",
            "MTI_LogiBox_aircraft_alt",
            "MTI_LogiBox_vehicles_alt",
            "MTI_LogiBox_crates_alt"
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mti_logistics_main"};
        author = AUTHOR;
        authors[] = {""};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
#include "CfgScriptPaths.hpp"

#include "ui\idDefines.hpp"
#include "ui\rscDefines.hpp"
#include "ui\RscMTILogiMenuAircraft.hpp"
#include "ui\RscMTILogiMenuVehicle.hpp"
#include "ui\RscMTILogiBoxScreen.hpp"

#include "MTI_Logistics_Config.hpp"
