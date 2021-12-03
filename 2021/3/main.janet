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
(def gamma-arr (mapcat (fn [x] (if (>= x treshold) 1 0)) ones))
(def epsilon-arr (mapcat (fn [x] (case x 1 0 0 1)) gamma-arr))

(def gamma (array_to_number gamma-arr))
(def epsilon (array_to_number epsilon-arr))

(print "Part One")
(print (string "  Gamma: " gamma))
(print (string "  Epsilon: " epsilon))
(print (string "  Solution: " (* gamma epsilon)))

(var possible_oxygen_ratings data)
(loop [i :range [0 (length (data 0))] :until (= 1 (length possible_oxygen_ratings))] 
  (var ones_at_i 0)
  (each element possible_oxygen_ratings (if (= (element i) 1) (++ ones_at_i)))
  (def searched_bit_value (if (>= ones_at_i (/ (length possible_oxygen_ratings) 2)) 1 0))
  (set possible_oxygen_ratings (filter (fn [x] (= (x i) searched_bit_value)) possible_oxygen_ratings)))
(def oxygen_generator_rating (array_to_number (possible_oxygen_ratings 0)))

(var possible_scrubber_ratings data)
(loop [i :range [0 (length (data 0))] :until (= 1 (length possible_scrubber_ratings))] 
  (var ones_at_i 0)
  (each element possible_scrubber_ratings (if (= (element i) 1) (++ ones_at_i)))
  (def searched_bit_value (if (>= ones_at_i (/ (length possible_scrubber_ratings) 2)) 0 1))
  (set possible_scrubber_ratings (filter (fn [x] (= (x i) searched_bit_value)) possible_scrubber_ratings)))
(def co2_scrubber_rating (array_to_number (possible_scrubber_ratings 0)))

(print "Part Two")
(print (string "  Oxygen Generator Rating: " oxygen_generator_rating))
(print (string "  CO2 Scubber Rating: " co2_scrubber_rating))
(print (string "  Solution: " (* oxygen_generator_rating co2_scrubber_rating)))
