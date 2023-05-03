# MokTech-Core

## Introduction

This repository hosts the code-source for the core mod of MokTech Industries releases.

## Setting up your build environment

### 1. Prequisites

* Arma 3 (Steam)
* Arma 3 Tools (Steam)
* A text editor of your choice (eg. VS Code or Notepad++)
* ~50 GB of free space on any one hard-drive

### 2. Installing Mikero Tools

Download and install the following tools from this website: https://mikero.bytex.digital/Downloads

* Arma3P
* DeOgg
* DePbo
* DeRap
* Eliteness
* ExtractPbo
* MakePbo
* pboProject
* Rapify

Verify that you installed all the necessary components by running the pboProject program. If pboProject starts without error, the installation was successful.

### 3. Setting up the P: drive

#### Introduction

The **P**roject Drive is the main compoment of your dev environment. This is where you work on and build the mods.
By default, your P drive's files are located in `My Documents\Arma 3 Projects`, but you can use any other directory.
This tutorial will assume you use the default location, but the setup is the same for other directories.

#### Create virtual drive

Create a new file with the following contents:
```batch
@echo off
if exist p: (subst p: /d)
subst p: "C:\Users\Mokka\Documents\Arma 3 Projects"
```
make sure to replace the filepath above with your own equivalent and save it as `Mount P Drive.bat`. Make sure the new file actually has that extension.
Run your newly created batch file by double-clicking on it, now check if you can see a new drive called P.

Mounting your P drive is always the first step when you start working on your Arma Project. Make sure you run the .bat file before you do any work.

#### Extract Game data using Arma3P

**Make sure that your P drive is properly mounted!**

Run the Arma3P.cmd file in the Mikero installation directory (eg. `C:\Program Files (x86)\Mikero\DePboTools\bin`). Arma3P will first attempt to find your Arma 3 installation directory. Next, it will ask you which drive to extract the data to. If you followed the tutorial, press `P`.

Next, press `N` to start the extraction of the basic game data **without dubbing and map data** (that's a lot of bloat we don't need). This may take a while...

#### Extracting mod data

**Make sure that your P drive is properly mounted!**

Next, we have to extract some of the mod data to allow us to build ours. Create a new file with the following contents:
```batch
@echo off

rem Replace this path with the path to your Arma 3 Installation
set armapath=C:\Program Files (x86)\Steam\steamapps\common\Arma 3

rem Replace this path with the path to your Mikero installation
set mikeropath=C:\Program Files (x86)\Mikero\DePboTools\bin

rem DON'T NEED TO EDIT ANYTHING BELOW THIS LINE
rem ===========================================

set mod3as=%armapath%\!Workshop\@3AS (Beta Test)\addons
set modjlts=%armapath%\!Workshop\@Just Like The Simulations - The Great War\addons
set modlegion=%armapath%\!Workshop\@Legion Studios Base - Stable\addons
set mod3aster=%armapath%\!Workshop\@3AS Terrains (Beta)\addons
set modlegionbf=%armapath%\!Workshop\@Legion Studios - Star Wars Battlefields\addons
set modbiken=%armapath%\!Workshop\@LAGO Biken Anti-materiel rifle\addons
set modwbk=%armapath%\!Workshop\@Lightsabers and Force\addons

echo extracting 3AS...
"%mikeropath%\ExtractPbo.exe" "%mod3as%" P:\

echo extracting 3AS Terrains...
"%mikeropath%\ExtractPbo.exe" "%mod3aster%" P:\

echo extracting JLTS...
"%mikeropath%\ExtractPbo.exe" "%modjlts%" P:\

echo extracting Legion Base...
"%mikeropath%\ExtractPbo.exe" "%modlegion%" P:\

echo extracting Legion Battlefields...
"%mikeropath%\ExtractPbo.exe" "%modlegionbf%" P:\

echo extracting LAGO_Biken...
"%mikeropath%\ExtractPbo.exe" "%modbiken%" P:\

echo extracting Lightsabers and Force...
"%mikeropath%\ExtractPbo.exe" "%modwbk%" P:\

pause
```
and replace the two paths at the top of the file (**red the text behind the `rem`**) save it as `Extract Mod Data.bat`. Make sure the file actually has that extension.

