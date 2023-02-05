#!/bin/bash

~/.config/polybar/scripts/gmail/launch.py -c '' -p '' | sed 's/%{F.*}//' -u
