(defn render [field])

(defn main [_ file]
  (def lines (string/split "\n" (string/trimr (slurp file))))
  (def coords @[])
  (def folds @[])
  (var counting-coords true)
  (each line lines
    (if counting-coords
      (if (= line "")
        (set counting-coords false)
        (array/push coords (map scan-number (peg/match ~(* (capture (some :d)) "," (capture (some :d))) line))))
      (array/push folds (let [content (peg/match ~(* "fold along " (capture (+ "x" "y")) "=" (capture (some :d))) line)]
                          [(content 0) (scan-number (content 1))]))))
  (def max-x (max-of (map |($0 0) coords)))
  (def max-y (max-of (map |($0 1) coords)))
  (pp {:max-x max-x :max-y max-y})
  (def field)
  (pp coords)
  (pp folds))
