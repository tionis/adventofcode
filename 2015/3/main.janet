#!/bin/env janet
(def direction-map @{94 :up
                     62 :right
                     118 :down
                     60 :left})

(defn walk [line]
  (def path @[[0 0]])
  (each char line
    (def current (array/peek path))
    (case (direction-map char)
      :up (array/push path [(current 0) (inc (current 1))])
      :down (array/push path [(current 0) (dec (current 1))])
      :right (array/push path [(inc (current 0)) (current 1)])
      :left (array/push path [(dec (current 0)) (current 1)])))
  path)


(defn main [_ input]
  (def lines (string/split "\n" (string/trimr (slurp input))))
  (print "Part 1: " (length (distinct (walk (first lines)))))
  (def robot-line @"")
  (def santa-line @"")
  (var santa-turn true)
  (each char (first lines)
    (if santa-turn
      (buffer/push santa-line char)
      (buffer/push robot-line char))
    (set santa-turn (not santa-turn)))
  (def santa-path (walk santa-line))
  (def robot-path (walk robot-line))
  (print "Part 2: " (length (distinct (array/concat santa-path robot-path)))))
