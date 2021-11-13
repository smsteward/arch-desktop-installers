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

# Install the XFCE desktop environment with lightdm display manager
sudo pacman -S --noconfirm xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings xfce4 xfce4-goodies
sudo systemctl enable lightdm

# Install ufw firewall and gui app
sudo pacman -S --noconfirm ufw gufw
sudo systemctl enable ufw

# Reboot the machine
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
sudo reboot

########################################################################################
