#!/usr/bin/env zsh

D_YEAR=`date +%Y`
D_MONTH=`date +%m`
D_DAY=`date +%d`
D_HOUR=`date +%H`
D_MINUTE=`date +%M`
D_SECOND=`date +%S`

mkdir -p "$HOME/screenshots/${D_YEAR}/${D_MONTH}/${D_DAY}"
scrot -s "$HOME/screenshots/${D_YEAR}/${D_MONTH}/${D_DAY}/${D_YEAR}${D_MONTH}${D_DAY}_${D_HOUR}${D_MINUTE}${D_SECOND}.png"
firefox "$HOME/screenshots/${D_YEAR}/${D_MONTH}/${D_DAY}/${D_YEAR}${D_MONTH}${D_DAY}_${D_HOUR}${D_MINUTE}${D_SECOND}.png"
