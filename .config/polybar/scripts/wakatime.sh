#!/bin/sh

OUTPUT=$(wakatime --today)
if [ "$?" -gt "0" ]; then
    echo -e "%{F#be5046}\uf06a %{F-}"
else
    echo "$OUTPUT"
fi
