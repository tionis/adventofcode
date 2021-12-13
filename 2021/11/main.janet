(var grid @{})
(var x 0)
(each line (map (fn [s] (map scan-number (map string/from-bytes (string/bytes s)))) (string/split "\n" (string/trim (slurp "input"))))
  (var y 0)
  (each char line
    (put grid [x y] char)
    (++ y))
  (++ x))

(defn neigbours [x y]
  (def res @[])
  (each e [[-1 -1] [-1 0] [-1 1] [0 -1] [0 1] [1 -1] [1 0] [1 1]]
    (array/push res [(+ x (e 0)) (+ y (e 1))]))
  (filter (fn [x] (not (= nil (get grid [(x 0) (x 1)])))) res))

(defn print-grid []
  (loop [x :range [0 10]]
    (loop [y :range [0 10]]
      (prin (string (case (grid [x y])
                      9 "\e[31m9\e[97m"
                      8 "\e[32m8\e[97m"
                      7 7
                      6 6
                      5 5
                      4 4
                      3 "\e[90m3\e[97m"
                      2 "\e[90m2\e[97m"
                      1 "\e[90m1\e[97m"
                      0 "\e[90m0\e[97m"
                      x x)
                    " ")))
    (print))
  (print))

(var count 0)
(loop [step :range [1 1000]]
  (loop [k :keys grid] (put grid k (+ (get grid k) 1)))
  (var flashing @[])
  (loop [k :keys grid] (if (> (get grid k) 9) (array/push flashing k)))

  (while (> (length flashing) 0)
    (def f (array/pop flashing))
    (put grid f 0)
    (++ count)
    (each n (neigbours ;f)
      (put grid n (+ (grid n) 1))
      (if (> (grid n) 9)
        (array/push flashing n))))

  (if (= step 100) (print count))
  (if (= (sum grid) 0) (do (print step)
                         (break))))
