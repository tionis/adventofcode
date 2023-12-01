(def mapping {"one" 1 "two" 2 "three" 3 "four" 4 "five" 5 "six" 6 "seven" 7 "eight" 8 "nine" 9 "zero" 0})
(defn to_number [x] (get mapping x x))

(defn main [_ file_path]
  (def results
      (peg/match # TODO cover cases like "eigthree" -> 83 and "sevenine" -> 79
        ~{:main (any (* :line (+ "\n" -1)))
          :line (replace (* (any :step) :not_number)
                         ,(fn [& x]
                            (scan-number
                              (string (to_number (first x))
                                      (to_number (last x))))))
          :step (* :not_number :number)
          :number (capture (+ ,;(keys mapping) :d))
          :not_number (any (* (not (+ :number (+ "\n" -1))) 1))}
        (slurp file_path)))
  (printf "%M" results)
  (print (sum results)))
