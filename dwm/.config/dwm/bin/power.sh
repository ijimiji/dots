choice=$(echo -e "Suspend\nPoweroff\nReboot"| dmenu -m 0 -i -c -l 5 -fn 'iosevka-17:normal' -nb '#434c5e' -nf '#d8dee9' -sb '#4c566a' -sf '#88c0d0')

if [[ "$choice" == "Poweroff" ]]
then
        poweroff
fi

if [[ "$choice" == "Suspend" ]]
then
        systemctl suspend
fi

if [[ "$choice" == "Reboot" ]]
then
        reboot
fi
