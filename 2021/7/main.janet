(def data (sorted (mapcat scan-number (string/split "," (string/trim (file/read (file/open "input") :all))))))
(def mid (data (/ (length data) 2)))
(print "Part One: " (sum (map (fn [x] (math/abs (- x mid))) data)))

(defn cost [x] (* x (/ (+ x 1) 2)))
(var out (sum (map (fn [x] (cost (math/abs (- x mid)))) data)))

(loop [i :range [(min-of data) (+ (max-of data) 1)]]
  (set out (min out (sum (map (fn [x] (cost (math/abs (- x i)))) data)))))

(print (string "Part Two: " out))
