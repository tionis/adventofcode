(var count 0)
(def data (mapcat scan-number (string/split "\n" (file/read (file/open "input") :all))))
(loop [i :range [0 (- (length data) 1)]]
    (if (> (get data (+ i 1)) (get data i))
      (set count (+ count 1))))
# correct for initial increase
(print (string "Part 1: " (- count 1)))

(var count 0)
(loop [i :range [0 (- (length data) 4)]]
    (def sum1 (+ (get data i) (get data (+ i 1)) (get data (+ i 2))))
    (def sum2 (+ (get data (+ i 1)) (get data (+ i 2)) (get data (+ i 3))))
    (if (> sum2 sum1)
      (set count (+ count 1))))
# correct for initial increase
(print (string "Part 2: " count))
