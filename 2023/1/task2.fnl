(local re (require :re))

;; (local pattern (re.compile "([a-z]*{[0-9]})*"))
(local pattern (re.compile "
    start <- (()*{(digit_word / digit / word)})+
    digit_word <- digit word
    digit <- [1-9]
    word <- 'one' / 'two' / 'three' / 'four' / 'five' / 'six' / 'seven' / 'eight' / 'nine'
"))
(local f (io.open (. arg 1)))
(var line (f:read "*line"))
(local conversion_table (setmetatable {"one" 1 "two" 2 "three" 3 "four" 4 "five" 5 "six" 6 "seven" 7 "eight" 8 "nine" 9 "zero" 0} {:__index (fn [_ y] y)}))
(fn to_number [in] (. conversion_table in))
(fn get_number [str]
  (local list [(pattern:match str)])
  (var first (. list 1))
  (var last (. list (length list)))
  (print first)
  (print last)
  (tonumber (.. (to_number first) (to_number last))))
(var sum 0)
(while line
  (set sum (+ sum (get_number line)))
  (set line (f:read "*line")))
(print sum)
