#!/usr/bin/env bash

source ./scriptdata/functions.sh

# Install basic packages
sudo pacman -S --noconfirm --needed base-devel git fish

if ! check_dep paru; then
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
paru -S --noconfirm - <./scriptdata/pkgs.txt

sudo systemctl enable sddm

xdg-user-dirs-update

# Fonts
rm -rf ~/.local/share/{themes,fonts}
mkdir -p ~/.local/share/{themes,fonts}
git clone https://github.com/dm1nh/fonts.git
cp ./fonts/{Astro-Patched,Material-Icons,NotoColorEmoji-Regular.ttf}
rm -rf fonts
fc-cache -r

# Wallpapers
sudo cp ./wallpapers/greeting.png /usr/share/sddm/themes/sugar-candy/Backgrounds/

# Install GTK themes
git clone https://github.com/dangminhngo/themix-generator.git
cp -R themix-generator/themes/Crux-Midnight ~/.local/share/themes/
rm -rf themix-generator

# Backup old configs
mv ~/.config ~/.config.backup
ln -s ~/.dotfiles/config ~/.config
# Copy common system configs
sudo cp -R ./misc/sddm.conf.d /etc/
cp ./misc/.gitconfig ~/
cp -R ./misc/.icons ~/

# Remove default cursor theme
sudo rm -rf /usr/share/icons/default

# fnm
if ! check_dep fnm; then
  curl -fsSL https://fnm.vercel.app/install | bash
fi

# pnpm
if ! check_dep pnpm; then
  curl -fsSL https://get.pnpm.io/install.sh | sh -
fi

# bun
if ! check_dep bun; then
  curl -fsSL https://bun.sh/install | bash # for macOS, Linux, and WSL
fi

# Run Docker with current user privileges
sudo usermod -aG docker $USER

# Fix ags cannot launch because it can find `bun` executable
sudo ln -s ~/.bun/bin/bun /usr/bin/bun

paru -Rns $(paru -Qdtq)
paru -Scc --noconfirm

echo "Reboot to your system and Happy coding!"
