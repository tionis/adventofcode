(def grid (map (fn [s] (map scan-number (map string/from-bytes (string/bytes s)))) (string/split "\n" (string/trim (slurp "input")))))
(def rows (length grid))
(def cols (length (grid 0)))


(defn all_in_x_greater_y? [arr y] 
  (var ret true)
  (each x arr
    (if (<= x y) (set ret false)))
  ret)

(var out 0)
(loop [r :range [0 rows]] 
  (loop [c :range [0 cols]]
    (var q (get-in grid [r c]))
    (var adj @())
    (loop [@(dr dc) :in @(@(-1 0) @(1 0) @(0 1) @(0 -1))]
      (def nr (+ r dr))
      (def nc (+ c dc))
      (if (and (and (<= 0 nr) (< nr rows))
               (and (<= 0 nc) (< nc cols)))
        (array/push adj (get-in grid [nr nc]))))
    (if (all_in_x_greater_y? adj q)
      (+= out (+ 1 q)))))

(print out)