Run your newly created Extract Mod Data.bat file by double-clicking it. If everything goes well, this will extract the contents of 3AS, JLTS, Legion, LAGO_Biken and WBK's Lightsabers and Force to your P drive. This data is required to build the mod.

### 4. Setting up Git

**Make sure that your P drive is properly mounted!**

#### Installation

Download and install Git for Windows from https://git-scm.com/download/win. During the installation process, make sure you also install the Git Credential Manager (included in the downloaded installer).

#### Clone Respositories

Create a new folder in your P: drive called `z`, so that you end up with `P:\z\`. Inside that folder (in the Windows File Explorer), right-click and select "Git Bash Here":

![](https://i.imgur.com/r5qK6CO.png)

Enter the following commands to clone the different repositories:

```sh
git clone https://github.com/Special-Operations-Brigade/MokTech-Core.git mti
git clone https://github.com/Special-Operations-Brigade/MokTech-Armoury.git mti_armoury
git clone https://github.com/Special-Operations-Brigade/MokTech-Factions.git mti_factions
```

Also download the ACE repository to your z folder, we need it to build the mod:

```sh
git clone https://github.com/acemod/ACE3.git ace
```

Additionally, create a new folder in your P: drive called `x`, so that you end up with `P:\x\`. Inside that folder (in the Windows File Explorer), right-click and select "Git Bash Here" and enter the following commands to clone the CBA repository:

```sh
git clone https://github.com/CBATeam/CBA_A3.git CBA
```

### 5. Setting up pboProject

#### Preparations

In your P drive, create three new folders:
```
@MokTech Industries - Core
@MokTech Industries - Armoury
@MokTech Industries - Factions
```

Each mod repository (mti, mti_armoury, mti_factions) contains a file called `mod.cpp`. Optionally, you can copy-paste this file into the newly-created @ folder of each mod (eg. copy `P:\z\mti\mod.cpp` to `P:\@MokTech Industries - Core\`).

Open pboProject, you should be greeted by these windows:

![](https://i.imgur.com/sDERzID.png)

First, click the Setup... button, and remove `*.hpp` from the "-X Exclude From Pbo" and "-B exclusions" text fields:

![](https://i.imgur.com/VM1gqQK.png)

Next, click on "Warnings are Errors" and check/uncheck boxes according to the screenshot below:

![](https://i.imgur.com/wmLih7I.png)

Lastly, press OK so you return to the main screen.

Make sure that "-Noisy to Log" is selected. "-K Sign Pbo(s)" does **not** need to be checked, you can ignore it.

#### Setting paths

Depending on which mod you want to build (Core/Armoury/Factions) you have to set slightly different paths in pboProject.

##### Core

* Click "-Mod Folder Output..." and select your newly created `@MokTech Industries - Core` folder
* Click "Source Folder..." and select `P:\z\mti\addons`

##### Amoury

* Click "-Mod Folder Output..." and select your newly created `@MokTech Industries - Armoury` folder
* Click "Source Folder..." and select `P:\z\mti_armoury\addons`

##### Factions

* Click "-Mod Folder Output..." and select your newly created `@MokTech Industries - Factions` folder
* Click "Source Folder..." and select `P:\z\mti_factions\addons`

#### Crunch Time

Press the big "Crunch" button. If everything was set up correctly to this point, you should get output similar to this: 

![](https://i.imgur.com/s6KM0LO.png)

#### Troubleshooting

If the build fails for whatever reason, pboProject will tell you which sub-mods did not get built correctly. You can then press the "View binlog(s)" button, which will open the folder containing the logs. Find the log file with a filename that corresponds to the addon that failed to build. The error that caused the fail is usually found at the bottom of the file.

Errors pertaining to "Missing file(s)" normally indicate, that one or multiple of the prequisite data extractions (or git repository clone) did not complete successfully.

### 6. Running with local mods

Once the build(s) were successful, you can load your own version of the mod as a Local Mod by pressing the corresponding button in the Arma Launcher:

![](https://i.imgur.com/wnzW2Av.png)

Navigate to your `@MokTech Industries - Core/Armoury/Factions` folder in the P drive.

**Make sure you unload the workshop version of the mod(s) when loading the local version!**
