#!/bin/bash

# This script is licensed under a 3-clause BSD License (ref.: LICENSE attached)
# License: https://opensource.org/licenses/BSD-3-Clause

# Nicer RGB format for gdbus color picker response
# Tested on Ubuntu 22.04 using Wayland desktop
# This is one of my first Bash scripts. Please pardon my noobiness. Just needed the job done.
#zenity Dialogs, desktop shortcut and icon added by github.com/coihue555 
# Dependencies: bc

# Get the gdbus output with colors as floats
zenity --info --title="Pickler" --text="Podes tocar cualquier lugar de la pantalla"
response=$(gdbus call --session --dest org.gnome.Shell.Screenshot --object-path /org/gnome/Shell/Screenshot --method org.gnome.Shell.Screenshot.PickColor)


# Clean up the gdbus output
colors=${response/"({'color': <("/""}
colors=${colors/")>},)"/""}

# Split colors to an array
IFS=',' read -ra colors <<< "$colors"

# Convert to 255-based RGB format (float)
red=$(echo "${colors[0]} * 255" | bc)
green=$(echo "${colors[1]} * 255" | bc)
blue=$(echo "${colors[2]} * 255" | bc)

# 255-based RGB format (integer)
red=${red%%.*}
green=${green%%.*}
blue=${blue%%.*}

result=$(
	printf 'HEX: #%02x%02x%02x\n' "$red" "$green" "$blue"
	printf "RGB: $red $green $blue"
)
zenity --info --title="Color elegido" --text="${result}"
