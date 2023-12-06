(local toolbox (require :toolbox))
(local json (require :json))
(local color (require :ansicolors))
(local inspect (require :inspect))
(local input (toolbox.slurp (. arg 1)))
(fn keys [tab]
  (local keyset {})
  (var n 0)
  (each [k v (pairs tab)]
    (set n (+ n 1))
    (tset keyset n k))
  keyset)
(local grid {})
(local is_number {"0" true "1" true "2" true "3" true "4" true "5" true "6" true "7" true "8" true "9" true})
(local row-length (length ((input:gmatch "[^\n]+"))))
(local empty-row [])
(for [_ 1 (+ row-length 2)]
  (table.insert empty-row "."))
(table.insert grid empty-row)
(each [line (input:gmatch "[^\n]+")]
  (local line_arr {})
  (table.insert line_arr ".")
  (each [char (line:gmatch ".")]
    (table.insert line_arr char))
  (table.insert line_arr ".")
  (table.insert grid line_arr))
(table.insert grid empty-row)
(fn is_symbol [sym]
  (and (not (. is_number sym))
       (not= sym ".")))
(local numbers [])
(fn check_touching [grid x y]
  (local out [])
  (each [index coords (ipairs [[(- x 1) (- y 1)]
                        [(- x 1) y]
                        [(- x 1) (+ y 1)]
                        [x (- y 1)]
                        [x (+ y 1)]
                        [(+ x 1) (- y 1)]
                        [(+ x 1) y]
                        [(+ x 1) (+ y 1)]])]
    (if (is_symbol (. grid (. coords 1) (. coords 2)))
        (table.insert out coords)))
  (if (= (length out) 0)
      false
      out))
(local touchenings [])
(each [x line (ipairs grid)]
  (var touching_coords [])
  (var number "")
  (each [y cell (ipairs line)]
    (if (. is_number cell)
      (do
        (local they_touching? (check_touching grid x y))
        (if they_touching?
          (each [_ coords (ipairs they_touching?)]
            (tset touching_coords coords true)))
        (set number (.. number cell)))
      (do
        (if (and (not= number "")
                 (not= (next touching_coords) nil))
          (each [coord _ (pairs touching_coords)]
            (local key (.. (. coord 1) "-" (. coord 2)))
            (if (= (. touchenings key) nil) (tset touchenings key {}))
            (tset touchenings key number true)))
        (set touching_coords [])
        (set number "")
        ))))
    ;;(if (> (length touching_coords) 0)
    ;;  (io.write (color (.. "%{red}" cell "%{reset} ")))
    ;;  (io.write cell " ")))
  ;;(print))

(var result 0)
(each [_ numbers (pairs touchenings)]
  (var factor 1)
  (local numbers (keys numbers))
  (when (> (length numbers) 1)
    (each [_ number (ipairs numbers)]
      (set factor (* factor number)))
    (set result (+ result factor))))

(print result)
