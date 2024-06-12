#!/bin/bash

SELECTION=$(echo -e "Capture FullScreen\nCapture Region"| tofi
PNAME=~/Pictures/ScreenShots/$(date +"%Y-%m-%d_%H-%M-%S")".png" 
case $SELECTION in 
"Capture FullScreen")
    sleep 0.7
    grim $PNAME && wl-copy < $PNAME && hyprctl notify -1 600 "rgb(FFFFFF)" "fontsize:20 Screen Capture Successfully"
    ;;
"Capture Region")
    slurp | grim -g - $PNAME && wl-copy < $PNAME && hyprctl notify -1 600 "rgb(FFFFFF)" "fontsize:20 Screen Capture Successfully"
    ;;
* )
    echo "Other"
    ;;
esac

