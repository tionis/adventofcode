(def lines (string/split "\n" (string/trim (slurp "input"))))

(var solution-one 0)

(defn is-x-in-arr? (x arr) 
  (var found false)
  (each element arr 
    (if (= x element) (set found true)))
  found)

(each line lines 
  (def split-line (string/split " | " line))
  (def b (string/split " " (split-line 1)))
  (each x b 
    (if (is-x-in-arr? (length x) @(2 3 4 7) ) (++ solution-one))))

(print (string "Part One: " solution-one))
