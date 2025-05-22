sudo pacman -S --needed git base-devel gnome-shell gnome-tweaks
git clone https://github.com/micheleg/dash-to-dock.git
cd dash-to-dock
make install
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop', 'trash://']"
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true