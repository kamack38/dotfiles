#!/bin/bash

sudo pacman -Sy alsa-tools --noconfirm
yay -S asusctl --noconfirm --nodiffmenu --noeditmenu --nouseask --nocleanmenu --noupgrademenu
yay -S optimus-manager-qt --noconfirm --nodiffmenu --noeditmenu --nouseask --nocleanmenu --noupgrademenu
yay -S openrgb --noconfirm --nodiffmenu --noeditmenu --nouseask --nocleanmenu --noupgrademenu

# slow internet
# sudo sysctl net.ipv4.tcp_ecn=0

# nivida
# sudo mkinitcpio -P
