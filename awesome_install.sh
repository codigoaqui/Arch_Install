----- AUR -----
pacman -S git
mkdir -p Desktop/username/repos
cd !$

-- Clonar paru --
# Debemos estar com usuario no priviligiado
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin/
makepkg -si

-- Instalar repos de blackarch --
cd ..
mkdir blackarch
cd blackarch/
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo su
./strap.sh
pacman -Sy # Para ver si contempla blackarch en los repositorios

- Opcional -
pacman -S impacket

--- Instalar Interfaz Xorg ---
pacman -S xorg xorg-server

--- Instalar gnome ---
pacman -S gnome
pacman -S kitty

systemctl start gdm.service
systemctl enable gdm.service


--- Paquetes para Maquina Virtual ---
pacman -S gtkmm
pacman -S open-vm-tools
pacman -S xf86-video-vmware xf86-input-vmmouse

systemctl enable vmtoolsd # Habilitar un demonio

-- Instalar Firefox --
pacman -S firefox

-- Instalar dotfiles --
github.com/rxyhn/dotfiles

paru -S awesome-git picom-git wezterm rofi acpi acpid acpi_call upower lxappearance-gtk3 \
jq inotify-tools polkit-gnome xdotool xclip gpick ffmpeg blueman redshift \
pipewire pipewire-alsa pipewire-pulse pamixer brightnessctl feh scrot \
mpv mpd mpc mpdris2 python-mutagen ncmpcpp playerctl --needed

systemctl --user enable mpd.service
systemctl --user start mpd.service

sudo systemctl enable acpid.service
sudo systemctl start acpid.service

-- Instalar wget --
sudo pacman -S wget

-- Install 7z --
pacman -S p7zip

-- Instalar  Fuentes --
cd /usr/share/fonts
sudo su
wget http://fontlot.com/downfile/5baeb08d06494fc84dbe36210f6f0ad5.105610
file 5baeb08d06494fc84dbe36210f6f0ad5.105610

mv 5baeb08d06494fc84dbe36210f6f0ad5.105610 comprimido.zip
unzip comprimido.zip

find . | grep "\.ttf$" | while read line; do cp $line .; done

rm comprimido.zip
rm -r iosevka-2.2.1/
rm -r iosevka-slab-2.2.1/

-- Icomoon --
https://dropbox.com/s/hrkub2yo9iapljz/icomoon.zip?dl=0

mv /home/nelson/Descargas/icomoon.zip . # Mover el archivo al directorio actual
unzip icomoon.zip
mv icomoon/*.ttf .
rm -rf icomoon
exit

paru -S nerd-fonts-jetbrains-mono ttf-font-awesome ttf-font-awesome-4 ttf-material-design-icons

cd                                  # Para ir a nuestro direcorio personal
cd Desktop/nelson/repos/            # Para ingresar en el directorio de repos
- Clonar repo -
git clone https://github.com/rxyhn/dotfiles.git
cd dotfiles

cp -r config/* ~/.config/
cp -r bin/* ~/.local/bin/
cp -r misc/. ~/

cd Desktop/nelson/repos
cd dotfiles
git log
git log | grep commit | grep "c1e2"
git checkout $(git log | grep commit | grep "c1e2" | awk ´NF{print $NF}´)

cp -r config/* ~/.config/
cp -r bin/* ~/.local/bin/
cp -r misc/ ~/

reboot