#!/bin/env janet
(defn main [_ file]
  (def amounts @{:red 12
                 :green 13
                 :blue 14})
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
  (def powers @[])
  (eachk id games
    (def max-mins @{:red 0 :green 0 :blue 0})
    (each round (games id)
      (eachk color round
        (put max-mins color (max (round color) (max-mins color)))))
    (array/push powers (* ;(values max-mins))))
  (print (sum powers)))
