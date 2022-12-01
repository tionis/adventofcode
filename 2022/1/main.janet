#!/bin/env janet
(defn main [myself file]
  (def lines (map |(string/split "\n" $0) (string/split "\n\n" (string/trimr (slurp file)))))
  (def elf-calories (map |(sum (map scan-number $0)) lines))
  (printf "Part 1: %P" (max-of elf-calories))
  (printf "Part 2: %P" (sum (slice (sort elf-calories) -4 -1))))
