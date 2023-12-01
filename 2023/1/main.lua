local lpeg = require("lpeg")
local re = require("re")

local f = io.open ("1.in")
local val = f:read("*line")

-- Define a pattern to match one or more digits
local digits = lpeg.R("09")^1

-- Define a pattern to match one or more numbers in a string
-- Define a pattern to match one or more numbers in a string
local numbers = lpeg.Cf(digits^1, function(acc, val)
    if not acc then
        acc = val
    else
        acc = acc .. val
    end
    return acc
end)

while val do
  print(lpeg.match(numbers, val))
  val = f:read "*line"
end

-- if concatenatedNumber then
--     local result = tonumber(concatenatedNumber)
--     print("Concatenated number:", result)
-- else
--     print("No numbers found in the string.")
-- end
