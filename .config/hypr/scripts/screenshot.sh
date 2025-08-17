#!/bin/bash

SELECTION=$(echo -e "Capture FullScreen\nCapture Region"| tofi)
PNAME=~/Pictures/$(date +"%Y-%m-%d_%H-%M-%S")".png" 
case $SELECTION in 
"Capture FullScreen")
    sleep 0.7
    grim $PNAME && wl-copy < $PNAME && notify-send "ScreenShot" "Successfully! Saved into $PNAME" 
    ;;
"Capture Region" )
    slurp | grim -g - $PNAME && wl-copy < $PNAME &&  notify-send "ScreenShot" "Successfully! Saved into $PNAME" 
    ;;
* )
    echo "Other"
    ;;
esac

