(def data
  (slice
    (map (fn [s] (map scan-number (map string/from-bytes (string/bytes s))))
         (string/split "\n" (file/read (file/open "input") :all)))
     0
     -2))

(defn array_to_number [arr]
  (var d 0)
  (var i (- (length arr) 1))
  (each factor arr 
    (+= d (* factor (math/exp2 i)))
    (-- i))
  d)

(var ones (array/new-filled (length (data 0)) 0))

(each line data
  (loop [i :range [0 (length line)]]
    (if (= 1 (line i))
      (++ (ones i)))))

(def treshold (/ (length data) 2))
(def gamma-arr (mapcat (fn [x] (if (> x treshold) 1 0)) ones))
(def epsilon-arr (mapcat (fn [x] (case x 1 0 0 1)) gamma-arr))

(def gamma (array_to_number gamma-arr))
(def epsilon (array_to_number epsilon-arr))

(print "Part One")
(print (string "  Gamma: " gamma))
(print (string "  Epsilon: " epsilon))
(print (string "  Solution: " (* gamma epsilon)))
