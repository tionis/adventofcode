(local toolbox (require :toolbox))
(local json (require :json))
(local color (require :ansicolors))
(local input (toolbox.slurp (. arg 1)))
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
  (or
    (is_symbol (. grid (- x 1) (- y 1)))
    (is_symbol (. grid (- x 1) y))
    (is_symbol (. grid (- x 1) (+ y 1)))
    (is_symbol (. grid x (- y 1)))
    (is_symbol (. grid x (+ y 1)))
    (is_symbol (. grid (+ x 1) (- y 1)))
    (is_symbol (. grid (+ x 1) y))
    (is_symbol (. grid (+ x 1) (+ y 1)))))
(each [x line (ipairs grid)]
  (var touching false)
  (var number "")
  (each [y cell (ipairs line)]
    (if (. is_number cell)
      (do
        (if (check_touching grid x y)
            (set touching true))
        (set number (.. number cell)))
      (do
        (if (and (not= number "") touching)
            (table.insert numbers number))
        (set touching false)
        (set number "")
        ))
    (if touching
      (io.write (color (.. "%{red}" cell "%{reset} ")))
      (io.write cell " ")))
  (print))
(print (accumulate [sum 0 i n
         (ipairs
           (icollect [_ s (ipairs numbers)]
             (tonumber s)))]
         (+ sum n)))
