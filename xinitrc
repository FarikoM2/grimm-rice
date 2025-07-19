#!/bin/sh

# Cargar configuración de Xresources (URxvt, Catppuccin, etc)
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

sxhkd &                            # Atajos de teclado
picom --config ~/.config/picom.conf &  # Compositor (transparencias)
feh --bg-scale ~/wallpapers/0002.png &  # Fondo de pantalla

exec bspwm                        # Iniciar window manager
