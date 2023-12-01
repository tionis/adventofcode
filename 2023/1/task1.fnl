(local re (require :re))

(local f (io.open (. arg 1)))
(var line (f:read "*line"))
(fn get_number [str]
  (local list [(re.match str "([a-z]*{[0-9]})*")])
  (.. (. list 1) (. list (length list))))
(var sum 0)
(while line
  (set sum (+ sum (get_number line)))
  (set line (f:read "*line")))
(print sum)
