#!/usr/bin/env bash

# Install basic packages
sudo pacman -S --noconfirm --needed base-devel git fish

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
paru -S --noconfirm - <./scriptdata/pkgs.txt

sudo systemctl enable sddm

xdg-user-dirs-update

# Fonts
rm -rf ~/.local/share/{themes,fonts}
mkdir -p ~/.local/share/{themes,fonts}
git clone https://github.com/dm1nh/fonts.git
cp -R ./fonts/{AstroNerdFont,MaterialIcons,NotoColorEmoji-Regular.ttf} ~/.local/share/fonts/
sudo cp -R ./fonts/OpenSans /usr/share/fonts/
rm -rf fonts
fc-cache -r

# Wallpapers
sudo cp ./wallpapers/greeting.png /usr/share/sddm/themes/sugar-candy/Backgrounds/

# Install GTK themes
git clone https://github.com/dm1nh/themix-generator.git
cp -R themix-generator/themes/Galax-Beige ~/.local/share/themes/
rm -rf themix-generator

# Backup old configs
mv ~/.config ~/.config.backup
ln -s ~/.dots/config ~/.config
# Copy common system configs
sudo cp -R ./misc/sddm.conf.d /etc/
cp ./misc/.gitconfig ~/
cp -R ./misc/.icons ~/

# Remove default cursor theme
sudo rm -rf /usr/share/icons/default

# fnm
if ! which fnm >/dev/null; then
  curl -fsSL https://fnm.vercel.app/install | bash
fi

# pnpm
if ! which pnpm >/dev/null; then
  curl -fsSL https://get.pnpm.io/install.sh | sh -
fi

# bun
if ! which bun >/dev/null; then
  curl -fsSL https://bun.sh/install | bash # for macOS, Linux, and WSL
fi
# fix ags cannot launch because it can find `bun` executable
sudo ln -s ~/.bun/bin/bun /usr/bin/bun

# Run Docker without sudo
sudo usermod -aG docker $USER

paru -Rns $(paru -Qdtq)
paru -Scc --noconfirm

echo "Reboot to your system and Happy working!"
