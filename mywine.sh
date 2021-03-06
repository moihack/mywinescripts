#!/bin/bash

#uncomment if you want to delete your current wine prefix as well
#rm -rf '~/.wine';

rm -rf 'wine-auto-dirs'
rm 'mywinelog.txt'

GITCMD=$(command -v git | wc -l)

if [ "$GITCMD" != "1" ]; then
  echo "git not found! Exiting"
  exit
else
  echo "Cloning wine repo" | tee -a mywinelog.txt
  git clone git://source.winehq.org/git/wine.git -b wine-3.5 $PWD/wine-auto-dirs/wine-source && echo "cloning completed" | tee -a mywinelog.txt
fi

cd wine-auto-dirs

CCACHECMD=$(command -v ccache | wc -l)

if [ "$CCACHECMD" != "1" ]; then
  echo "ccache not found! Building without ccache support" | tee -a ../mywinelog.txt
else
  echo "Building with CCache support" | tee -a ../mywinelog.txt
  export PATH="/usr/lib/ccache/bin/:$PATH"
fi

echo "Checking OS architecture" | tee -a ../mywinelog.txt

OSARCH=$(uname -m)

#do other distros return sth like amd64?
#Arch is always x86_64 anyways since 32bit support was droppped
if [ "$OSARCH" = "x86_64" ]; then
  echo "Building wine for 64bit!" | tee -a ../mywinelog.txt
  rm -rf wine32-build wine64-build
  mkdir wine32-build wine64-build
  echo "Created build directories" | tee -a ../mywinelog.txt
  cd wine64-build
  echo "Configuring Wine64 build" | tee -a ../../mywinelog.txt
  ../wine-source/configure --prefix=/usr --libdir=/usr/lib --with-x --with-gstreamer --enable-win64 &&
  #$CORES=$(nproc)
  echo "Starting Wine64 build" | tee -a ../../mywinelog.txt
  sleep 3
  make -j5 &&
  echo "Wine64 build finished" | tee -a ../../mywinelog.txt &&
  cd ../wine32-build
  echo "Configuring Wine 32bit counterpart build" | tee -a ../../mywinelog.txt
  PKG_CONFIG_PATH="/usr/lib32/pkgconfig" ../wine-source/configure --prefix=/usr --with-x --with-gstreamer --libdir=/usr/lib32 --with-wine64=../wine64-build &&
  echo "Starting Wine 32bit counterpart build" | tee -a ../../mywinelog.txt
  sleep 3
  make -j5 &&
  echo "Wine32 build counterpart finished" | tee -a ../../mywinelog.txt &&
  cd ../..
else
  echo "Building wine for 32bit only!" | tee -a ../mywinelog.txt
  rm -rf wine32-build
  mkdir wine32-build
  echo "Created build directory" | tee -a ../mywinelog.txt
  #TODO! plain 32bit build
fi

#remember current path
MYSCRIPTSPATH=$PWD

chmod +x $PWD/getdemo.sh
./getdemo.sh

if [ -f "DevilMayCry4_Benchmark.exe" ]; then
  echo "Installing Devil May Cry 4 benchmark..." | tee -a mywinelog.txt &&
  #maybe do the silent installation with a .bat file instead so it is more Windowsy?
  #don't prompt for Gecko/.NET
  #/S is silent /V and afterwards are the options to pass to the built-in .msi installer
  export WINEDLLOVERRIDES="mscoree,mshtml="
  $PWD/wine-auto-dirs/wine64-build/wine $MYSCRIPTSPATH/DevilMayCry4_Benchmark.exe /S /v/qn &&
  echo "Finished installing Devil May Cry 4 benchmark..." | tee -a mywinelog.txt
  #make game settings read only
  #create game settings path
  #copy game settings
  chmod 444 config.ini
  mkdir -p "$HOME/.wine/drive_c/users/$USER/Local Settings/Application Data/CAPCOM/DEVILMAYCRY4_BENCHMARK/"
  cp config.ini "$HOME/.wine/drive_c/users/$USER/Local Settings/Application Data/CAPCOM/DEVILMAYCRY4_BENCHMARK/config.ini"
fi

#return to repo root folder
cd $MYSCRIPTSPATH
#download and unpack ahk
chmod +x $PWD/getahk.sh
./getahk.sh

echo "Starting autohotkey in the background ..." | tee -a mywinelog.txt &&
export WINEDLLOVERRIDES="mscoree,mshtml=" 
$PWD/wine-auto-dirs/wine64-build/wine $PWD/ahk/AutoHotKeyU64.exe $PWD/dmc4.ahk &

#make sure to change to the directory where the main executable is located
#for some reason the game will boot to a black screen when launched from another path
#also tried with wine 3.5 from official Arch repos
#if the Launcher is used instead it boots fine
#(probably because the launcher chain-loads the proper .exe from its path)

cd "$HOME/.wine/drive_c/Program Files (x86)/CAPCOM/DEVILMAYCRY4_BENCHMARK"
echo "Launching Benchmark ..." | tee -a mywinelog.txt &&
#Launch Benchmark! Output only FPS to log file
export WINEDLLOVERRIDES="mscoree,mshtml=" 
WINEDEBUG=-all,+fps $MYSCRIPTSPATH/wine-auto-dirs/wine64-build/wine DevilMayCry4_Benchmark_DX9.exe >> $MYSCRIPTSPATH/fps.log 2>&1
