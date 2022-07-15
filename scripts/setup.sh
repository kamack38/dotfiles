#!/usr/bin/env bash

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

# Show greeting
echo "   ___  __    _____ ______  _________  ________"
echo "  |\  \|\  \ |\   _ \  __ \|\_____   \|\   __  \ "
echo "  \ \  \/  /|\ \  \\\\\__\ \  \|_____\  \ \  \|\  \    Kamack38"
echo "   \ \   ___  \ \  \\\\|__| \  \|______  \ \   __  \   ${BLUE}https://twitter.com/kamack38${NC}"
echo "    \ \  \\\\ \  \ \  \    \ \  \| ____\  \ \  \|\  \  https://github.com/kamack38"
echo "     \ \__\\\\ \__\ \__\    \ \__\|\_______\ \_______\ "
echo "      \|__| \|__|\|__|     \|__|\|_______|\|_______|"
echo ""
echo "		${RED}Thank you for using my script! ${NC}"

# Enable parallel downloads
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

# Update keyrings to latest to prevent packages from failing to install
pacman -Sy --noconfirm archlinux-keyring
pacman -S --noconfirm --needed pacman-contrib fzf reflector rsync grub

# Select disk
echo "${BLUE}:: ${BWHITE}Select disk to install system on.${NC}"
DISK=$(lsblk -n --output TYPE,KNAME,SIZE | awk '$1=="disk"{print "/dev/"$2"|"$3}' | fzf --height=20% --layout=reverse)
DISK=${DISK%|*}
DISK_SIZE=$(lsblk -n --output SIZE ${DISK} | head -n1)
echo "${BLUE}:: ${BWHITE}Selected disk is: ${BLUE}${DISK}${NC}"
echo "${BLUE}:: ${BWHITE}Selected disk has a size of ${DISK_SIZE}GB${NC}"

# Select install type
read -rp "${BLUE}:: ${BWHITE}Do you wish to ${RED}ERASE${BWHITE} the disk before partitioning [Y/n]?${NC}" erase_disk

# Check if drive is a ssd
if [[ "$(cat /sys/block/${DISK#/*/}/queue/rotational)" == "0" ]]; then
    echo "${YELLOW}:: ${BWHITE}Selected drive is a ssd...${NC}"
    MOUNT_OPTIONS="noatime,space_cache=v2,compress=zstd,ssd,commit=120"
else
    echo "${YELLOW}:: ${BWHITE}Selected drive is NOT a ssd...${NC}"
    MOUNT_OPTIONS="noatime,space_cache=v2,compress=zstd,commit=120"
fi

# Swaperase_disk
TOTAL_RAM=$(echo "scale=1; $(cat /proc/meminfo | grep -i 'memtotal' | grep -o '[[:digit:]]*')/1000000" | bc)
echo "${YELLOW}:: ${BWHITE}You have ${TOTAL_RAM}GB of RAM${NC}"
read -rep "${YELLOW}:: ${BWHITE}Do you wish to create 8GB swap? [Y/n]${NC}" SWAP

# Create luks password (encryption)
while true; do
    echo -n "${YELLOW}:: ${BWHITE}Please enter your luks password: ${NC}"
    read -s luks_password # read password without echo

    echo -ne "\n${YELLOW}:: ${BWHITE}Please repeat your luks password: ${NC}"
    read -s luks_password2 # read password without echo

    if [ "$luks_password" = "$luks_password2" ]; then
        echo -e "\n${GREEN}:: ${BWHITE}Passwords match.${NC}"
        LUKS_PASSWORD="$luks_password"
        break
    else
        echo -e "\n${RED}:: ${BWHITE}Passwords do not match. Please try again.${NC}"
    fi
done

# Create user credentials
read -rp "${BLUE}:: ${BWHITE}Enter your username: ${NC}" USERNAME

while true; do
    echo -n "${YELLOW}:: ${BWHITE}Please enter your password: ${NC}"
    read -s password # read password without echo

    echo -ne "\n${YELLOW}:: ${BWHITE}Please repeat your password: ${NC}"
    read -s password2 # read password without echo

    if [ "$password" = "$password2" ]; then
        echo -e "\n${GREEN}:: ${BWHITE}Passwords match.${NC}"
        PASSWORD="$password"
        break
    else
        echo -e "\n${RED}:: ${BWHITE}Passwords do not match. Please try again.${NC}"
    fi
