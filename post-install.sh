#!/bin/bash

if gh auth status &>/dev/null; then
    echo "✅ GitHub CLI already authenticated."
else
    echo "🔑 Logging into GitHub..."
    gh auth login -p https -w -c
	gh auth setup-git
fi


yay -S --noconfirm --needed zen-browser-bin rmpc mpd stow ghostty udisks2 openrgb glab expect
if glab auth status &>/dev/null; then
    echo "✅ GitLab CLI already authenticated."
else
    echo "🔑 Logging into GitLab..."
	#try scripted
    /usr/bin/expect -c "spawn glab auth login --hostname gitlab.com;
	expect "What GitLab instance do you want to log into?";
	send "gitlab.com\r";
	expect "How would you like to authenticate?";
	send "Web browser\r";
	interact;"
	git config --global credential.https://gitlab.com.helper '!/usr/bin/glab auth git-credential'
fi



# nvim installation
rm -rf ~/.config/nvim/
rm -rf ~/.config/uwsm/
rm -rf ~/.config/ghostty/
rm -rf dotfiles
git clone -b omarchy https://github.com/RobRoyEerkes/dotfiles
cd dotfiles
stow -S {nvim,rmpc,ghostty,uwsm}
cd
xdg-settings set default-web-browser zen.desktop

mkdir -p ~/Music/{Playlists,lyrics}
systemctl --user enable --now mpd
