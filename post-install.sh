#!/bin/bash

if gh auth status &>/dev/null; then
    echo "✅ GitHub CLI already authenticated."
else
    echo "🔑 Logging into GitHub..."
    gh auth login -p https -w -c
	gh auth setup-git
fi


yay -S --noconfirm --needed zen-browser-bin rmpc mpd stow ghostty

# nvim installation
rm -rf ~/.config/nvim/
rm -rf ~/.config/uwsm/
rm -rf ~/.config/ghostty/
git clone https://github.com/RobRoyEerkes/dotfiles
cd dotfiles
stow -S {nvim, rmpc, ghostty, uwsm}
xdg-settings set default-web-browser zen.desktop

systemctl --user enable --now mpd
