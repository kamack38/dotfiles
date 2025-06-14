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

# Enable colour
sed -i 's/^#Color/Color/' /etc/pacman.conf

# Update keyrings to latest to prevent packages from failing to install
pacman -Sy --noconfirm archlinux-keyring
pacman -S --noconfirm --needed pacman-contrib fzf reflector rsync grub bc

# Select disk
echo "${BLUE}:: ${BWHITE}Select disk to install system on.${NC}"
while [ -z "${DISK}" ]; do
	DISK=$(lsblk -n --output TYPE,KNAME,SIZE | awk '$1=="disk"{print "/dev/"$2"|"$3}' | fzf --height=20% --layout=reverse | sed 's/|.*//')
done
DISK_SIZE=$(lsblk -n --output SIZE "${DISK}" | head -n1)
echo "${BLUE}:: ${BWHITE}Selected disk is: ${BLUE}${DISK}${NC}"
echo "${BLUE}:: ${BWHITE}Selected disk has a size of ${DISK_SIZE}GB${NC}"

# Select install type
read -rp "${BLUE}:: ${BWHITE}Do you wish to ${RED}ERASE${BWHITE} the disk before partitioning [Y/n]?${NC}" erase_disk

use_x_efi="n"
if [[ $erase_disk == n* ]]; then
	EFI_PART=$(lsblk -n -o PARTTYPE,KNAME "$DISK" | awk '$1=="c12a7328-f81f-11d2-ba4b-00a0c93ec93b" { print "/dev/"$2"" }')

	if [ -n "$EFI_PART" ]; then
		echo "${BLUE}:: ${BWHITE}EFI partition ${BLUE}${EFI_PART}${BWHITE} detected.${NC}"
		read -rp "${BLUE}:: ${BWHITE}Do you want to use it [Y/n]?${NC}" use_x_efi
	fi
fi

# Swap
SWAP_OPTIONS=(
	"swapfile"
	"zram"
)
TOTAL_RAM_GB=$(echo "scale=1; $(grep -i 'memtotal' /proc/meminfo | grep -o '[[:digit:]]*')/1000000" | bc)
TOTAL_RAM_MB=$(echo "scale=0; $(grep -i 'memtotal' /proc/meminfo | grep -o '[[:digit:]]*')/1000" | bc)
echo "${YELLOW}:: ${BWHITE}You have ${TOTAL_RAM_GB}GB of RAM${NC}"
echo "${YELLOW}:: ${BWHITE}Do you wish to create ${TOTAL_RAM_GB}GB swapfile or ${TOTAL_RAM_GB}GB zram?${NC}"
SWAP_TYPE=$(printf "%s\n" "${SWAP_OPTIONS[@]}" | fzf --height=20% --layout=reverse || true)

# Create luks password (encryption)
while true; do
	echo -n "${YELLOW}:: ${BWHITE}Please enter your luks password (empy = no encryption): ${NC}"
	read -rs luks_password # read password without echo

	echo -ne "\n${YELLOW}:: ${BWHITE}Please repeat your luks password: ${NC}"
	read -rs luks_password2 # read password without echo

	if [ "$luks_password" = "$luks_password2" ]; then
		echo -e "\n${GREEN}:: ${BWHITE}Passwords match.${NC}"
		LUKS_PASSWORD="$luks_password"
		break
	else
		echo -e "\n${RED}:: ${BWHITE}Passwords do not match. Please try again.${NC}"
	fi
done
if [[ "$LUKS_PASSWORD" == "" ]]; then
	echo "${YELLOW}:: ${BWHITE}Luks password is empty - encryption will not be set up"
fi

# Create user credentials
read -rp "${BLUE}:: ${BWHITE}Enter your username: ${NC}" USERNAME

while true; do
	echo -n "${YELLOW}:: ${BWHITE}Please enter your password: ${NC}"
	read -rs password # read password without echo

	echo -ne "\n${YELLOW}:: ${BWHITE}Please repeat your password: ${NC}"
	read -rs password2 # read password without echo

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
read -rp "${BLUE}:: ${BWHITE}Do you want to setup faster mirrors? [Y/n]${NC}: " mirrors_setup
if [[ $mirrors_setup != n* ]]; then
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

if [[ $erase_disk != n* ]]; then
	echo "${YELLOW}:: ${BWHITE}All data from disk ${DISK} is being ${RED}ERASED${BWHITE}!${NC}"
	sgdisk -Z "${DISK}"
	sgdisk -a 2048 -o "${DISK}"
fi

