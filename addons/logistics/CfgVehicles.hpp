class CBA_Extended_EventHandlers_base;

class CfgVehicles {
    class Slingload_01_Base_F;
    class MTI_LogiBox_base: Slingload_01_Base_F {
        scope = 1;
        scopecurator = 1;
        author = AUTHOR;
        displayName = "[SOB] LogiBox";
        hiddenSelections[] = {"camo1","console","screen"};

        placement = "vertical";
        mapSize = 1;
        destrType = "DestructNo";
        editorCategory = "MTI_Common";
        editorSubcategory = "MTI_Logistics";
        faction = "prop";
        maximumLoad = 0;
        eden = 1;
        disableInventory = 1;

		ace_cargo_hasCargo = 0;
        ace_cargo_canLoad = 1;
		ace_cargo_size = 100;

        class VehicleTransport {
            class Cargo {
                parachuteClass = "B_Parachute_02_F";
                parachuteHeightLimit = 5;
                canBeTransported = 1;
                dimensions[] = {"BBox_1_1_pos", "BBox_1_2_pos"};
            };
        };

        EGVAR(aircraft,laatc_canBeLoaded) = 1;
        EGVAR(aircraft,laatc_loadedSize) = 3;
        EGVAR(aircraft,laatc_loadVars) = "[[[0,-4,-8.5]], [-0.001], [-1.05]]";

        class SimpleObject {
            animate[] = {{"", 0}};
            eden = 1;
            verticalOffset = 0;
        };

        class AnimationSources {
            class drawer_translation {
                source = "user";
                animPeriod = 5;
                initPhase = 0;
            };
        };

        class EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };

        class UserActions {
            class OpenMenu {
                displayName = "Open LogiBox Menu";
                position = "interaction_point";
                radius = 4;
                condition = QUOTE([this] call FUNC(canOpenDialog));
                statement = QUOTE([this] call FUNC(openDialog));
                onlyforplayer = 0;
            };
        };
    };

    class MTI_LogiBox_aircraft: MTI_LogiBox_base {
        scope = 2;
        scopeCurator = 2;
        displayName = "[SOB] LogiBox Aircraft (Left)";

        GVAR(dialog) = "RscMTILogiMenuAircraft";

        model = QPATHTOF(logibox_aircraft);
        hiddenSelectionsTextures[] = {
            QPATHTOF(data\camo1_co.paa),
            QPATHTOF(data\console_co.paa),
            "#(argb,8,8,3)color(0.000,0.000,0.000,1.0,co)"
        };
    };

    class MTI_LogiBox_vehicles: MTI_LogiBox_base {
        scope = 2;
        scopeCurator = 2;
        displayName = "[SOB] LogiBox Vehicles (Left)";

        GVAR(dialog) = "RscMTILogiMenuVehicle";

        model = QPATHTOF(logibox_vehicles);
        hiddenSelectionsTextures[] = {
            QPATHTOF(data\camo1_blue_co.paa),
            QPATHTOF(data\console_co.paa),
            "#(argb,8,8,3)color(0.000,0.000,0.000,1.0,co)"
        };
    };

    class MTI_LogiBox_crates: MTI_LogiBox_base {
        scope = 2;
        scopeCurator = 2;
        displayName = "[SOB] LogiBox Crates (Left)";

        GVAR(dialog) = QEGVAR(logistics_cratefiller,dialog);

        model = QPATHTOF(logibox_crates);
        hiddenSelectionsTextures[] = {
            QPATHTOF(data\camo1_green_co.paa),
            QPATHTOF(data\console_co.paa),
            "#(argb,8,8,3)color(0.000,0.000,0.000,1.0,co)"
        };
    };

    class MTI_LogiBox_aircraft_alt: MTI_LogiBox_aircraft {
        displayName = "[SOB] LogiBox Aircraft (Right)";

        model = QPATHTOF(logibox_aircraft_alt);
    };

    class MTI_LogiBox_vehicles_alt: MTI_LogiBox_vehicles {
        displayName = "[SOB] LogiBox Vehicles (Right)";

        model = QPATHTOF(logibox_vehicles_alt);
    };

    class MTI_LogiBox_crates_alt: MTI_LogiBox_crates {
        displayName = "[SOB] LogiBox Crates (Right)";

        model = QPATHTOF(logibox_crates_alt);
    };

    class Thing;
    class GVAR(helper_base): Thing {
        scope = 1;
        scopeCurator = 1;
        simulation = "thing";
        animated = 0;
        mapSize = 0.1;
        displayName = "[SOB] LogiBox Helper";
        accuracy = 0.2;
        icon = "iconObject_circle";
        class DestructionEffects
        {
        };

        hiddenSelections[] = {"helper"};
    };

    class GVAR(helper_crates): GVAR(helper_base) {
        model = QPATHTOF(helper_crates);
        hiddenSelectionsTextures[] = {
            COLOUR_LOGIBOX_AREA_BLOCKED
        };
    };

    class GVAR(helper_vehicles): GVAR(helper_base) {
        model = QPATHTOF(helper_vehicles);
        hiddenSelectionsTextures[] = {
            COLOUR_LOGIBOX_AREA_BLOCKED
        };
    };

    class GVAR(helper_aircraft): GVAR(helper_base) {
        model = QPATHTOF(helper_aircraft);
        hiddenSelectionsTextures[] = {
            COLOUR_LOGIBOX_AREA_BLOCKED
        };
    };
};
