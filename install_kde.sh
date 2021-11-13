#!/bin/sh

# It is assumed that you have already partitioned your disks and used 'pacstrap' to install the base system, and are chrooted into your new Arch install by using 'arch-chroot /mnt', assuming you have been following the installation guide and mounted your install at '/mnt'. Adjust your path as necessary, but you need to be in your newly installed system for this script to have any effect
# Go back and do this if necessary before proceeding
# Make sure that you have 'reflector' installed before proceeding: "sudo pacman -S reflector"

########################################################################################

# Ensure system clock is accurate
sudo timedatectl set-ntp true
sudo hwclock --systohc

# Set the mirrorlist using 'reflector'
sudo reflector -c 'United States' -a 10 --sort rate --save /etc/pacman.d/mirrorlist

# Install 'paru' AUR helper
git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si --noconfirm

# Install the KDE Plasma desktop environment with SDDM display manager
sudo pacman -S --noconfirm xorg sddm plasma firefox
sudo systemctl enable sddm

# If you want to install some of the default KDE applications, uncomment the line below
#sudo pacman -S kde-applications

# If you decide not to install the bulk KDE applications below, here are a few I still recommend (uncomment the line below to install them)
#sudo pacman -S --noconfirm kate ark okular

# Install ufw firewall and gui app
sudo pacman -S ufw gufw
sudo systemctl enable ufw

# Reboot the machine
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
sudo reboot

########################################################################################
