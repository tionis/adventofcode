#!/bin/env janet
(defn main [myself & args]
  (def input (map scan-number (string/split "\n" (string/trimr (slurp "input")))))
  (print "Part 1: " (sum (map (fn [x] (- (math/floor (/ x 3)) 2)) input)))
  (print "Part 2: " (sum (map (fn [x] (- (math/floor (/ x 3)) 2)) input))))