done

read -rep "${YELLOW}:: ${BWHITE}Please enter your hostname: ${NC}" MACHINE_NAME

# Enable time sync
echo "${BLUE}:: ${BWHITE}Enabling time sync...${NC}"
timedatectl set-ntp true

# Setup faster mirrors
read -rp "${BLUE}:: ${BWHITE}Do you want to setup faster mirrors? [Y/n]${NC}: " fonts_setup
if [[ $fonts_setup != n* ]]; then
    echo "${BLUE}:: ${BWHITE}Setting up faster mirrors using ${BLUE}reflector${BWHITE}...${NC}"
    reflector -a 48 -f 10 -l 20 --sort rate --save /etc/pacman.d/mirrorlist
fi

# Create mount directory
mkdir -p /mnt

# Install Prerequisites
echo "${BLUE}:: ${BWHITE}Installing prerequisites...${NC}"
pacman -S --noconfirm --needed gptfdisk btrfs-progs glibc

# Make sure everything is unmounted when starting
if grep -qs '/mnt' /proc/mounts; then
    echo "${YELLOW}:: ${BLUE}/mnt${BWHITE} is mounted${NC} -- unmounting"
    umount -AR /mnt
else
    echo "${BLUE}:: ${BLUE}/mnt${BWHITE} is not mounted${NC} -- skipping"
fi

# Get partition numbers
echo "${YELLOW}:: ${BWHITE}Looking for free partition numbers...${NC}"
j=0
i=1
PART_NUMBERS=()
if [[ "${DISK}" =~ "nvme" ]]; then
    TMP_DISK="${DISK}p"
else
    TMP_DISK="${DISK}"
fi
while [ $j -lt 3 ]; do
    if [[ ! -e "${TMP_DISK}${i}" ]]; then
        echo "${BLUE}:: ${BLUE}${i}${BWHITE} is free! ${NC}"
        ((j = j + 1))
        PART_NUMBERS+=("$i")
    fi
    ((i = i + 1))
done

echo "${BLUE}:: ${BWHITE}Formatting disk...${NC}"
if [[ $erase_disk != n* ]]; then
    echo "${YELLOW}:: ${BWHITE}All data from disk ${DISK} is being ${RED}ERASED${BWHITE}!${NC}"
    sgdisk -Z ${DISK}
    sgdisk -a 2048 -o ${DISK}
fi
sgdisk -n "${PART_NUMBERS[0]}"::+1M --typecode="${PART_NUMBERS[0]}":ef02 --change-name="${PART_NUMBERS[0]}":'BIOSBOOT' ${DISK}  # partition 1 (BIOS Boot Partition)
sgdisk -n "${PART_NUMBERS[1]}"::+300M --typecode="${PART_NUMBERS[1]}":ef00 --change-name="${PART_NUMBERS[1]}":'EFIBOOT' ${DISK} # partition 2 (UEFI Boot Partition)
sgdisk -N "${PART_NUMBERS[2]}" --typecode="${PART_NUMBERS[2]}":8300 --change-name="${PART_NUMBERS[2]}":'ROOT' ${DISK}           # partition 3 (Root), default start, remaining

# Check for bios system
if [[ ! -d "/sys/firmware/efi" ]]; then
    sgdisk -A "${PART_NUMBERS[0]}":set:"${PART_NUMBERS[1]}" ${DISK}
fi

echo "${BLUE}:: ${BWHITE}Rereading partition table...${NC}"
partprobe ${DISK}

echo "${BLUE}:: ${BWHITE}Naming partitions...${NC}"
if [[ "${DISK}" =~ "nvme" ]]; then
    EFI_PART="${DISK}p${PART_NUMBERS[1]}"
    ROOT_PART="${DISK}p${PART_NUMBERS[2]}"
else
    EFI_PART="${DISK}${PART_NUMBERS[1]}"
    ROOT_PART="${DISK}${PART_NUMBERS[2]}"
fi

