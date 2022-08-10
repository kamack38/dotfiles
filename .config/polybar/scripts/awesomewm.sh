#!/bin/env bash

OUTPUT=""
# OUTPUT_PREFIX="%{B#FF9677} "
# OUTPUT_SUFFIX=" %{B-}"

while getopts 'lf' OPTION; do
    case "$OPTION" in
    l)
        # Get current layout name
        layout_name=$(awesome-client 'return mouse.screen.selected_tag.layout.name' | sed 's/.*string //; s/"//g')
        OUTPUT+="${layout_name^^}"
        ;;
    f)
        # Show floating mode
        floating_mode=$(awesome-client 'return mouse.current_client.floating' | sed 's/.*boolean //')
        if [[ $floating_mode == 'true' ]]; then
            OUTPUT+=":F"
        fi
        ;;
    ?)
        echo "script usage: $(basename $0) [-l] [-f]" >&2
        exit 1
        ;;
    esac
done

if [[ "$OUTPUT" != "" ]]; then
    echo "${OUTPUT_PREFIX}${OUTPUT}${OUTPUT_SUFFIX}"
fi
