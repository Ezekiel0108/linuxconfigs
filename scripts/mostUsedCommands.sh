#!/bin/nu

history | each { | row | $row.command | split row " " | get 0 } | histogram | sort-by count -r | first 10
