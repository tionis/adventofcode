#!/bin/env janet
(defn main [_ file]
  (def amounts @{:red 12
                 :green 13
                 :blue 14})
  (def correct_games @[])
  (def games
    (table
      ;(peg/match
        ~{:main (some :game)
          :game (* :id :rounds "\n")
          :id (* "Game " (number :d+) ": ")
          :rounds (group (some :round))
          :round (cmt (* (some (* :color (any ", ")))
                         (any "; ")) ,table)
          :color (+ (* (constant :red) (number :d+) " red")
                    (* (constant :green) (number :d+) " green")
                    (* (constant :blue) (number :d+) " blue"))
          }
      (slurp file))))
  (eachk id games
    (var failed false)
    (each round (games id)
      (eachk color round
        (if (> (round color) (amounts color)) (set failed true))))
    (if (not failed) (array/push correct_games id)))
  (print (sum correct_games)))
