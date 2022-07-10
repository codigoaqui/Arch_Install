# ------------------        ------------------ #
<                    INICIO                    >
# ------------------       ------------------ #

---------- RED -----------

ip link                                                                           # Se usa para listar las redes
ip link set wlan0 up                                                              # Levanta el servicio de la red Wi-Fi
iwlist wlan0 scan | more                                                          # Para listar las redes y sus ESSID
iwconfig wlan0 essid "nombre de la red"                                           # Se usa en caso de no tener contraseña en la red Wi-Fi
iwconfig wlan0 essid "nombre de la red" key s:"contraseña"                        # Se usa si la red es WPA2
wpa_passphrase "nombre de la red" "contraseña" > /etc/nombre_del_archivo_deseado  # Se usa si la red es WPA
wpa_supplicant -B -i wlan0 -D wext -c /etc/nombre_del_archivo_creado              # Se conecta a la red
dhclient                                                                          # Crea la conexión

-------- PARTICIONADO DE DISCO -------------

ls /sys/firmware/efi/efivars                             # Si al ejecutar este comando sale un listado, es un ordenador UEFI caso contrario es BIOS
fdisk -l                                                 # Para listar nuestros discos duros

# El particionado del disco depende de la maquina que tenemos, en este caso es UEFI
cfdisk /dev/sda (en formato gpt)                         # Tambien podemos usar cfdisk y ahí elegir el disco deseado
partición /dev/sda1  512M [Type] = EFI System            # /boot
partición /dev/sda2  4G   [Type] = Linux swap            # /swap
partición /dev/sda3  80G  [Type] = Linux filesystem      # /
partición /dev/sda4  100G [Type] = Linux filesystem      # /home

# Nota: Para la partición / y la partición /home el [Type] es Linux filesystem normalmente lo pone por default

[Write]
yes
[Quit]

--------- FORMATEAR PARTICIONES ---------

mkfs.vfat -F 32 /dev/sda1                              # Para partición /boot
mkfs.ext4 /dev/sda3                                    # Para partición /root
mkfs.ext4 /dev/sda4                                    # Para partición /home
mkswap /dev/sda2                                       # Para sistema   /swap
swapon                                                 # Para activar el swap

--------- MONTAR PARTICIONES ---------

mount /dev/sda3 /mnt                                   # Montar la partición raiz
mkdir /mnt/boot                                        # creamos el directorio boot para montar la partición boot
mkdir /mnt/boot/efi                                    # creamos el directorio boot para montar el sitema de archivos efi
mount /dev/sda1 /mnt/boot/efi                          # montamos la partición boot en el directorio
mkdir /mnt/home                                        # creamos el directorio para home
mount /dev/sda4 /mnt/home                              # montamos la partición home en el directorio

-------- INSTALAR EL SISTEMA BASE ---------

pacstrap /mnt linux linux-firmware nano grub networkmanager wpa_supplicant base base-devel efibootmgr dhcpcd netctl dialog

--------- GENERAR EL FICHERO DE PARTICIONES 'fstab' ---------

genfstab /mnt >> /mnt/etc/fstab   o   genfstab -U /mnt > /mnt/etc/fstab
cat !$                                              # Para ver como han quedado las particiones

--------- DEFINIR USUARIOS DEL SISTEMA ---------
arch-chroot /mnt                                    # Para ponernos como root
echo "nombreDeEquipoDeseado" > /etc/hostname        # Crear el nombre de la maquina
passwd  "contraseña"                                # Crear la contraseña del usuario root
passwd  "confirmar_contraseña"

--------- CREAR USUARIO Y CONTRASEÑA ---------
useradd -m "usuario"
passwd "usuario"

--------- Agregar usuario al grupo wheel ---------
usermod -aG wheel "usuario"
groups "usuario"

pacman -S sudo                                     # Instalar sudo
nano /etc/sudoers                                  # Editar el archivo de sudoers en (## Uncomment to allow menbers of group wheel to execute any command) descomentar dicha linea

--------- comprobamos que funciona ---------
su "usuario"                                       # Cambiar a nuestro usuario
sudo su

--------- Configurar Zona Horaria ---------
timedatectl list-timezones
ln -sf /usr/share/zoneinfo/America/Costa_Rica /etc/localtime
nano /etc/locale.gen
locale-gen
hwclock -w
echo KEYMAP=la-latin1 > /etc/vconsole.conf
echo LANG=es_CR.UTF8 > /etc/locale.conf

--------- Instalar GRUB ---------
grub-install --efi-directory=/boot/efi --bootloader 'Arch Linux' --target=x86_64-efi
grub-mkconfig -o /boot/grub/grub.cfg

--------- Editar Host ---------
nano /etc/host
127.0.0.1    localhost
::1          localhost
127.0.0.1    hostname.localhost hostname

exit
umount -R /mnt
reboot

# Despues de reiniciar nos ponemos como root para ejecutar los siguientes comandos
systemctl start NetworkManager.service
systemctl enable NetworkManager.service
systemctl start wpa_supplicant.service
systemctl enable wpa_supplicant.service

ip link set "red" up                                                # Ejemplo wlo1
nmcli dev wifi connect "nombre de red" password "password de red"

# ------------------        ------------------ #
<            SISTEMA INSTALADO FIN             >
# ------------------       ------------------ #