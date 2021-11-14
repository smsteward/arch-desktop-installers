#!/usr/bin/env bash

# It is assumed that you have already partitioned your disks and used 'pacstrap' to install the base system, and are chrooted into your new Arch install by using 'arch-chroot /mnt', assuming you have been following the installation guide and mounted your install at '/mnt'. Adjust your path as necessary, but you need to be inside your newly installed system for this script to have any effect
# Go back and do this if necessary before proceeding
# Make sure that you have 'reflector' installed before proceeding: "sudo pacman -S reflector"

########################################################################################

# Ensure the user is not running as root
if [ "$(id -u)" = 0 ]; then
	echo "######################################################################"
	echo "You shouldn't run this script as root."
	echo "Switch to a normal user with 'sudo' rights and run this script again."
	echo "You will be prompted for a 'sudo' password when needed during install."
	echo "######################################################################"
	exit 1
fi

error() { \
	clear; printf "ERROR:\\n%s\\n" "$1" >&2; exit 1;
}

# Ensure system clock is accurate
sudo timedatectl set-ntp true
sudo hwclock --systohc

# Set the mirrorlist using 'reflector'
sudo reflector -c 'United States' -a 10 --sort rate --save /etc/pacman.d/mirrorlist

# Install 'paru' AUR helper
git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si --noconfirm

# Install the GNOME desktop environment with GDM display manager and firefox
sudo pacman -S --noconfirm xorg gdm gnome firefox
sudo systemctl enable gdm

# If you want to install more default gnome apps, uncomment the line below
# These apps are (in my opinion) mostly useless games and bloatware, but to each their own
#sudo pacman -S gnome-extra

# The only useful package (in my opinion) from gnome-extra you might want is gnome-tweaks
# Uncomment the line below to install gnome-tweaks
#sudo pacman -S gnome-tweaks

# Install ufw firewall and gui app
sudo pacman -S --noconfirm ufw gufw
sudo systemctl enable ufw.service

# Reboot the machine
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
sudo reboot

########################################################################################
