--------- INSTALL YAY ---------
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay --version

--------- Instalar Brave ---------
yay -S brave-bin

--- Paquetes para Maquina Virtual ---
pacman -S gtkmm
pacman -S open-vm-tools
pacman -S xf86-video-vmware xf86-input-vmmouse
systemctl enable vmtoolsd                       # Habilitar un demonio

--------- Instalar Utilidades ---------
sudo pacman -S kitty firefox htop gtop neofetch wget p7zip

- Opcional -
pacman -S impacket