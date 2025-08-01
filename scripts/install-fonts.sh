#!/bin/bash

echo "[+] Descargando e instalando fuentes..."

# Crear directorio temporal
mkdir -p /tmp/grimm-fonts

# Leer y descargar fuentes desde fonts.list
while read -r url; do
    # Limpiar URL (eliminar \r de Windows si existe)
    url_clean=$(echo "$url" | tr -d '\r')
    
    # Saltar líneas vacías o comentarios
    [[ -z "$url_clean" || "$url_clean" =~ ^#.*$ ]] && continue
    
    echo "  Descargando: $url_clean"
    wget -P /tmp/grimm-fonts "$url_clean"
    
    # Extraer si es ZIP
    zip_file=$(ls -t /tmp/grimm-fonts/*.zip 2>/dev/null | head -n1)
    if [ -f "$zip_file" ]; then
        unzip -oq "$zip_file" -d /tmp/grimm-fonts
        rm "$zip_file"
    fi
done < ./resources/fonts/fonts.list

# Copiar fuentes a ~/.fonts
echo "[+] Instalando fuentes en ~/.fonts..."
find /tmp/grimm-fonts -iname "*.ttf" -exec cp -n {} ~/.fonts/ \;
find /tmp/grimm-fonts -iname "*.otf" -exec cp -n {} ~/.fonts/ \;

# Copiar fuentes locales si existen
if [ -d "./resources/fonts/local" ]; then
    cp ./resources/fonts/local/*.{ttf,otf} ~/.fonts/ 2>/dev/null || true
fi

# Recargar caché de fuentes
echo "[+] Recargando caché de fuentes..."
fc-cache -fv > /dev/null 2>&1

# Limpiar temporales
rm -rf /tmp/grimm-fonts

echo "[✓] Fuentes instaladas correctamente"