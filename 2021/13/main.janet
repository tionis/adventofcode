(defn render [field]
  (string/join
    (seq [line :in field]
      (def b @"")
      (each cell line
        (buffer/push b (if cell "#" ".")))
      b)
    "\n"))

(defn field-or [one two]
  (def max-y (length one))
  (def max-x (length (first one)))
  (def field (array/new-filled max-y))
  (loop [i :range [0 (length field)]] (put field i (array/new-filled max-x false)))
  (loop [y :range [0 max-y]]
    (loop [x :range [0 max-x]]
      (if (or (get-in one [y x]) (get-in two [y x]))
        (put-in field [y x] true))))
  field)

(defn fold [field y-axis? n]
  (if y-axis?
    (do
      (def one (seq [i :range [0 n]] (slice (field i))))
      (def two (seq [i :range [(inc n) (length field)]] (slice (field i))))
      (field-or one (reverse two)))
    (do
      (def max-y (length field))
      (def max-x n)
      (def one (array/new-filled max-y))
      (loop [i :range [0 (length one)]] (put one i (array/new-filled max-x false)))
      (def two (array/new-filled max-y))
      (loop [i :range [0 (length two)]] (put two i (array/new-filled max-x false)))

      (loop [y :range [0 (length field)]]
        (loop [x :range [0 (length (field y))]]
          (def l (length (field y)))
          (cond
            (< x n) (put-in one [y x] (get-in field [y x]))
            (> x n) (put-in two [y (- (dec l) x)] (get-in field [y x])))))
      (field-or one two))))

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
  (def field (array/new-filled (inc max-y)))
  (loop [i :range [0 (length field)]] (put field i (array/new-filled (inc max-x) false)))
  (each coord coords
    (put-in field [(coord 1) (coord 0)] true))
  (def fields @[])
  (array/push fields field)
  (each f folds
    (array/push fields (fold (array/peek fields) (= (f 0) "y") (f 1))))
  (print "Print 1: " (do (var c 0) (each line (fields 1) (each cell line (if cell (+= c 1)))) c))
  (print "Part 2:")
  (print (render (array/peek fields))))
