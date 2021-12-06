(def input (map scan-number (string/split "," (string/trim (file/read (file/open "input") :all)))))
