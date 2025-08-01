#!/bin/bash

echo "[+] Grimm Dotfiles - Instalación Core Completa"
echo "    Esto incluye: bspwm + sxhkd + polybar + picom + rofi + fuentes"
echo ""

# Verificar si el usuario quiere continuar
read -p "¿Continuar con la instalación? [y/N]: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "[!] Instalación cancelada"
    exit 1
fi

# Ejecutar instalación core
./scripts/install-core.sh

echo ""
echo "[✓] Instalación Core completada!"
echo ""
echo "▶️  Para iniciar: startx"