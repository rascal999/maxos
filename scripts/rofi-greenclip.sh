#!/usr/bin/env bash

ROFI_CMD="rofi"

$ROFI_CMD -modi "clipboard:/home/user/git/maxos/resources/greenclip print" -show clipboard -run-command '{cmd}'
