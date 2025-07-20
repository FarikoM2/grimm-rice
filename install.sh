#!/bin/bash

echo "[+] Instalando entorno minimalista con bspwm..."

# 1. Instalar dependencias
sudo apt update
sudo apt install -y bspwm sxhkd rxvt-unicode rofi picom feh xorg xinit x11-xserver-utils unzip wget

# 2. Crear carpetas necesarias
mkdir -p ~/.config/{bspwm,sxhkd,picom} ~/.fonts ~/wallpapers /tmp/grimm-fonts

# 3. Copiar configuraciones
cp ./config/bspwmrc ~/.config/bspwm/bspwmrc
cp ./config/sxhkdrc ~/.config/sxhkd/sxhkdrc
cp ./config/picom.conf ~/.config/picom/picom.conf
cp ./xinitrc ~/.xinitrc
cp ./Xresources ~/.Xresources
cp ./wallpapers/* ~/wallpapers/

# 4. Descargar e instalar fuentes desde fonts.list
echo "[+] Descargando e instalando fuentes..."
while read -r url; do
    # 🔧 Limpiar URL por si viene con \r (errores Windows)
    url_clean=$(echo "$url" | tr -d '\r')
    wget -q -P /tmp/grimm-fonts "$url_clean"

    # Extraer
    zip_file=$(ls -t /tmp/grimm-fonts/*.zip 2>/dev/null | head -n1)
    [ -f "$zip_file" ] && unzip -oq "$zip_file" -d /tmp/grimm-fonts
done < ./fonts/fonts.list

# 5. Copiar fuentes a ~/.fonts
find /tmp/grimm-fonts -iname "*.ttf" -exec cp -n {} ~/.fonts/ \;
find /tmp/grimm-fonts -iname "*.otf" -exec cp -n {} ~/.fonts/ \;

# 6. Recargar caché de fuentes
fc-cache -fv > /dev/null

# 7. Limpiar temporales
rm -rf /tmp/grimm-fonts

# 8. Dar permisos de ejecución
chmod +x ~/.config/bspwm/bspwmrc ~/.xinitrc

echo "[✓] Instalación completada. Ejecuta 'startx' para comenzar."
