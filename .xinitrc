xrdb ~/.Xresources &

# Run scripts
~/scripts/update_status_bar &

# Set kb repeat and delay
xset r rate 250 30

# Run X programs
exec dbus-launch dwm
