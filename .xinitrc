xrdb ~/.Xresources &

# Run scripts
~/scripts/update_status_bar &

# Run X programs
exec dbus-launch dwm
