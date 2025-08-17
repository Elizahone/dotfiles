wal -q -i ~/Pictures/wallpaper

# ----------------------------------------------------- 
# Load current pywal color scheme
# ----------------------------------------------------- 
source "$HOME/.cache/wal/colors.sh"

# ----------------------------------------------------- 
# Copy selected wallpaper into .cache folder
# ----------------------------------------------------- 
# cp $wallpaper ~/.cache/current_wallpaper.jpg


# ----------------------------------------------------- 
# get wallpaper iamge name
# ----------------------------------------------------- 
newwall=$(echo $wallpaper | sed "s|$HOME/Pictures/wallpaper/||g")

# ----------------------------------------------------- 
# Set the new wallpaper
# ----------------------------------------------------- 
swww img $wallpaper --transition-step 20 --transition-fps=20
sleep 1

# ----------------------------------------------------- 
# Send notification
# ----------------------------------------------------- 

echo "DONE!"

