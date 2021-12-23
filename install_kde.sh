#!/usr/bin/env bash

# It is assumed that you have already partitioned your disks and used 'pacstrap' to install the base system, and are chrooted into your new Arch install by using 'arch-chroot /mnt', assuming you have been following the installation guide and mounted your install at '/mnt'. Adjust your path as necessary, but you need to be in your newly installed system for this script to have any effect
# Go back and do this if necessary before proceeding

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

# Install 'paru' AUR helper
git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si

# Install librewolf web browser
paru -S librewolf-bin

# Install the KDE Plasma desktop environment with SDDM display manager and pipewire with wireplumber
sudo pacman -S --noconfirm xorg sddm plasma pipewire pipewire-pulse wireplumber
systemctl --user enable --now wireplumber
sudo systemctl enable sddm

# Extra applications for KDE. Most are simply bloatware, so I don't recommend installing this package, but to each their own.
#sudo pacman -S kde-applications

# These are the KDE applications that I do recommend installing (Kwrite = text editor, Ark = archive manager, Okular = document viewer, Konsole = terminal emulator, Dolphin = file manager)
sudo pacman -S --noconfirm kwrite ark okular konsole dolphin

# I do a lot of theming, so these are some of the stock apps I have on my KDE desktop
sudo pacman -S --noconfirm latte-dock kvantum-qt5

# Miscellaneous apps (web browser, email client, etc)
sudo pacman -S --noconfirm thunderbird htop pass vlc neofetch libreoffice-fresh mpv youtube-dl curl wget

# Install ufw firewall and gui app
sudo pacman -S ufw gufw
sudo systemctl enable ufw.service
sudo ufw enable

# Reboot the machine
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
sudo reboot

########################################################################################
