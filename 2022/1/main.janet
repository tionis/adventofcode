#!/bin/env janet
(def calories-grammar (peg/compile ~{
	:line (* (number :d+) "\n")
	:calorie (* (cmt (some :line) ,+) (? "\n"))
	:main (some :calorie)}))

(defn main [myself input-file]
  (def calories (sorted (peg/match calories-grammar (slurp input-file)) >))
	(printf "Part 1: %P" (calories 0))
	(printf "Part 2: %P" (sum (slice calories 0 3))))
