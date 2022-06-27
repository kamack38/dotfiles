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

# Select function
# Source: https://github.com/ChrisTitusTech/ArchTitus/blob/main/scripts/startup.sh
select_option() {

    # little helpers for terminal print control and key input
    ESC=$(printf "\033")
    cursor_blink_on() { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to() { printf "$ESC[$1;${2:-1}H"; }
    print_option() { printf "$2   $1 "; }
    print_selected() { printf "$2  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row() {
        IFS=';' read -sdR -p $'\E[6n' ROW COL
        echo ${ROW#*[}
    }
    get_cursor_col() {
        IFS=';' read -sdR -p $'\E[6n' ROW COL
        echo ${COL#*[}
    }
    key_input() {
        local key
        IFS= read -rsn1 key 2>/dev/null >&2
        if [[ $key = "" ]]; then echo enter; fi
        if [[ $key = $'\x20' ]]; then echo space; fi
        if [[ $key = "k" ]]; then echo up; fi
        if [[ $key = "j" ]]; then echo down; fi
        if [[ $key = "h" ]]; then echo left; fi
        if [[ $key = "l" ]]; then echo right; fi
        if [[ $key = "a" ]]; then echo all; fi
        if [[ $key = "n" ]]; then echo none; fi
        if [[ $key = $'\x1b' ]]; then
            read -rsn2 key
            if [[ $key = [A || $key = k ]]; then echo up; fi
            if [[ $key = [B || $key = j ]]; then echo down; fi
            if [[ $key = [C || $key = l ]]; then echo right; fi
            if [[ $key = [D || $key = h ]]; then echo left; fi
        fi
    }
    print_options_multicol() {
        # print options by overwriting the last lines
        local curr_col=$1
        local curr_row=$2
        local curr_idx=0

        local idx=0
        local row=0
        local col=0

        curr_idx=$(($curr_col + $curr_row * $colmax))

        for option in "${options[@]}"; do

            row=$(($idx / $colmax))
            col=$(($idx - $row * $colmax))

            cursor_to $(($startrow + $row + 1)) $(($offset * $col + 1))
            if [ $idx -eq $curr_idx ]; then
                print_selected "$option"
            else
                print_option "$option"
            fi
            ((idx++))
        done
    }

    # initially print empty new lines (scroll down if at bottom of screen)
    for opt; do printf "\n"; done

    # determine current screen position for overwriting the options
    local return_value=$1
    local lastrow=$(get_cursor_row)
    local lastcol=$(get_cursor_col)
    local startrow=$(($lastrow - $#))
    local startcol=1
    local lines=$(tput lines)
    local cols=$(tput cols)
    local colmax=$2
    local offset=$(($cols / $colmax))

    local size=$4
    shift 4

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local active_row=0
    local active_col=0
    while true; do
        print_options_multicol $active_col $active_row
        # user key control
        case $(key_input) in
        enter) break ;;
        up)
            ((active_row--))
            if [ $active_row -lt 0 ]; then active_row=0; fi
            ;;
        down)
            ((active_row++))
            if [ $active_row -ge $((${#options[@]} / $colmax)) ]; then active_row=$((${#options[@]} / $colmax)); fi
            ;;
        left)
            ((active_col = $active_col - 1))
            if [ $active_col -lt 0 ]; then active_col=0; fi
            ;;
        right)
            ((active_col = $active_col + 1))
            if [ $active_col -ge $colmax ]; then active_col=$(($colmax - 1)); fi
            ;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $(($active_col + $active_row * $colmax))
}

# Select disk to install on
options=($(lsblk -n --output TYPE,KNAME,SIZE | awk '$1=="disk"{print "/dev/"$2"|"$3}'))

select_option $? 1 "${options[@]}"
DISK=${options[$?]%|*}

# Check if drive is a ssd
if [[ "$(cat /sys/block/${disk#/*/}/queue/rotational)" == "0" ]]; then
    echo "${YELLOW}:: ${BWHITE}Selected drive is a ssd...${NC}"
    MOUNT_OPTIONS="noatime,compress=zstd,ssd,commit=120"
else
    echo "${YELLOW}:: ${BWHITE}Selected drive is NOT a ssd...${NC}"
    MOUNT_OPTIONS="noatime,compress=zstd,commit=120"
fi

# Create luks password (encryption)
while true; do
    echo -n "${YELLOW}:: ${BWHITE}Please enter your luks password: ${NC}"
    read -s luks_password # read password without echo

    echo -n "${YELLOW}:: ${BWHITE}Please repeat your luks password: ${NC}"
    read -s luks_password2 # read password without echo

    if [ "$luks_password" = "$luks_password2" ]; then
        LUKS_PASSWORD="$luks_password"
        break
    else
        echo "${RED}:: ${BWHITE}Passwords do not match. Please try again.${NC}"
    fi
done

# Create user credentials
echo "${BLUE}:: ${BWHITE}Creating user...${NC}"
read -rp "${BLUE}:: ${BWHITE}Enter your username: ${NC}" USERNAME

while true; do
    echo "${YELLOW}:: ${BWHITE}Please enter your: ${NC}"
    read -s password # read password without echo

    echo "${YELLOW}:: ${BWHITE}Please repeat your password: ${NC}"
    read -s password2 # read password without echo

    if [ "$password" = "$password2" ]; then
        echo "${GREEN}:: ${BWHITE}Passwords match.${NC}"
        PASSWORD="$password"
        break
    else
        echo -e "${RED}:: ${BWHITE}Passwords do not match. Please try again.${NC}"
    fi
done

read -rep "${YELLOW}:: ${BWHITE}Please enter your hostname: ${NC}" MACHINE_NAME

# Enable time sync
timedatectl set-ntp true

# Update keyrings to latest to prevent packages from failing to install
pacman -S --noconfirm archlinux-keyring
pacman -S --noconfirm --needed pacman-contrib

# Enable parallel downloads
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

pacman -S --noconfirm --needed reflector rsync grub

# Setup faster mirrors
reflector -a 48 -f 10 -l 20 --sort rate --save /etc/pacman.d/mirrorlist

# Create mount directory
mkdir /mnt

# Install Prerequisites
echo "${BLUE}:: ${BWHITE}Installing prerequisites...${NC}"
pacman -S --noconfirm --needed gptfdisk btrfs-progs glibc

echo "${BLUE}:: ${BWHITE}Formatting disk...${NC}"

# Make sure everything is unmounted starting
umount -A --recursive /mnt

sgdisk -Z ${DISK}
sgdisk -a 2048 -o ${DISK}
sgdisk -n 1::+1M --typecode=1:ef02 --change-name=1:'BIOSBOOT' ${DISK}  # partition 1 (BIOS Boot Partition)
sgdisk -n 2::+300M --typecode=2:ef00 --change-name=2:'EFIBOOT' ${DISK} # partition 2 (UEFI Boot Partition)
sgdisk -n 3::-0 --typecode=3:8300 --change-name=3:'ROOT' ${DISK}       # partition 3 (Root), default start, remaining

# Check for bios system
if [[ ! -d "/sys/firmware/efi" ]]; then
    sgdisk -A 1:set:2 ${DISK}
fi
partprobe ${DISK} # reread partition table to ensure it is correct

echo "${BLUE}:: ${BWHITE}Creating filesystems (BTRFS)...${NC}"

if [[ "${DISK}" =~ "nvme" ]]; then
    partition2=${DISK}p2
    partition3=${DISK}p3
else
    partition2=${DISK}2
    partition3=${DISK}3
fi

# Create boot partition
mkfs.vfat -F32 -n "EFIBOOT" ${partition2}

# Enter luks password to cryptsetup and format root partition
echo -n "${LUKS_PASSWORD}" | cryptsetup -y -v luksFormat ${partition3} -

# Open luks container and ROOT will be place holder
echo -n "${LUKS_PASSWORD}" | cryptsetup open ${partition3} ROOT -

# Format luks container
mkfs.btrfs -L ROOT ${partition3}

# Create subvolumes for btrfs
echo "${BLUE}:: ${BWHITE}Creating BTRFS subvolumes...${NC}"
mount -t btrfs ${partition3} /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@.snapshots

# unmount root to remount with subvolume
umount /mnt
# make directories home, .snapshots, var, tmp
mkdir -p /mnt/{home,var,tmp,.snapshots}

# Mount all btrfs subvolumes
mount -o ${MOUNT_OPTIONS},subvol=@home ${partition3} /mnt/home
mount -o ${MOUNT_OPTIONS},subvol=@tmp ${partition3} /mnt/tmp
mount -o ${MOUNT_OPTIONS},subvol=@var ${partition3} /mnt/var
mount -o ${MOUNT_OPTIONS},subvol=@.snapshots ${partition3} /mnt/.snapshots

# Mount @ subvolume
mount -o ${MOUNT_OPTIONS},subvol=@ ${partition3} /mnt
mountallsubvol

ENCRYPTED_PARTITION_UUID=$(blkid -s UUID -o value ${partition3})

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

# Start arch installation
echo "${BLUE}:: ${BWHITE}Installing prerequisites to ${BlUE}/mnt${BWHITE}...${NC}"
pacstrap /mnt base linux linux-firmware sudo archlinux-keyring libnewt --noconfirm --needed
echo "keyserver hkp://keyserver.ubuntu.com" >>/mnt/etc/pacman.d/gnupg/gpg.conf
cp -R ${SCRIPT_DIR} /mnt/root/ArchTitus
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

# Chroot into new OS
arch-chroot /mnt <<EOF
BWHITE=$'\e[1;37m'
BLUE=$'\e[0;34m'
NC=$'\e[0m'

# Create user
groupadd libvirt
useradd -m -G wheel,libvirt -s /bin/bash $USERNAME
echo "${BLUE}:: ${BWHITE}$USERNAME created, home directory created, added to wheel and libvirt group, default shell set to ${BlUE}/bin/bash${NC}"
echo "$USERNAME:$PASSWORD" | chpasswd
echo "$USERNAME password set"

# enter $NAME_OF_MACHINE to /etc/hostname
echo "${BLUE}:: ${BWHITE}Hostname is set to ${BLUE}${MACHINE_NAME}${NC}"
echo $MACHINE_NAME >/etc/hostname
sed -i 's/filesystems/encrypt filesystems/g' /etc/mkinitcpio.conf
mkinitcpio -P
exit
EOF

echo "${GREEN}:: ${BWHITE}Setup completed!${NC}"

read -rp "${RED}:: ${BWHITE}Do you want to reboot? [y/N]${NC}: " reboot_prompt
if [[ $reboot_prompt == y* ]]; then
    echo "${YELLOW}:: ${BWHITE}Rebooting...${NC}"
    systemctl reboot
fi
