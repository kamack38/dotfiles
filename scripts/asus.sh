#!/bin/bash

set -e
# Colours
BLACK=$'\e[0;30m'
WHITE=$'\e[0;37m'
BWHITE=$'\e[1;37m'
RED=$'\e[0;31m'
BLUE=$'\e[0;34m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
NC=$'\e[0m' # No Colour

# Default vars
HELPER="paru"

PACKAGES=(
	"asusctl"                   # Asus drivers and management
	"nvidia-prime"              # Offload to an NVIDIA GPU
	"batsignal"                 # A lightweight battery monitor daemon
	"preload"                   # Makes applications run faster by prefetching binaries and shared objects
	"irqbalance"                # IRQ balancing daemon for SMP systems
	"ananicy-cpp"               # Autonice daemon, featuring lower CPU and RAM usage.
	"cachyos-ananicy-rules-git" # CachyOS - ananicy-rules
	"btrfsmaintenance"          # Btrfs maintenance scripts
	"profile-sync-daemon"       # Symlinks and syncs browser profile dirs to RAM
	"systemd-oomd-defaults"     # Configuration files for systemd-oomd
	# "rog-control-center" # GUI for asusctl
	# "supergfxctl"        # Tool to change the optimus mode
)

KERNEL_PACKAGES=(
	"linux-g14" # Custom kernel with patches for asus laptops
	"linux-g14-headers"
)

# Add asusctl repository
source "$HOME/scripts/repos.sh"
g14

# Refresh repositories
echo "${BLUE}:: ${BWHITE}Refreshing repositories...${NC}"
sudo pacman -Syy

# Remove default kernel
read -rp "${YELLOW}:: ${BWHITE}Do you want to install the ${BLUE}g14 kernel${BWHITE} and remove the default one? [Y/n]${NC}: " replace_kernel
if [[ ! $replace_kernel == n* ]]; then
	echo "${GREEN}:: ${BWHITE}Replacing ${BLUE}kernels${BWHITE}...${NC}"
	sudo pacman -Rdd --noconfirm linux linux-headers
	PACKAGES+=("${KERNEL_PACKAGES[@]}")
fi

# Install packages
echo "${BLUE}:: ${BWHITE}Installing packages...${NC}"
$HELPER -S --noconfirm --needed --quiet "${PACKAGES[@]}"

# Enable daemons
echo "${BLUE}:: ${BWHITE}Enabling daemons...${NC}"
sudo systemctl enable --now asusd.service
systemctl enable --now --user batsignal.service

# Set keyboard light
echo "${BLUE}:: ${BWHITE}Setting keyboard light...${NC}"
asusctl aura rainbow-wave -d right -s low
asusctl -k off

echo "${BLUE}:: ${BWHITE}Fixing sound...${NC}"
sudo tee /etc/modprobe.d/hda-jack-retask.conf >/dev/null <<EOF
options snd-hda-intel patch=hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw
EOF

sudo tee /lib/firmware/hda-jack-retask.fw >/dev/null <<EOF
[codec]
0x10ec0285 0x10431602 0

[pincfg]
0x12 0x90a60140
0x13 0x40000000
0x14 0x90170152
0x16 0x411111f0
0x17 0x90170110
0x18 0x411111f0
0x19 0x03a19020
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x40663a45
0x1e 0x90170151
0x21 0x03211020
EOF

echo "${BLUE}:: ${BWHITE}Running mkinitcpio...${NC}"
sudo mkinitcpio -P

# Fix slow internet
# sudo sysctl net.ipv4.tcp_ecn=0

# Powersave Tweaks
echo "${BLUE}:: ${BWHITE}Applying ${BLUE}powersave tweaks${BWHITE}...${NC}"

# Disable NMI Watchdog
# - The NMI watchdog is a debugging feature to catch hardware hangs that cause a kernel panic. On some systems it can generate a lot of interrupts, causing a noticeable increase in power usag
sudo tee /etc/sysctl.d/disable_nmi_watchdog.conf >/dev/null <<EOF
kernel.nmi_watchdog = 0
EOF

# Suspend when battery is at 2%
sudo tee /etc/udev/rules.d/50-powersave-suspend.rules >/dev/null <<EOF
# Suspend when battery is at 2%
SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="2", RUN+="/usr/bin/systemctl suspend"
EOF

sudo tee /etc/udev/rules.d/99-disable-services-on-battery.rules >/dev/null <<EOF
# Disable unessential services when on battery

# Disable irqbalance
# Disabling distributing interrupts across multiple cores allows them to enter deeper sleep states, thus preserving battery
ACTION=="change", SUBSYSTEM=="power_supply", ATTRS{type}=="Mains", ATTRS{online}=="0", RUN+="/usr/bin/systemctl stop irqbalance.service"
ACTION=="change", SUBSYSTEM=="power_supply", ATTRS{type}=="Mains", ATTRS{online}=="1", RUN+="/usr/bin/systemctl start irqbalance.service"

# Disable Profile-Sync-Daemon
ACTION=="change", SUBSYSTEM=="power_supply", ATTRS{type}=="Mains", ATTRS{online}=="0", RUN+="/usr/bin/systemctl --user --machine kamack38@ stop psd.service"
ACTION=="change", SUBSYSTEM=="power_supply", ATTRS{type}=="Mains", ATTRS{online}=="1", RUN+="/usr/bin/systemctl --user --machine kamack38@ start psd.service"

# Optimise user settings via a service
ACTION=="change", SUBSYSTEM=="power_supply", ATTRS{type}=="Mains", ATTRS{online}=="0", RUN+="/usr/bin/systemctl --user --machine kamack38@ start battery.service"
ACTION=="change", SUBSYSTEM=="power_supply", ATTRS{type}=="Mains", ATTRS{online}=="1", RUN+="/usr/bin/systemctl --user --machine kamack38@ start ac.service"
EOF

# Don't start irqbalance when on battery
sudo mkdir -p /etc/systemd/system/irqbalance.service.d
sudo tee /etc/systemd/system/irqbalance.service.d/override.conf >/dev/null <<EOF
[Unit]
ConditionACPower=true
EOF

# Performance tweaks
echo "${BLUE}:: ${BWHITE}Applying ${BLUE}performance tweaks${BWHITE}...${NC}"

# Disable nouveau
sudo tee /etc/modprobe.d/blacklist-nvidia-nouveau.conf >/dev/null <<EOT
blacklist nouveau
options nouveau modeset=0
EOT

# Improve disk performance
sudo tee /etc/udev/rules.d/69-hdparm.rules >/dev/null <<EOF
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", RUN+="/usr/bin/hdparm -B 254 -S 0 /dev/%k"
EOF
sudo tee /etc/udev/rules.d/50-sata.rules >/dev/null <<EOF
# SATA Active Link Power Management
ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", ATTR{link_power_management_policy}="max_performance"
EOF
sudo tee /etc/udev/rules.d/60-ioschedulers.rules >/dev/null <<EOF
# set scheduler for NVMe
ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="none"
# set scheduler for SSD and eMMC
ACTION=="add|change", KERNEL=="sd[a-z]|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
# set scheduler for rotating disks
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
EOF

# Enable daemons
echo "${BLUE}:: ${BWHITE}Enabling ${BLUE}daemons${BWHITE}...${NC}"
systemctl enable --user psd
sudo systemctl enable ananicy-cpp
sudo systemctl enable irqbalance
sudo systemctl enable preload
