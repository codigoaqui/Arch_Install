----INSTALAR BSPWM ----
sudo pacman -S lightdm lightdm-gtk-greeter
nano /etc/lightdm/lightdm.conf # editamos la linea de greeter-session en la parte de [Seat:*] y ponemos "greeter-session = lightdm-gtk-greeter"

sudo systemctl enable lightdm.service # habilitamos el servicio para que en el proximo reinicio nos aparezca
sudo pacman -S bspwm sxhkd dmenu nitrogen picom alacritty arandr  # Instalar paquetes para el BSPWM
nano .xprofile  # Añadir fichero .xprofile
# agregar
sxhkd &
exec bspwm

mkdir .config  # Creamos la carpeta de .config
cd .config/    # Nos metemos en la carpeta
mkdir bspwm    # Creamos la carpeta de bspwm
mkdir sxhkd    # Creamos la carpeta de sxhkd
ls
cd /usr/share/doc/bspwm/
cd examples
cp bspwmrc ~/.config/bspwm/
cp sxhkdrc ~/.config/sxhkd/
cd
sudo nano .config/sxhkd/sxhkdrc # Para cambiar la terminal por defecto a alguna otra

reboot