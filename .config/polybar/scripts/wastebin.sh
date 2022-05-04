#!/usr/bin/env bash

trashsize=$(du -sh $HOME/.local/share/Trash/ | awk '{ print $1}')
if [ $(echo $trashsize | sed 's/[^0-9]*//g') -gt 0 ]; then
    echo "$trashsize"
else
    echo ""
fi