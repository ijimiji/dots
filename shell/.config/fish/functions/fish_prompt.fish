function fish_prompt -d "Write out the prompt"
    printf '\n'
    printf '%s' \
    (set_color green) "[" \
    (set_color yellow) "$USER" \
    (set_color red) "@" \
    (set_color blue) "$hostname " \
    (set_color red) (prompt_pwd) \
    (set_color green) "] " \
    (set_color normal)
end
