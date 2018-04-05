#!/bin/bash

#remember current path
MYSCRIPTSPATH=$PWD

WGETCMD=$(command -v wget | wc -l)

if [ "$WGETCMD" != "1" ]; then
  echo "wget not found! Exiting"
  exit
else
  echo "Grabbing newest AutohotKey" | tee -a mywinelog.txt
  wget https://autohotkey.com/download/ahk.zip -O $MYSCRIPTSPATH/ahk.zip && echo "Finished downloading autohotkey" | tee -a mywinelog.txt
fi

UNZIPCMD=$(command -v unzip | wc -l)

if [ "$UNZIPCMD" != "1" ]; then
  echo "unzip not found! Exiting"
  exit
else
  echo "Unpacking AutohotKey release" | tee -a mywinelog.txt
  unzip -o $MYSCRIPTSPATH/ahk.zip -d $MYSCRIPTSPATH/ahk && echo "Finished unpacking autohotkey" | tee -a mywinelog.txt
fi
