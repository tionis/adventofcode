(def input 
  (map (fn [x2] (mapcat (fn [x3] (string/split "," x3)) 
                        x2)) 
       (map (fn [x1] (string/split " -> " x1)) 
            (string/split "\n" (string/trim (file/read (file/open "input") :all))))))
(var grid (array/new-filled 2 (array/new-filled 1000 (array/new-filled 1000 0))))

(defn sign [x]
  (cond
    (> x 0)  1
    (= x 0)  0
    (< x 0) -1))

(defmacro ++in [variable arr] ~(put-in ,variable ,arr (+ (get-in ,variable ,arr) 1)))

(defn to-number [x] 
  (case (type x)
    :number x
    :string (scan-number x)
    (error "Not implemented")))

(loop [line :in input] 
  (var x (scan-number (line 0)))
  (var y (scan-number (line 1)))
  (var X (scan-number (line 2)))
  (var Y (scan-number (line 3)))
  (def dx (sign (- X x)))
  (def dy (sign (- Y y)))
  (while (and (not (= x (+ X dx))) 
              (not (= y (+ Y dy))))
    (++in grid [(* (math/abs dx) (math/abs dy)) x y])
    (+= x dx)
    (+= y dy)))

(print 
  (string "Part 1: "
          (sum (map (fn [x] 
                      (sum (map (fn [y] 
                                  (if (> y 1) 1 0)) 
                            x)))
               (grid 0)))))

(print 
  (string "Part 2: " 
          (sum (map (fn [x1] 
                      (sum (map (fn [x2] 
                                  (sum (map (fn [x3] 
                                              (if (> x3 1) 1 0)) 
                                        x2)))
                            x1)))
                grid))))