# Create boot partition
echo "${BLUE}:: ${BWHITE}Creating EFI partition...${NC}"
mkfs.vfat -F32 -n "EFIBOOT" ${EFI_PART}

# Enter luks password to cryptsetup and format root partition
echo "${BLUE}:: ${BWHITE}Encrypting root partition...${NC}"
echo -n "${LUKS_PASSWORD}" | cryptsetup -v luksFormat ${ROOT_PART} -

# Open luks container and ROOT will be place holder
echo "${BLUE}:: ${BWHITE}Opening root partition...${NC}"
echo -n "${LUKS_PASSWORD}" | cryptsetup open ${ROOT_PART} root -

# Format luks container
mapper=/dev/mapper/root
mkfs.btrfs -L root ${mapper}

# Create subvolumes for btrfs
echo "${BLUE}:: ${BWHITE}Creating BTRFS subvolumes...${NC}"
mount ${mapper} /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@.snapshots

# unmount root to remount with subvolume
umount /mnt

echo "${BLUE}:: ${BWHITE}Mounting @ subvolume...${NC}"
mount -o ${MOUNT_OPTIONS},subvol=@ ${mapper} /mnt

echo "${BLUE}:: ${BWHITE}Creating directories (home, var, tmp, .snapshots)...${NC}"
mkdir -p /mnt/{home,var,tmp,.snapshots}

# Mount all btrfs subvolumes
echo "${BLUE}:: ${BWHITE}Mounting other btrfs subvolumes...${NC}"
mount -o ${MOUNT_OPTIONS},subvol=@home ${mapper} /mnt/home
mount -o ${MOUNT_OPTIONS},nodev,nosuid,noexec,subvol=@tmp ${mapper} /mnt/tmp
mount -o ${MOUNT_OPTIONS},subvol=@var ${mapper} /mnt/var
mount -o ${MOUNT_OPTIONS},subvol=@.snapshots ${mapper} /mnt/.snapshots

ENCRYPTED_PARTITION_UUID=$(blkid -s UUID -o value ${ROOT_PART})

echo "${BLUE}:: ${BWHITE}Encrypted partition UUID is: ${BLUE}${ENCRYPTED_PARTITION_UUID}${NC}"

# Mount target
mkdir -p /mnt/boot/efi
mount -t vfat -L EFIBOOT /mnt/boot/

# Check if drive is mounted
if ! grep -qs '/mnt' /proc/mounts; then
    echo "${RED}:: ${BWHITE}Drive is not mounted can not continue${NC}"
    echo "${YELLOW}:: ${BWHITE}Rebooting in 3 Seconds...${NC}" && sleep 1
    echo "${YELLOW}:: ${BWHITE}Rebooting in 2 Seconds...${NC}" && sleep 1
    echo "${YELLOW}:: ${BWHITE}Rebooting in 1 Seconds...${NC}" && sleep 1
    reboot now
fi

PREREQUISITES=(
    "base"
    "btrfs-progs"
    "linux"
    "linux-firmware"
    "sudo"
    "grub"
    "archlinux-keyring"
    "libnewt"
    "modemmanager"
    "networkmanager"
    "dhclient"
    "snapper"    # A tool for managing BTRFS and LVM snapshots. It can create, diff and restore snapshots and provides timelined auto-snapping.
    "snap-pac"   # Pacman hooks that use snapper to create pre/post btrfs snapshots like openSUSE's YaST
    "grub-btrfs" # Include btrfs snapshots in GRUB boot options
)

# Start arch installation
echo "${BLUE}:: ${BWHITE}Installing prerequisites to ${BLUE}/mnt${BWHITE}...${NC}"
pacstrap /mnt "${PREREQUISITES[@]}" --noconfirm --needed 1>/dev/null
echo "keyserver hkp://keyserver.ubuntu.com" >>/mnt/etc/pacman.d/gnupg/gpg.conf
cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist

genfstab -L /mnt >>/mnt/etc/fstab
echo "${YELLOW}:: ${BWHITE}Generated /etc/fstab:${NC}" && sleep 1
cat /mnt/etc/fstab

# Install GRUB
if [[ ! -d "/sys/firmware/efi" ]]; then
    grub-install --boot-directory=/mnt/boot ${DISK}
