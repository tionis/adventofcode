(def data (string/split "\n" (file/read (file/open "input") :all)))

(var horizontal 0)
(var depth 0)
(each line data (do
  (def split_line (string/split " " line))
  (if (= 2 (length split_line))
    (do 
      (def number (scan-number (get split_line 1)))
      (case (get split_line 0)
        "forward" (+= horizontal number)
        "up" (-= depth number)
        "down" (+= depth number))))))

(print "Part One")
(print (string "  Horizontal: " horizontal))
(print (string "  Depth:      " depth))
(print (string "  Solution:   " (* horizontal depth)))

(var horizontal 0)
(var depth 0)
(var aim 0)
(each line data (do
  (def split_line (string/split " " line))
  (if (= 2 (length split_line))
    (do 
      (def number (scan-number (get split_line 1)))
      (case (get split_line 0)
        "forward" (do (+= horizontal number) (+= depth (* aim number)))
        "up" (-= aim number)
        "down" (+= aim number))))))

(print "Part Two")
(print (string "  Horizontal: " horizontal))
(print (string "  Depth:      " depth))
(print (string "  Solution:   " (* horizontal depth)))
