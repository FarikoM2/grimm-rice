#!/bin/bash

# Cargar colores
source "$(dirname "$0")/../resources/colors/grimm.conf"

echo "[+] Copiando archivos de configuración..."

# X11
cp ./config/x11/xinitrc ~/.xinitrc
cp ./config/x11/Xresources ~/.Xresources

# BSPWM
cp ./config/bspwm/bspwmrc ~/.config/bspwm/

# SXHKD
cp ./config/sxhkd/sxhkdrc ~/.config/sxhkd/

# Polybar
cp ./config/polybar/config.ini ~/.config/polybar/config
cp -r ./config/polybar/modules ~/.config/polybar/

# Picom
cp ./config/picom/picom.conf ~/.config/picom/

# Rofi
cp ./config/rofi/config.rasi ~/.config/rofi/
cp ./config/rofi/grimm.rasi ~/.config/rofi/

# Wallpapers
cp ./resources/wallpapers/* ~/wallpapers/

echo "[+] Aplicando esquema de colores..."
# Aquí se pueden hacer sustituciones de variables de color en los archivos
sed -i "s/{{PRIMARY}}/$PRIMARY/g" ~/.config/polybar/config.ini
sed -i "s/{{BACKGROUND}}/$BACKGROUND/g" ~/.config/polybar/config.ini
# ... más sustituciones según sea necesario

echo "[✓] Configuraciones aplicadas"