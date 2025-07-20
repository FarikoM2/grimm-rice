#!/bin/bash

echo "[+] Instalando entorno minimalista con bspwm..."

# 1. Instalar dependencias
sudo apt install -y bspwm sxhkd rxvt-unicode rofi picom feh xorg xinit x11-xserver-utils unzip nano

# 2. Crear carpetas necesarias
mkdir -p ~/.config/bspwm ~/.config/sxhkd ~/.config/picom
mkdir -p ~/.fonts
mkdir -p ~/wallpapers
mkdir -p /tmp/grimm-fonts

# 3. Copiar configuraciones
cp ./config/bspwmrc ~/.config/bspwm/bspwmrc
cp ./config/sxhkdrc ~/.config/sxhkd/sxhkdrc
cp ./config/picom.conf ~/.config/picom/picom.conf
cp ./xinitrc ~/.xinitrc
cp ./Xresources ~/.Xresources
cp ./wallpapers/* ~/wallpapers/

# 4. Descargar e instalar fuentes desde fonts.list
echo "[+] Descargando fuentes..."
while read -r url; do
    echo "Descargando: $url"
    wget -P /tmp/grimm-fonts "$url"

    # Extraer inmediatamente después de descargar
    zip_file=$(ls -t /tmp/grimm-fonts/*.zip 2>/dev/null | head -n1)
    [ -f "$zip_file" ] && unzip -qq "$zip_file" -d /tmp/grimm-fonts
done < ./fonts/fonts.list

# 5. Mover las fuentes instaladas
find /tmp/grimm-fonts -iname "*.ttf" -exec cp {} ~/.fonts/ \;
find /tmp/grimm-fonts -iname "*.otf" -exec cp {} ~/.fonts/ \;

# 6. Limpiar archivos temporales
rm -rf /tmp/grimm-fonts

# 7. Recargar caché de fuentes
fc-cache -fv > /dev/null

# 8. Dar permisos de ejecución
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.xinitrc

echo "[✓] Instalación completada. Ejecuta 'startx' para comenzar."
