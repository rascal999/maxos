#!/usr/bin/env bash

NOW=`date +"%Y%m%d_%H%M%S"`

copyq separator "\n###\n" read 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 > /home/user/tmp_today/${NOW}_clipboard.txt

firefox /home/user/tmp_today/${NOW}_clipboard.txt
sleep 0.2
rm /home/user/tmp_today/${NOW}_clipboard.txt
