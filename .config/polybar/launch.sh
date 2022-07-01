#!/usr/bin/env bash

debug_level='notice'
reload=''

while getopts 'rd:' OPTION; do
    case "$OPTION" in
    d)
        debug_level="$OPTARG"
        ;;
    r)
        reload='-r'
        echo "Reload is enabled!"
        ;;
    ?)
        echo "script usage: $(basename $0) [-r] [-d <error|warning|notice|info|trace>]" >&2
        exit 1
        ;;
    esac
done

echo "The debug level is $debug_level"

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/km38-top.log /tmp/km38-btm.log

polybar km38-top $reload --log="$debug_level" 2>&1 | tee -a /tmp/km38-top.log &
disown
polybar km38-btm $reload --log="$debug_level" 2>&1 | tee -a /tmp/km38-btm.log &
disown

echo "Bars launched..."
