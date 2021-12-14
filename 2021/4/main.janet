(def numbers (mapcat scan-number (string/split "," (get (string/split "\n" (slurp "input")) 0))))
(var bingos (map (fn [x] (map (fn [y] (map (fn [z] (scan-number z)) y)) x)) (map (fn [x] (map (fn [x] (filter (fn [x] (not (= x ""))) x)) x)) (map (fn [x] (map (fn [x] (string/split " " x)) x)) (map (fn [x] (string/split "\n" x)) (slice (string/split "\n\n" (slurp "input")) 1 -2))))))

(defmacro replace_all_x_with_y_in_arr [x y arr]
  ())

(each num numbers
  (replace_all_x_with_y_in_arr num -1 bingos)
  (var m (map (fn [x] (map (fn [y] (map (fn [z] (= z -1)) y)) x)) bingos)))
