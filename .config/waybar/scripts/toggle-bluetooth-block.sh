#!/bin/bash

if rfkill list bluetooth | grep -q 'blocked: yes'; then
	rfkill unblock bluetooth
else
	rfkill block bluetooth
fi
