function knit
    R -e "rmarkdown::render('$argv')"
end
