#!/bin/env janet
(defn main [_ input-file]
  (def input (slurp input-file))
  (def positions @{4 0 14 0}) # track positions of distinct character sequences
  (each len [4 14] # lenghth of distinct character sequence
	  (loop [i :range [0 (- (length input) len)]] # iterate over input
		  (if (and (= (positions len) 0)
               (= len (length (keys (frequencies (slice input i (+ i len)))))))
          (set (positions len) (+ len i)))))
  (printf "Part 1: %P" (positions 4))
  (printf "Part 2: %P" (positions 14)))
