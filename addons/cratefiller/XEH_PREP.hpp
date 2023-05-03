PREP(preInit);
PREP(postInit);
PREP(handleBuildings), // Handles adding/removing of actions and handlers to cratefiller objects
PREP(addEquipment); // Adds one of the selected item to the inventory
PREP(createEquipmentList); // Changes the shown equipment category
PREP(createSubList); // Creates a list with valueable magazines or attachments
PREP(deleteCrate); // Deletes the nearest crate
PREP(deletePreset); // Deletes the selected preset
PREP(export); // Exports the active inventory
PREP(getConfigPath); // Gets the config path for the given classname
PREP(getGroups); // Gets all player groups and adds them to the listbox
PREP(getInventory); // Gets all inventory items of the active crate
PREP(getNearStorages); // Scans the spawn area for possible storages
PREP(getPlayerInventory); // Gets all weapons of the selected player
PREP(getPlayers); // Gets all players from the selected group and adds them to the listbox
PREP(getStorage); // Returns the active storage
PREP(import); // Imports the selected preset
PREP(manageActions); // Manages the actions
PREP(manageAceActions); // Manages the ACE actions
PREP(updateInteractionRange); // update interaction range of actions set on existing objects
PREP(openDialog); // Open the dialog
PREP(presets); // Creates the item presets
PREP(removeEquipment); // Removes the given amount of the selected item in the crate.
PREP(search); // Search for a weapon with the name entered in the search bar
PREP(setInventory); // Adds the items to the active crate
PREP(settings); // CBA settings
PREP(showInventory); // Displays the items of the active crate
PREP(showOverview); // Shows or hides the cratefiller overview display
PREP(showPresets); // Reads all saved presets and lists them.
PREP(sortList); // Sorts the displaynames of the given item array.
PREP(spawnCrate); // Spawns the selected crate