export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR=/usr/bin/nvim
export BROWSER=/usr/bin/firefox-developer-edition
export TERMINAL=/usr/bin/kitty


# Disable HDMI
pactl set-card-profile alsa_card.pci-0000_01_00.1 off &
# night light
redshift -l 53.629593:11.414763 &
# hotkey daemon
sxhkd &
# set wallpaper
feh --bg-scale ~/.config/wall &
# set colors
wal -R

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
nm-applet &
xfce4-power-manager &
#fix_xcursor

# multi monitor setup
cmode=`optimus-manager --print-mode | grep -o "intel\|nvidia"`
if [ "$cmode" = "nvidia" ]; then 
    autorandr -l hdmi-left
    compton -b
fi
