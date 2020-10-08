choice=$(echo -e "Area\nRoot\nGif"| dmenu)

if [[ "$choice" == "Area" ]]
then
        maim -s | tee ~/pic/$(date +%s).png|xclip -selection clipboard -t image/png
fi

if [[ "$choice" == "Root" ]]
then
        maim | tee ~/pic/$(date +%s).png|xclip -selection clipboard -t image/png
fi

if [[ "$choice" == "Gif" ]]
then
        peek
fi
