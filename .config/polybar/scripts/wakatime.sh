#!/bin/sh

OUTPUT=$(wakatime --today 2>/dev/null)
if [ "$?" -gt "0" ]; then
    echo -e "%{F#be5046}\uf06a %{F-}"
else
    echo "$OUTPUT"
fi
