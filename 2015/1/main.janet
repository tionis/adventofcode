#!/bin/env janet
(print "Part 1: " (sum (map |(case $0 40 1 41 -1) (string/trimr (slurp "input")))))
(print "Part 2: "
       (label basement-index
              (var i 0)
              (var h 0)
              (loop [j :in (map |(case $0 40 1 41 -1) (string/trimr (slurp "input")))]
                (+= i 1)
                (+= h j)
                (if (< h 0) (return basement-index i)))))
