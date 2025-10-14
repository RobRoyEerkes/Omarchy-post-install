#!/bin/bash

if gh auth status &>/dev/null; then
    echo "✅ GitHub CLI already authenticated."
else
    echo "🔑 Logging into GitHub..."
    gh auth login -p https -w -c
	gh auth setup-git
fi


yay -S --noconfirm --needed zen-browser-bin rmpc mpd stow ghostty udisks2 openrgb glab
if glab auth status &>/dev/null; then
    echo "✅ GitLab CLI already authenticated."
else
    echo "🔑 Logging into GitHub..."
    glab auth login --hostname gitlab.com
	
	git config --global credential.https://gitlab.com.helper '!/usr/bin/glab auth git-credential'
fi



# nvim installation
rm -rf ~/.config/nvim/
rm -rf ~/.config/uwsm/
rm -rf ~/.config/ghostty/
git clone -b omarchy https://github.com/RobRoyEerkes/dotfiles
cd dotfiles
stow -S {nvim,rmpc,ghostty,uwsm}
cd
xdg-settings set default-web-browser zen.desktop

mkdir -p ~/Music/{Playlists,lyrics}
systemctl --user enable --now mpd
