#!/bin/bash

echo "[+] Instalando paquetes base..."
sudo apt update
sudo apt install -y \
    xserver-xorg xinit \
    bspwm sxhkd \
    polybar \
    picom rofi \
    rxvt-unicode \
    feh xorg \
    x11-xserver-utils \
    unzip wget \
    build-essential

echo "[+] Creando estructura de directorios..."
mkdir -p ~/.config/{bspwm,sxhkd,polybar,picom,rofi}
mkdir -p ~/.fonts ~/wallpapers

echo "[+] Instalando fuentes..."
./scripts/install-fonts.sh

echo "[+] Copiando configuraciones..."
./scripts/setup-configs.sh

echo "[+] Configurando permisos..."
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.xinitrc

echo "[✓] Core instalado correctamente"