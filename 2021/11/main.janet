(array/insert module/paths 0
  [(string (os/getenv "HOME") "/.config/fish/deps/janet/jpm_tree/lib/:all:.janet") :source]
  [(string (os/getenv "HOME") "/.config/fish/deps/janet/jpm_tree/lib/:all::native:") :native])
(import json)

(var grid @{})
(var x 0)
(each line (map (fn [s] (map scan-number (map string/from-bytes (string/bytes s)))) (string/split "\n" (string/trim (slurp "input"))))
  (var y 0)
  (each char line
    (put grid @[x y] char)
    (++ y))
  (++ x))

(defn neigbours [x y]
  (def res @[])
  (each e [[-1 -1] [-1 0] [-1 1] [0 -1] [0 1] [1 -1] [1 0] [1 1]] 
    (array/push res [(+ x (e 0)) (+ y (e 1))]))
  (filter (fn [x] (not (= nil (get grid @[(x 0) (x 1)])))) res))


(var count 0)
(loop [step :range [1 1000]] 
  (loop [k :keys grid] (put grid k (+ (get grid k) 1)))
  (var flashing @[])
  (loop [k :keys grid] (if (> (get grid k) 9) (array/push flashing k)))

  (while (not (= (length flashing) 0)) 
    (def f (array/pop flashing))
    (put grid f 0)
    (++ count)
    (each n (neigbours ;f)
      (put grid n (+ (grid n) 1))
      (if (> (grid n) 9)
          (array/push grid n))))

  (if (= step 100) (print count))
  (if (= (sum grid) 0) (do (print step)
                       (break))))
