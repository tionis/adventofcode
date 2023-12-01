(def mapping {"one" 1 "two" 2 "three" 3 "four" 4 "five" 5 "six" 6 "seven" 7 "eight" 8 "nine" 9 "zero" 0 "0" 0 "1" 1 "2" 2 "3" 3 "4" 4 "5" 5 "6" 6 "7" 7 "8" 8 "9" 9})

(defn main [_ file_path]
  (def results @[])
  (each line (string/split "\n" (string/trimr (slurp file_path)))
    #(print line)
    (def start
      (->> (keys mapping)
           (map |{:name $0 :index (string/find $0 line)})
           (filter |($0 :index))
           (sort-by |($0 :index))
           (map |(mapping ($0 :name)))
           (first)))
    (def end
      (->> (keys mapping)
           (map |(reverse $0))
           (map |{:name $0 :index (string/find $0 (reverse line))})
           (filter |($0 :index))
           (sort-by |($0 :index))
           (map |(mapping (string (reverse ($0 :name)))))
           (first)))
    #(printf "%d%d" start end)
    (array/push results (scan-number (string/format "%d%d" start end))))
  (print (sum results)))
