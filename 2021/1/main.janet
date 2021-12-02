(def data (mapcat scan-number (string/split "\n" (file/read (file/open "input") :all))))

(var count 0)
(loop [i :range [1 (length data)]]
    (if (< (data (- i 1)) (data i))
      (++ count)))
# correct for initial increase
(print (string "Part 1: " (- count 1)))

(var count 0)
(loop [i :range [1 (- (length data) 3)]]
    (if (< (sum (slice data (- i 1) (+ i 2))) 
           (sum (slice data i (+ i 3))))
      (++ count)))
(print (string "Part 2: " count))
