#!/usr/bin/env nu

pacman -Qii | grep -iE 'name[ ]+:|install date' | sed 's/.*: //' | tac | paste -d " " - - | parse "{DayName} {DayNum} {Month} {Year} {Time} {AMPM} {UTC} {Name}"
