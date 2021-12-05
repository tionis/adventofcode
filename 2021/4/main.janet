(def numbers (mapcat scan-number (string/split "," (get (string/split "\n" (file/read (file/open "input") :all)) 0))))
(def bingos (map (fn [x] (map (fn [x] (filter (fn [x] (not (= x ""))) x)) x)) (map (fn [x] (map (fn [x] (string/split " " x)) x)) (map (fn [x] (string/split "\n" x)) (slice (string/split "\n\n" (file/read (file/open "input") :all)) 1 -2)))))
