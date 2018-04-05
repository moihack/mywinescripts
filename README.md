# mywinescripts
a simple WINE automation script

Entry point is mywine.sh shell script

This script will try to download and then compile the latest wine source code (actually it downloads and compiles 3.5 branch at the time of writing this) available at that time. Note that the script does not do any dependency check and if build dependencies are not met you'll most probably face an error early on execution.

Also note that even if the code successfully compiles you may still be missing some runtime dependencies.
Now, since this script was written with my Arch Linux system in mind, it is best to first install Wine from the official repositories to make sure all runtime dependencies are met and then simply do : #pacman -R wine , to remove Wine but leaving all dependencies installed. Make sure to also install wget and unzip so the script can grab and unpack the latest version of AutoHotkey.

After successfully compiling the code, the script will try to automatically and silently install DevilMayCry 4(you should have the installation files in the following path: ~/dmc4/setup_files ).

Afterwards AutoHotkey will be fetched and unpacked by launching the getahk.sh shell script.

Finally we launch our DevilMayCry4 specific AutoHotkey script (dmc4.ahk) in the background with our freshly compiled Wine and launch the game outputting the fps from winedebug to a logfile (still no parsing of written fps values implemented). 

Please do NOTE that this script installs and attemps to run the retail 1.0.0 SecuROM version, so the original retail disc has to be inserted in the disc tray at the very least when installation of the game finished. Otherwise the game won't boot and everything will fail afterwards.

##################################################################################################

TODO LIST:

i) parse the fps output and produce a useful metric (like average fps - we could even write a small python script for this task since bash is kinda weak with arithmetic expressions and even more with ones containing floats)
ii) maybe implement some sort of better error handling? right now the script does check for very few things if they are in place and just populates a simple log file to check till where it was able to run.
iii) implement some sort of build-time dependency management?

FURTHER IDEAS AND IMPROVEMENTS:

i) we could allow for the whole benchmark to run and instead of parsing FPS output from wine we could just grab a screenshot when the benchmark finishes running. We could even try to parse the results image with an OCR library in python in order to get text results (don't know if this is actually possible due to the OCR library may not being able to recognize the 'cool' DMC fonts used).
