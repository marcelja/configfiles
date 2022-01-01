scriptpath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "let profile = \"1\"" > ~/.config/configfiles/profiles/profile.vim
echo "--theme=\"Monokai Extended Light\"" > ~/.config/bat/config
echo "include $scriptpath/papercolor_kitty_light.conf" > ~/.config/configfiles/profiles/profile.kitty
kitty @ set-colors -a -c $scriptpath/papercolor_kitty_light.conf

[ -f /usr/bin/osascript ] && osascript -e \
    'tell application "System Events" to tell appearance preferences to set dark mode to false'
[ -f /usr/bin/gsettings ] && gsettings set org.gnome.desktop.interface gtk-theme Breeze
sed -i.bak 's/syntax-theme=Dracula/syntax-theme=GitHub/' ~/.gitconfig
