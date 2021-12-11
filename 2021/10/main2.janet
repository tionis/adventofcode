(use judge)

(def input (map (fn [s] (map string/from-bytes (string/bytes s))) (string/split "\n" (string/trim (slurp "input")))))

(var scores @[])
(def points @{"(" 1
               "[" 2
               "{" 3
               "<" 4})
(def opening_by_closing @{")" "("
                          "}" "{"
                          "]" "["
                          ">" "<"})
(defn x-in-y? [x y] 
  (var found false)
  (each e y 
    (if (= e x) (do (set found true)
                    (break))))
  found)

#(defn x-in-y? [x y] (> (index-of x y -1) 0))

(each line input
  (var stack @[])
  (each char line
    (if (x-in-y? char (values opening_by_closing))
      (array/push stack char)
      (if (or (= (length stack) 0)
              (not (= (array/pop stack) (opening_by_closing char))))
        (do
          (set stack @[])
          (break))))
    (if (> (length stack) 0)
        (do (var subscore 0)
            (each stack_char (reverse stack)
              (set subscore (+ (* subscore 5) (points stack_char))))
            (array/push scores subscore)))))

(test "solution 2" (expect ((sorted scores) (math/ceil (/ (length scores) 2))) 3049320156))
