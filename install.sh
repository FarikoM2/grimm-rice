#!/bin/bash

echo "[+] Instalando entorno minimalista con bspwm..."

# 1. Crear carpetas necesarias
mkdir -p ~/.config/bspwm ~/.config/sxhkd ~/.config
mkdir -p ~/.fonts
mkdir -p ~/wallpapers

# 2. Copiar configuraciones
cp ./config/bspwmrc ~/.config/bspwm/bspwmrc
cp ./config/sxhkdrc ~/.config/sxhkd/sxhkdrc
cp ./config/picom.conf ~/.config/picom.conf
cp ./xinitrc ~/.xinitrc
cp ./Xresources ~/.Xresources

# 3. Copiar wallpapers y fuentes
cp ./wallpapers/* ~/wallpapers/
cp ./fonts/*/* ~/.fonts/

# 4. Recargar fuentes
fc-cache -fv > /dev/null

# 5. Dar permisos de ejecución
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.xinitrc

# 6. (Opcional) Instalar dependencias
read -p "¿Deseas instalar los paquetes base? [s/N] " RESP
if [[ "$RESP" == "s" || "$RESP" == "S" ]]; then
    sudo apt update
    sudo apt install -y bspwm sxhkd rxvt-unicode rofi picom feh xorg xinit fonts-fonts-dejavu
fi

echo "[✓] Todo listo. Ejecuta 'startx' para comenzar."
