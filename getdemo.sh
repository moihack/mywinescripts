#!/bin/bash

#remember current path
MYSCRIPTSPATH=$PWD

WGETCMD=$(command -v wget | wc -l)

if [ "$WGETCMD" != "1" ]; then
  echo "wget not found! Exiting"
  exit
else
  echo "Downloading Devil May Cry 4 Benchmark setup file" | tee -a mywinelog.txt
  wget http://de2-dl.techpowerup.com/files/DevilMayCry4_Benchmark.exe && 
  echo "Finished downloading Devil May Cry 4 benchmark" | tee -a mywinelog.txt
fi
