picom -b --unredir-if-possible --backend xr_glx_hybrid --vsync --use-damage --glx-no-stencil --legacy-backends &&
setxkbmap -option grp:caps_toggle -layout "by(latin),ru" && 
xsetroot -solid "#292e39" &&
awesome
