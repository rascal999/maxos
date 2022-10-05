#!/usr/bin/env python

import sys

if len(sys.argv) != 3:
  print("./bwcalc <speed-in-Mb> <file-size-in-GB>")
  sys.exit(1)

file_size = int(sys.argv[2])
speed = int(sys.argv[1])

time = ((file_size * 1024) / (speed/8)) / 60 / 60

hours = int(time)
minutes = (time*60) % 60
seconds = (time*3600) % 60

print("Estimated transfer time: %dh %02dm %02ds" % (hours, minutes, seconds))
