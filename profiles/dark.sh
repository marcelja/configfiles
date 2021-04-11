scriptpath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "let profile = \"2\"" > ~/.config/configfiles/profiles/profile.vim
echo "" > ~/.config/bat/config
echo "include $scriptpath/papercolor_kitty_dark.conf" > ~/.config/configfiles/profiles/profile.kitty
kitty @ set-colors -a -c $scriptpath/papercolor_kitty_dark.conf

[ -f /usr/bin/osascript ] && osascript -e \
    'tell application "System Events" to tell appearance preferences to set dark mode to true'
