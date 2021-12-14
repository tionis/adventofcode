(defmacro table/++ [tab key] ~(if (= (get ,tab ,key) nil) (put ,tab ,key 1) (put ,tab ,key (+ (get ,tab ,key) 1))))
(defmacro table/+= [tab key amount] ~(if (= (get ,tab ,key) nil) (put ,tab ,key ,amount) (put ,tab ,key (+ (get ,tab ,key) ,amount))))
(defmacro table/-= [tab key amount] ~(if (= (get ,tab ,key) nil) (put ,tab ,key (- 0,amount)) (put ,tab ,key (- (get ,tab ,key) ,amount))))

(defn string_to_array [input] (map (fn [x] (string/from-bytes x)) input))

(defn chars_by_frequency [input] 
  (var res @{})
  (each char (string_to_array input) 
    (table/++ res char))
  res)

(defn combis_by_frequency 
  "Returns a table with all two letter combinations of consecutive characters and their frequencies"
  [input] 
  (var res @{})
  (def data (string_to_array input))
  (var previous_char (data 0))
  (loop [i :range [1 (length data)]]
    (table/++ res (string previous_char (data i)))
    (set previous_char (data i)))
  res)


(def lines (string/split "\n" (string/trim (slurp "input"))))
(def polymer_template (lines 0))
(def pair_insertion_rules @{}) 
(each line (map (fn [x] (string/split " -> " x)) (slice lines 2 -1))
  (put pair_insertion_rules (line 0) (line 1)))
(def combis (combis_by_frequency polymer_template))
(def char_frequencies (chars_by_frequency polymer_template))

(loop [i :range [0 40]] 
  (loop [k :keys combis] 
    (def @[a b] (string_to_array k))
    (def c (combis k))
    (def x (pair_insertion_rules k))
    (table/-= combis (string a b) c) 
    (table/+= combis (string a x) c)
    (table/+= combis (string x b)c)
    (table/+= char_frequencies x c)))

(print (- (max ;(values char_frequencies)) (min ;(values char_frequencies))))
