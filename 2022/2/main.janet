#!/bin/env janet
(defn score [a b] (+ 1 b (* (% (- b a -4) 3) 3)))
(defn conv [a] (a 0))

(defn main [_ input-file]
	(def results (peg/match ~{
		:l (cmt (<- :a) ,conv)
		:1 (cmt (* :l (constant 65)) ,-)
		:2 (cmt (* :l (constant 88)) ,-)
		:line (* (cmt (* :1 " " :2) ,tuple) "\n")
		:main (some :line)
	} (slurp input-file)))
	(printf "Part 1: %P" (sum (map |(score ;$) results)))
	(printf "Part 2: %P" (sum (map |(score ($ 0) (% (+ 2 ;$) 3)) results))))