else
    pacstrap /mnt efibootmgr --noconfirm --needed
fi

# Swap
if [[ $SWAP != n* ]]; then
    echo "${BLUE}:: ${BWHITE}Creating swap...${NC}"
    mkdir -p /mnt/opt/swap  # make a dir that we can apply NOCOW to to make it btrfs-friendly.
    chattr +C /mnt/opt/swap # apply NOCOW, btrfs needs that.
    dd if=/dev/zero of=/mnt/opt/swap/swapfile bs=1M count=8000 status=progress
    chmod 600 /mnt/opt/swap/swapfile
    chown root /mnt/opt/swap/swapfile
    mkswap /mnt/opt/swap/swapfile
    swapon /mnt/opt/swap/swapfile
    echo "/opt/swap/swapfile	none	swap	sw	0	0" >>/mnt/etc/fstab

fi

function chroot {
    echo "${BLUE}:: ${BWHITE}Setting up ${BLUE}GRUB${BWHITE}...${NC}"
    if [[ -d "/sys/firmware/efi" ]]; then
        grub-install --efi-directory=/boot ${DISK}
    fi
    sed -i "s%GRUB_CMDLINE_LINUX_DEFAULT=\"%GRUB_CMDLINE_LINUX_DEFAULT=\"cryptdevice=UUID=${ENCRYPTED_PARTITION_UUID}:root root=/dev/mapper/root %g" /etc/default/grub
    sed -i "s/^#GRUB_ENABLE_CRYPTODISK=y/GRUB_ENABLE_CRYPTODISK=y/" /etc/default/grub

    if [[ $SWAP != n* ]]; then
        echo "${BLUE}:: ${BWHITE}Adding hibernation...${NC}"
        sed -i "s,\(^HOOKS=\".*\)filesystems\(.*\"\),\1filesystems resume\2," /etc/mkinitcpio.conf
        sed -i "s,\(GRUB_CMDLINE_LINUX_DEFAULT=\".*\)\(.*\"),\1resume=/dev/mapper/root\2" /etc/default/grub
    fi

    echo "${BLUE}:: ${BWHITE}Setting up snapper...${NC}"
    # Change grub snapshot submenu name
    sed -i /etc/default/grub-btrfs/config \
        -e 's,.*GRUB_BTRFS_SUBMENUNAME=.*,GRUB_BTRFS_SUBMENUNAME=\"BTRFS snapshots\",'

    if [[ $(systemctl is-enabled grub-btrfs.path) == "enabled" ]]; then
        systemctl disable --now grub-btrfs.path
    fi

    # Add template
    sudo tee /etc/snapper/config-templates/garuda <<EOF
# subvolume to snapshot
SUBVOLUME="/"

# filesystem type
FSTYPE="btrfs"


# btrfs qgroup for space aware cleanup algorithms
QGROUP=""


# fraction or absolute size of the filesystems space the snapshots may use
SPACE_LIMIT="0.5"

# fraction or absolute size of the filesystems space that should be free
FREE_LIMIT="0.2"


# users and groups allowed to work with config
ALLOW_USERS=""
ALLOW_GROUPS=""

# sync users and groups from ALLOW_USERS and ALLOW_GROUPS to .snapshots
# directory
SYNC_ACL="no"


# start comparing pre- and post-snapshot in background after creating
# post-snapshot
BACKGROUND_COMPARISON="yes"


# run daily number cleanup
NUMBER_CLEANUP="yes"

# limit for number cleanup
NUMBER_MIN_AGE="1800"
NUMBER_LIMIT="10"
NUMBER_LIMIT_IMPORTANT="5"


# create hourly snapshots
TIMELINE_CREATE="no"

# cleanup hourly snapshots after some time
TIMELINE_CLEANUP="yes"

# limits for timeline cleanup
TIMELINE_MIN_AGE="1800"
TIMELINE_LIMIT_HOURLY="5"
TIMELINE_LIMIT_DAILY="7"
TIMELINE_LIMIT_WEEKLY="0"
TIMELINE_LIMIT_MONTHLY="0"
TIMELINE_LIMIT_YEARLY="0"


# cleanup empty pre-post-pairs
EMPTY_PRE_POST_CLEANUP="yes"

# limits for empty pre-post-pair cleanup
EMPTY_PRE_POST_MIN_AGE="1800"
EOF

    echo "${BLUE}:: ${BWHITE}Enabling automatic rebuild of grub-btrfs when snapshots are taken...${NC}"
    # Add grub-btrfs service
    sudo tee /usr/lib/systemd/system/grub-btrfs-snapper.service <<EOF
[Unit]
Description=Regenerate grub-btrfs.cfg

[Service]
Type=oneshot
# Set the possible paths for $(grub-mkconfig)
Environment="PATH=/sbin:/bin:/usr/sbin:/usr/bin"
# Load environment variables from the configuration
EnvironmentFile=/etc/default/grub-btrfs/config
# If we aren't booted off a snapshot, regenerate just '/boot/grub/grub-btrfs.cfg' if it exists and is not empty, else regenerate the whole grub menu
ExecStart=bash -c 'if [[ -z $(/usr/bin/findmnt -n / | /usr/bin/grep "\.snapshots") ]]; then if [ -s "\${GRUB_BTRFS_GRUB_DIRNAME:-/boot/grub}/grub-btrfs.cfg" ]; then /etc/grub.d/41_snapshots-btrfs; else \${GRUB_BTRFS_MKCONFIG:-grub-mkconfig} -o \${GRUB_BTRFS_GRUB_DIRNAME:-/boot/grub}/grub.cfg; fi; fi'
EOF

    sudo tee /usr/lib/systemd/system/grub-btrfs-snapper.path <<EOF
[Unit]
Description=Monitors for new snapshots

[Path]
PathModified=/.snapshots

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable --now grub-btrfs-snapper.path
    systemctl enable snapper-cleanup.timer

    echo "${BLUE}:: ${BWHITE}Creating snapper config...${NC}"
    snapper create-config --template garuda /

    if [[ ! $(grep -qe "^HOOKS=.*grub-btrfs-overlayfs" /etc/mkinitcpio.conf) ]]; then
        echo "${BLUE}:: ${BWHITE}Adding ${BLUE}grub-btrfs-overlayfs${BWHITE} hook...${NC}"
        sed -re 's/(^HOOKS=\([^)]+)/\1 grub-btrfs-overlayfs/gi' -i /etc/mkinitcpio.conf
    fi

    grub-mkconfig -o /boot/grub/grub.cfg

    echo "${BLUE}:: ${BWHITE}Creating user...${NC}"
    groupadd libvirt
    useradd -mG wheel,libvirt -s /bin/bash $USERNAME
    echo "${BLUE}:: ${BWHITE}$USERNAME added to wheel and libvirt group, default shell set to ${BlUE}/bin/bash${NC}"
    echo "$USERNAME:$PASSWORD" | chpasswd
    echo "${BLUE}:: ${BWHITE}${USERNAME} password set${NC}"

    echo "${BLUE}:: ${BWHITE}Setting up NetworkManager...${NC}"
    systemctl enable NetworkManager.service
    systemctl enable ModemManager.service

    # Add sudo rights
    echo "${BLUE}:: ${BWHITE}Adding ${BLUE}wheel${BWHITE} group sudo rights...${NC}"
    sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
    sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

    echo "${BLUE}:: ${BWHITE}Hostname is set to ${BLUE}${MACHINE_NAME}${NC}"
    echo $MACHINE_NAME >/etc/hostname
    sed -i 's/filesystems/encrypt filesystems/g' /etc/mkinitcpio.conf
    mkinitcpio -P
}
export -f chroot

# Export vars
export BLUE
export BWHITE
export NC
export DISK
export USERNAME
export PASSWORD
export MACHINE_NAME
export ENCRYPTED_PARTITION_UUID

# Chroot into new OS
arch-chroot /mnt /bin/bash -c "chroot"

echo "${GREEN}:: ${BWHITE}Setup completed!${NC}"

read -rp "${RED}:: ${BWHITE}Do you want to reboot? [y/N]${NC}: " reboot_prompt
if [[ $reboot_prompt == y* ]]; then
    echo "${YELLOW}:: ${BWHITE}Rebooting...${NC}"
    systemctl reboot
fi
