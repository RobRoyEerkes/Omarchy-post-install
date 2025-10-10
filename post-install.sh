#!/bin/bash

gh auth login -p "https" -w -h "github.com"

yay -S --noconfirm --needed zen-browser-bin rmpc mpd stow ghostty

# nvim installation
rm -rf ~/.config/nvim/
rm -rf ~/.config/uwsm/
rm -rf ~/.config/ghostty/
git clone https://github.com/RobRoyEerkes/dotfiles
cd dotfiles
stow {nvim, rmpc, ghostty, uwsm}
xdg-settings set default-web-browser zen.desktop

systemctl --user enable --now mpd
