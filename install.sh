#!/bin/bash

echo "[+] Instalando entorno minimalista con bspwm..."

# 1. Instalar dependencias
sudo apt update
sudo apt install -y bspwm sxhkd rxvt-unicode rofi picom feh xorg xinit unzip wget

# 2. Crear carpetas necesarias
mkdir -p ~/.config/bspwm ~/.config/sxhkd ~/.config
mkdir -p ~/.fonts
mkdir -p ~/wallpapers
mkdir -p /tmp/grimm-fonts

# 3. Copiar configuraciones
cp ./config/bspwmrc ~/.config/bspwm/bspwmrc
cp ./config/sxhkdrc ~/.config/sxhkd/sxhkdrc
cp ./config/picom.conf ~/.config/picom.conf
cp ./xinitrc ~/.xinitrc
cp ./Xresources ~/.Xresources
cp ./wallpapers/* ~/wallpapers/

# 4. Descargar e instalar fuentes desde fonts.list
echo "[+] Descargando fuentes..."
while read -r url; do
    filename=$(basename "$url")
    wget -q --show-progress -O /tmp/grimm-fonts/"$filename" "$url"
    unzip -qq /tmp/grimm-fonts/"$filename" -d /tmp/grimm-fonts/unpacked
done < ./fonts/fonts.list

# 5. Mover las fuentes instaladas
find /tmp/grimm-fonts/unpacked -iname "*.ttf" -exec cp {} ~/.fonts/ \;
find /tmp/grimm-fonts/unpacked -iname "*.otf" -exec cp {} ~/.fonts/ \;

# 6. Limpiar archivos temporales
rm -rf /tmp/grimm-fonts

# 7. Recargar caché de fuentes
fc-cache -fv > /dev/null

# 8. Dar permisos de ejecución
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.xinitrc

echo "[✓] Instalación completada. Ejecuta 'startx' para comenzar."
