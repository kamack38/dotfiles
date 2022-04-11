#!/bin/bash

HELPER="paru"

$HELPER -S --noconfirm --needed --quiet asusctl \
    alsa-tools \
    optimus-manager \
    optimus-manager-qt \
    openrgb

# slow internet
# sudo sysctl net.ipv4.tcp_ecn=0

# nivida
# sudo mkinitcpio -P
