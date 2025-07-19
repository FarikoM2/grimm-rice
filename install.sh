#!/bin/bash

echo "[+] Instalando entorno minimalista con bspwm..."

# 1. Instalar dependencias
sudo apt update
sudo apt install -y bspwm sxhkd rxvt-unicode rofi picom feh xorg xinit unzip

# 2. Crear carpetas necesarias
mkdir -p ~/.config/bspwm ~/.config/sxhkd ~/.config
mkdir -p ~/.fonts
mkdir -p ~/wallpapers
mkdir -p /tmp/grimm-fonts
mkdir -p /tmp/grimm-fonts/unpacked

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
    echo "Descargando: $url"
    wget --content-disposition --trust-server-names -P /tmp/grimm-fonts "$url"

    # Extraer el archivo más reciente descargado
    last_zip=$(find /tmp/grimm-fonts -name "*.zip" -type f -printf "%T@ %p\n" | sort -n | tail -1 | cut -d' ' -f2-)

    if file "$last_zip" | grep -q "Zip archive data"; then
        unzip -qq "$last_zip" -d /tmp/grimm-fonts/unpacked
    else
        echo "[!] Error: $last_zip no es un archivo ZIP válido."
    fi
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
