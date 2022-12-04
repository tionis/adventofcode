#!/bin/env -S janet -w 3 -e 3
(def patt (peg/compile ~{
	:num (number :d+)
	:range (cmt (* :num "-" :num) ,tuple)
	:line (* (cmt (* :range "," :range) ,tuple) (? "\n"))
	:main (some :line)}))

(defn overlap [input-range operator-1 operator-2 i]
 	(def [x y] ;input-range)
 	(var res 0)
 	(if (operator-1 (x 0) (y 0)) (if (operator-2 (x i) (y 1)) (set res 1)))
 	(if (operator-1 (y 0) (x 0)) (if (operator-2 (y i) (x 1)) (set res 1)))
 	res)


(defn main [_ input-file]
	(def list (peg/match patt (slurp input-file)))
 	(printf "Part 1: %P" (+ ;(map |(overlap $ <= >= 1) list)))
 	(printf "Part 2: %P" (+ ;(map |(overlap $ >= <= 0) list))))
