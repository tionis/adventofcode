#!/bin/env janet
(defn main [_ input]
  (def lines (map (fn [line] (map (fn [coord] (scan-number coord)) (string/split "x" line))) (string/split "\n" (string/trimr (slurp input)))))
  (var wrapping-feet 0)
  (each line lines
    (def sides [(* (line 0) (line 1))
                (* (line 1) (line 2))
                (* (line 2) (line 0))])
    (+= wrapping-feet (+ ;sides ;sides (min-of sides))))
  (print "Part 1: " wrapping-feet)
  (var ribbon 0)
  (each line lines
    (+= ribbon (* ;line))
    (+= ribbon (* 2 (sum (slice (sorted line) 0 2)))))
  (print "Part 2: " ribbon))
