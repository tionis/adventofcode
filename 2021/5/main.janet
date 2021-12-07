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

(defmacro ++in [variable arr] ~(,put-in ,variable ,arr (+ (,get-in ,variable ,arr) 1)))

(defn to-number [x] 
  (case (type x)
    :number x
    :string (scan-number x)
    (error "Not implemented")))

(loop [(x-string, y-string, X-string, Y-string) :in input] 
  (var x (to-number x-string))
  (var y (to-number y-string))
  (var X (to-number X-string))
  (var Y (to-number Y-string))
  (print x)
  (print y)
  (print X)
  (print Y)
  (def dx (- X x))
  (def dy (- Y y))
  (while (not (and (= x (+ X dx))
                   (= y (+ Y dy))))
    (++in grid [(* dx dy) x y])
    (+= x dx)
    (+= y dy)))

