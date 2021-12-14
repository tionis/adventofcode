(def grid (map (fn [s] (map scan-number (map string/from-bytes (string/bytes s)))) (string/split "\n" (string/trim (slurp "input")))))

(var s 0)

(loop [x :range [0 (length grid)]]
  (loop [y :range [0 (length grid)]]
    (cond
      (and (> x 0)
           (>= (get-in grid [x y]) (get-in grid [(- x 1) y]))) ()
      (and (< x (- (length grid) 1))
           (>= (get-in grid [x y]) (get-in grid [(+ x 1) y]))) ()
      (and (> y 0)
           (>= (get-in grid [x y]) (get-in grid [x (- y 1)]))) ()
      (and (< y (- (length (grid 0)) 1))
           (>= (get-in grid [x y]) (get-in grid [x (+ y 1)]))) ()
      (+= s (+ (get-in grid [x y]) 1)))))

(print s)
