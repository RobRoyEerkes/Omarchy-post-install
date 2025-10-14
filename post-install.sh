#!/bin/bash



echo "Installing packages"
yay -Syu --noconfirm --needed zen-browser-bin rmpc mpd stow ghostty udisks2 openrgb glab kitty

xdg-settings set default-web-browser zen.desktop
zen-browser
killall zen-browser

if gh auth status &>/dev/null; then
    echo "✅ GitHub CLI already authenticated."
else
    echo "🔑 Logging into GitHub..."
    gh auth login -p https -w -c
	gh auth setup-git
fi


echo "Installing dotfiles"
# nvim installation
rm -rf ~/.config/nvim/
rm -rf ~/.config/uwsm/
rm -rf ~/.config/ghostty/
rm -rf ~/.config/hypr/
rm -rf dotfiles
git clone -b omarchy https://github.com/RobRoyEerkes/dotfiles
cd dotfiles
git checkout omarchy
stow -S {nvim,rmpc,ghostty,uwsm,hypr}
cd

mkdir -p ~/Music/{Playlists,lyrics}
systemctl --user enable --now mpd
