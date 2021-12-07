(def input (map scan-number (string/split "," (string/trim (file/read (file/open "input") :all)))))

(defn fish_count_after_x_days [starting_fish_ages days]
  # Save count of fish by age
  (var fish_by_age (array/new-filled 9 0))
  (each fish starting_fish_ages (++ (fish_by_age fish)))
  (loop [i :range [0 days]]
    (+= (fish_by_age (% (+ i 7) 9)) (fish_by_age (% i 9))))
  (sum fish_by_age))


(print (string "Amount of Fish after  80 days: " (fish_count_after_x_days input 80)))
(print (string "Amount of Fish after 256 days: " (fish_count_after_x_days input 256)))
