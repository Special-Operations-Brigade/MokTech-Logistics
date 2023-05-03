#define COMPONENT logistics
#define COMPONENT_BEAUTIFIED Logistics
#include "\z\mti_logistics\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_LOGISTICS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_LOGISTICS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_LOGISTICS
#endif

#define CONST_LOADOUT_CONFIG_MAX_DIST 100

#define COLOUR_LOGIBOX_AREA_BLOCKED "#(argb,8,8,3)color(0.415,0.1,0,0.5,ca)"
#define COLOUR_LOGIBOX_AREA_CLEAR "#(argb,8,8,3)color(0.242,0.578,0.162,0.5,ca)"

#include "\z\mti_logistics\addons\main\script_macros.hpp"
