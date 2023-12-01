(def digit ~(+
  (/ (if "one" 1) 1)
  (/ (if "two" 1) 2)
  (/ (if "three" 1) 3)
  (/ (if "four" 1) 4)
  (/ (if "five" 1) 5)
  (/ (if "six" 1) 6)
  (/ (if "seven" 1) 7)
  (/ (if "eight" 1) 8)
  (/ (if "nine" 1) 9)
  (number :d)))

(defn main [_ file_path]
  (print
    (sum
      (peg/match
        ~{:main (any (* :line (+ "\n" -1)))
          :line (/ (* (any :step) :not_number)
                   ,(fn [& x] (scan-number (string (first x) (last x)))))
          :step (* :not_number :number)
          :number ,digit
          :not_number (any (* (not (+ :number (+ "\n" -1))) 1))}
        (slurp file_path)))))