echo "${BLUE}:: ${BWHITE}Formatting disk...${NC}"
if [[ ! -d "/sys/firmware/efi" ]]; then
	sgdisk -n "0::+1M" --typecode="0:ef02" --change-name="0:BIOSBOOT" "${DISK}" # BIOS Boot Partition
fi
if [[ $use_x_efi == n* ]]; then
	sgdisk -n "0::+512M" --typecode="0:ef00" --change-name="0:EFIBOOT" "${DISK}" # UEFI Boot Partition
fi
sgdisk -N "0" --typecode="0:8300" --change-name="0:Archlinux" "${DISK}" # Root Partition, default start, remaining

echo "${BLUE}:: ${BWHITE}Rereading partition table...${NC}"
partprobe "${DISK}"

# Create boot partition
if [[ $use_x_efi == n* ]]; then
	echo "${BLUE}:: ${BWHITE}Formatting EFI partition...${NC}"
	mkfs.fat -F32 -n "EFIBOOT" "/dev/disk/by-partlabel/EFIBOOT"
	EFI_PART="/dev/disk/by-partlabel/EFIBOOT"
fi

if [[ "$LUKS_PASSWORD" != "" ]]; then
	# Enter luks password to cryptsetup and format root partition
	echo "${BLUE}:: ${BWHITE}Encrypting root partition...${NC}"
	echo -n "${LUKS_PASSWORD}" | cryptsetup -v luksFormat "/dev/disk/by-partlabel/Archlinux" -

	# Open luks container and 'cryptroot' will be placeholder
	echo "${BLUE}:: ${BWHITE}Opening root partition...${NC}"
	echo -n "${LUKS_PASSWORD}" | cryptsetup open "/dev/disk/by-partlabel/Archlinux" cryptroot -

	# Set the main device to the LUKS container
	MAIN_DEV=/dev/mapper/cryptroot
else
	# Set the main device to the archlinux partition
	MAIN_DEV="/dev/disk/by-partlabel/Archlinux"
fi

# Format the main device
mkfs.btrfs -L root ${MAIN_DEV}

# Create subvolumes for btrfs
echo "${BLUE}:: ${BWHITE}Creating BTRFS subvolumes...${NC}"
mount ${MAIN_DEV} /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@swap

# unmount root to remount with subvolume
umount /mnt

# Set mount options
MOUNT_OPTIONS="defaults,noatime,compress=lzo,commit=60"
SWAP_MOUNT_OPTIONS="nodatacow,noatime,nospace_cache"

echo "${BLUE}:: ${BWHITE}Mounting @ subvolume...${NC}"
mount -o ${MOUNT_OPTIONS},subvol=@ ${MAIN_DEV} /mnt

echo "${BLUE}:: ${BWHITE}Creating directories (home, var, tmp, swap)...${NC}"
mkdir -p /mnt/{home,var,tmp,swap}

# Mount all btrfs subvolumes
echo "${BLUE}:: ${BWHITE}Mounting other btrfs subvolumes...${NC}"
mount -o ${MOUNT_OPTIONS},subvol=@home ${MAIN_DEV} /mnt/home
mount -o ${MOUNT_OPTIONS},nodev,nosuid,noexec,subvol=@tmp ${MAIN_DEV} /mnt/tmp
mount -o ${MOUNT_OPTIONS},subvol=@var ${MAIN_DEV} /mnt/var
mount -o ${SWAP_MOUNT_OPTIONS},subvol=@swap ${MAIN_DEV} /mnt/swap

if [[ "$LUKS_PASSWORD" == "" ]]; then
	ENCRYPTED_PARTITION_UUID=$(blkid -s UUID -o value "/dev/disk/by-partlabel/Archlinux")

	echo "${BLUE}:: ${BWHITE}Encrypted partition UUID is: ${BLUE}${ENCRYPTED_PARTITION_UUID}${NC}"
fi

# Mount target
mkdir -p /mnt/boot/efi
mount -t vfat $EFI_PART /mnt/boot

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
	"linux-headers"
	"sudo"
	"grub"
	"archlinux-keyring"
	"libnewt"
	"modemmanager"
	"networkmanager"
	"dhclient"
)

# Install GRUB
if [[ ! -d "/sys/firmware/efi" ]]; then
	grub-install --boot-directory=/mnt/boot "${DISK}"
else
	PREREQUISITES+=("efibootmgr")
fi

# Start arch installation
echo "${BLUE}:: ${BWHITE}Installing prerequisites to ${BLUE}/mnt${BWHITE}...${NC}"
pacstrap /mnt "${PREREQUISITES[@]}" --noconfirm --needed
echo "keyserver hkp://keyserver.ubuntu.com" >>/mnt/etc/pacman.d/gnupg/gpg.conf
cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist

