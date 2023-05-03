[
    QGVAR(spawnDuration),
    "SLIDER",
    ["Spawn Duration", "Duration in seconds it takes to spawn a vehicle/aircraft."],
    COMPONENT_NAME,
    [5,300,30,0,false],
    true,
	{},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(spawnCooldown),
    "SLIDER",
    ["Spawn Cooldown", "Cooldown in seconds between aircraft/vehicle spawns."],
    COMPONENT_NAME,
    [5,600,60,0,false],
    true,
	{},
    false
] call CBA_fnc_addSetting;
