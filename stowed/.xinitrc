picom -b --unredir-if-possible --backend xr_glx_hybrid --vsync --use-damage --glx-no-stencil --legacy-backends &&
setxkbmap -option grp:caps_toggle -layout "us,ru" && 
xsetroot -solid "#292e39" &&
awesome