genfstab -L /mnt >>/mnt/etc/fstab
echo "${YELLOW}:: ${BWHITE}Generated /etc/fstab:${NC}"
cat /mnt/etc/fstab
sleep 2

# Swap
SWAP_SIZE=$TOTAL_RAM_MB
SWAP_FILE_PATH="/swap/swapfile"
case $SWAP_TYPE in
zram)
	echo "${BLUE}:: ${BWHITE}Installing ${BLUE}zram${BWHITE} prerequisites...${NC}"
	pacstrap /mnt zram-generator --noconfirm --needed 1>/dev/null
	;;
esac

function chroot {
	echo "${BLUE}:: ${BWHITE}Setting up ${BLUE}GRUB${BWHITE}...${NC}"
	if [[ -d "/sys/firmware/efi" ]]; then
		grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
	fi
	if [[ "$LUKS_PASSWORD" == "" ]]; then
		sed -i "s%^GRUB_CMDLINE_LINUX_DEFAULT=\"%GRUB_CMDLINE_LINUX_DEFAULT=\"cryptdevice=UUID=${ENCRYPTED_PARTITION_UUID}:cryptroot root=/dev/mapper/cryptroot %" /etc/default/grub
		sed -i "s/^#GRUB_ENABLE_CRYPTODISK=y/GRUB_ENABLE_CRYPTODISK=y/" /etc/default/grub
	fi

	case $SWAP_TYPE in
	swapfile)
		echo "${BLUE}:: ${BWHITE}Creating swapfile in ${SWAP_FILE_PATH} of size ${SWAP_SIZE}MB ...${NC}"
		btrfs filesystem mkswapfile ${SWAP_FILE_PATH} -s "${SWAP_SIZE}m"
		chown root $SWAP_FILE_PATH
		swapon ${SWAP_FILE_PATH}
		echo "${SWAP_FILE_PATH}	none	swap	sw	0	0" >>/etc/fstab

		echo "${BLUE}:: ${BWHITE}Adding hibernation...${NC}"
		SWAP_FILE_DEV_UUID=$(findmnt -no UUID -T $SWAP_FILE_PATH)
		SWAP_FILE_OFFSET=$(btrfs inspect-internal map-swapfile -r "$SWAP_FILE_PATH")
		sed -i "s,\(^HOOKS=.*\)filesystems\(.*\),\1filesystems resume\2," /etc/mkinitcpio.conf
		sed -i "s,\(^GRUB_CMDLINE_LINUX_DEFAULT=\".*\)\(.*\"\),\1 resume=UUID=${SWAP_FILE_DEV_UUID} resume_offset=${SWAP_FILE_OFFSET}\2," /etc/default/grub
		;;
	zram)
		echo "${BLUE}:: ${BWHITE}Creating swap on zram...${NC}"
		systemctl daemon-reload
		systemctl start /dev/zram0
		tee /etc/systemd/zram-generator.conf >/dev/null <<EOT
[zram0]
host-memory-limit = none
zram-fraction = 1
max-zram-size = none
compression-algorithm = zstd
EOT
		;;
	esac

	echo "${BLUE}:: ${BWHITE}Generating ${BLUE}GRUB${BWHITE} config...${NC}"
	grub-mkconfig -o /boot/grub/grub.cfg

	echo "${BLUE}:: ${BWHITE}Creating user...${NC}"
	useradd -mG wheel -s /bin/bash "$USERNAME"
	echo "${BLUE}:: ${BWHITE}$USERNAME added to wheel group, default shell set to ${BLUE}/bin/bash${NC}"
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
	echo "$MACHINE_NAME" >/etc/hostname

	# Add encrypt hook
	sed -i "s,\(^HOOKS=.*\)filesystems\(.*\),\1encrypt filesystems\2," /etc/mkinitcpio.conf
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
export SWAP_SIZE
export SWAP_FILE_PATH
export SWAP_TYPE

# Chroot into new OS
arch-chroot /mnt /bin/bash -c "chroot"

echo "${GREEN}:: ${BWHITE}Setup completed!${NC}"

read -rp "${RED}:: ${BWHITE}Do you want to reboot? [Y/n]${NC}: " reboot_prompt
if [[ ! $reboot_prompt == *n* ]]; then
	echo "${YELLOW}:: ${BWHITE}Rebooting...${NC}"
	systemctl reboot
fi
