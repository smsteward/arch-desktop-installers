#!/bin/sh

# It is assumed that you have already partitioned your disks how you want
# If you haven't done this already, go back and do it now before continuing

# Ensure system clock is accurate
sudo timedatectl set-ntp true

# Set the mirrorlist using 'reflector'
sudo reflector -c 'United States' -a 10 --sort rate --save /etc/pacman.d/mirrorlist

# Install 'paru' AUR helper
git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si --noconfirm

# Install the XFCE desktop environment with lightdm display manager
sudo pacman -S --noconfirm xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings xfce4 xfce4-goodies

# Enable lightdm display manager
sudo systemctl enable lightdm

# Reboot the machine
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
sudo reboot
