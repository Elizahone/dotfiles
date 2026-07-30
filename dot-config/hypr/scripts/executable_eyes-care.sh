#!/bin/bash

if pgrep "gammastep" > /dev/null
then
  killall gammastep
else
  gammastep -m wayland -O 5000&
fi
