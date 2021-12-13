  (defn is-x-in-arr? (x arr) 
  (var found false)
  (each element arr 
    (if (= x element) (set found true)))
  found)

(def neighbours @{}) 
(each line (map |(string/split "-" $0) (string/split "\n" (string/trim (slurp "input"))))
  (if (= (get neighbours (line 0)) nil)
      (put neighbours (line 0) @[(line 1)])
      (array/push (get neighbours (line 0)) (line 1)))
  (if (= (get neighbours (line 1)) nil)
      (put neighbours (line 1) @[(line 0)])
      (array/push (get neighbours (line 1)) (line 0))))

(defn is_lower_case [str] 
  (= str (string/ascii-lower str)))

(defn search [part seen cave]
  (var this_part part)
  (if (= cave "end")
      1
      (do (if (is-x-in-arr? cave seen)
              (if (= cave "start")
                  (break 0)
                  (if (is_lower_case cave)
                      (if (= this_part 1)
                          (break 0)
                          (set this_part 1)))))
          (var res @[])
          (each n (neighbours cave)
              (array/push res (search this_part (array/push seen cave) n)))
          (sum res))))

(print (search 1 @[] "start"))
(print (search 2 @[] "start"))
