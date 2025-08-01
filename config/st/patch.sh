#!/bin/bash

# xresources
echo '⭐🚨 Installing xresources'
curl -O https://st.suckless.org/patches/xresources/st-xresources-20200604-9ba7ecf.diff
patch -p1 < st-xresources-20200604-9ba7ecf.diff

# scrollback
echo '⭐🚨 Installing scrollback'
curl -O https://st.suckless.org/patches/scrollback/st-scrollback-0.9.2.diff
patch -p1 < st-scrollback-0.9.2.diff

# alpha
# echo '⭐🚨 Installing alpha'
# curl -O https://st.suckless.org/patches/alpha/st-alpha-0.8.2.diff
# patch -p1 < st-alpha-0.8.2.diff

# externalpipe
# echo 'Installing externalpipe'
# curl -O https://st.suckless.org/patches/externalpipe/st-externalpipe-0.8.5.diff
# patch -p1 < st-externalpipe-0.8.5.diff

# newterm
# echo 'Installing newterm'
# curl -O https://st.suckless.org/patches/newterm/st-newterm-0.9.diff
# patch -p1 < st-newterm-0.9.diff

# iso14755
# echo 'Installing iso14755'
# curl -O https://st.suckless.org/patches/iso14755/st-iso14755-0.8.5.diff
# patch -p1 < st-iso14755-0.8.5.diff
