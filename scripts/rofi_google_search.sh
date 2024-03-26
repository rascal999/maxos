#!/usr/bin/env bash

echo "" | rofi -dmenu -p "Google search" -theme '/home/user/git/maxos-next/resources/rofi/Arc Dark' | xargs -I{} xdg-open https://www.google.com/search?q={}
