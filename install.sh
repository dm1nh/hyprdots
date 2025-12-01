#!/usr/bin/env bash

# Install basic packages
sudo pacman -S --noconfirm --needed base-devel git

if ! which paru >/dev/null; then
  sudo pacman -S --noconfirm --needed rustup

  # Install rustup toolchain
  rustup install stable
  rustup default stable

  sleep 1

  # Install Paru
  git clone https://aur.archlinux.org/paru.git
  pushd paru
  makepkg -si --noconfirm
  popd
  rm -rf paru
fi

paru -Syy --noconfirm
paru -Sy --noconfirm archlinux-keyring
paru -S --noconfirm - <./pkgs.txt

# Create user directories
xdg-user-dirs-update
rm -rf ~/.local/share/{themes,fonts}
mkdir -p ~/.local/share/{themes,fonts}

# Copy fonts
cp -r ./fonts/{HollowNightNerdFont,MaterialSymbols,NotoColorEmoji-Regular.ttf} ~/.local/share/fonts/
fc-cache -r

# Install sddm astronaut theme
sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
sudo cp ./config/sddm-astronaut-theme/astronaut.conf /usr/share/sddm/themes/sddm-astronaut-theme/Themes/
sudo cp ./config/hpaper/wallpapers/login-background.png /usr/share/sddm/themes/sddm-astronaut-theme/Backgrounds/

# Fix function keys on apple keyboards or other machenical keyboards
sudo cp -r ./misc/modprobe.d /etc/

# Install GTK themes
cp -r ./themes/Trop-Green-Dark-Medium ~/.local/share/themes/

# Backup old configs
mv ~/.config ~/.config.backup
ln -s ~/.dots/config ~/.config

# Copy common system configs
# sudo cp -R ./misc/xorg.conf.d /etc/X11/
sudo cp -R ./misc/sddm.conf.d /etc/
cp ./misc/.gitconfig ~/
cp -R ./misc/.icons ~/
sudo cp ./misc/reflector.conf /etc/xdg/reflector/

# Remove default cursor theme
sudo rm -rf /usr/share/icons/default

# pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Run Docker without sudo
sudo usermod -aG docker $USER

# Enable systemctl services
sudo systemctl enable sddm.service
sudo systemctl enable docker.service
sudo systemctl enable reflector.service
systemctl --user enable pipewire.service pipewire-pulse.service wireplumber.service
systemctl --user --now enable wireplumber.service

paru -Rns $(paru -Qdtq)
paru -Scc --noconfirm

xdg-user-dirs-update

echo "Reboot to your system and Happy working!"
