(def input (map (fn [s] (map string/from-bytes (string/bytes s))) (string/split "\n" (string/trim (slurp "input")))))

(var score 0)
(def scores @{")" 3
              "]" 57
              "}" 1197
              ">" 25137})
(def opening_by_closing @{")" "("
                          "}" "{"
                          "]" "["
                          ">" "<"})

(defn is_opening [char] 
  (case char
    "(" true
    "{" true
    "[" true
    "<" true
    false))

(each line input 
  (var stack @())
  (each char line 
    (if (is_opening char)
        (array/push stack char)
        (if (or (= (length stack) 0)
                (not (= (array/pop stack) (opening_by_closing char))))
            (do 
                (+= score (scores char))
                (break))))))

(print score)
