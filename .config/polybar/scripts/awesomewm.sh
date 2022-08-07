#!/bin/env bash

while getopts 'l' OPTION; do
    case "$OPTION" in
    l)
        # Get current layout name
        layout_name=$(awesome-client 'return mouse.screen.selected_tag.layout.name' | sed 's/string //; s/"//g')
        echo ${layout_name^^}
        ;;
    ?)
        echo "script usage: $(basename $0) [-l]" >&2
        exit 1
        ;;
    esac
done