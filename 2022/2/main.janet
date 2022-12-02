#!/bin/env janet
(defn game-result [a b]
  (get-in
    {:rock {:rock :draw :paper :b-wins :scissors :a-wins}
     :paper {:rock :a-wins :paper :draw :scissors :b-wins}
     :scissors {:rock :b-wins :paper :a-wins :scissors :draw}}
    [a b]))

(def extra-score
  {:rock 1
   :paper 2
   :scissors 3})

(defn calculate-score [a b]
  (def result (game-result a b))
  (+ (extra-score b)
     (case result
       :b-wins 6
       :draw 3
       :a-wins 0)))

(defn main [_ input-file]
  (def lines (string/split "\n" (string/trimr (slurp input-file))))
  (def strategy (map |[(case ($0 0)
                         "A" :rock
                         "B" :paper
                         "C" :scissors)
                       (case ($0 1)
                         "X" :rock
                         "Y" :paper
                         "Z" :scissors)] (map |(string/split " " $0) lines)))
  (def lines (string/split "\n" (string/trimr (slurp input-file))))
  (print "Part 1: " (sum (map |(calculate-score ($0 0) ($0 1)) strategy)))
  (def strategy-2 (map |[(case ($0 0)
                         "A" :rock
                         "B" :paper
                         "C" :scissors)
                       (get-in
                         {"X" {"A" :scissors "B" :rock "C" :paper}  # lose
                          "Y" {"A" :rock "B" :paper "C" :scissors}  # draw
                          "Z" {"A" :paper "B" :scissors "C" :rock}} # win
                         [($0 1) ($0 0)])] (map |(string/split " " $0) lines)))
  (print "Part 2: " (sum (map |(calculate-score ($0 0) ($0 1)) strategy-2))))
