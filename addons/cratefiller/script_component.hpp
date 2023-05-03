#define COMPONENT cratefiller
#include "\z\KPCF\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_CRATEFILLER
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_CRATEFILLER
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CRATEFILLER
#endif

#include "\z\KPCF\addons\main\script_macros.hpp"

// Cratefiller get var
#define CGVAR(var, defVal)      (GVAR(data) getVariable [var, defVal])
// Cratefiller set var
#define CSVAR(var, val)         (GVAR(data) setVariable [var, val, true])

// Cratefiller cache get var
#define CCGVAR(var, defVal)     (GVAR(cache) getVariable [var, defVal])
// Cratefiller cache set var
#define CCSVAR(var, val, pub)   (GVAR(cache) setVariable [var, val, pub])
