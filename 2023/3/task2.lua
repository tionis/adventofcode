local toolbox = require("toolbox")
local json = require("json")
local color = require("ansicolors")
local input = toolbox.slurp(arg[1])
local grid = {}
local is_number = {["0"] = true, ["1"] = true, ["2"] = true, ["3"] = true, ["4"] = true, ["5"] = true, ["6"] = true, ["7"] = true, ["8"] = true, ["9"] = true}
local row_length = #input:gmatch("[^\n]+")()
local empty_row = {}
for _ = 1, (row_length + 2) do
  table.insert(empty_row, ".")
end
table.insert(grid, empty_row)
for line in input:gmatch("[^\n]+") do
  local line_arr = {}
  table.insert(line_arr, ".")
  for char in line:gmatch(".") do
    table.insert(line_arr, char)
  end
  table.insert(line_arr, ".")
  table.insert(grid, line_arr)
end
table.insert(grid, empty_row)
local function is_symbol(sym)
  return (not is_number[sym] and (sym ~= "."))
end
local numbers = {}
local function check_touching(grid0, x, y)
  local out = {}
  for index, coords in ipairs({{(x - 1), (y - 1)}, {(x - 1), y}, {(x - 1), (y + 1)}, {x, (y - 1)}, {x, (y + 1)}, {(x + 1), (y - 1)}, {(x + 1), y}, {(x + 1), (y + 1)}}) do
    if is_symbol(grid0[coords[1]][coords[2]]) then
      table.insert(out, coords)
    else
    end
  end
  if (#out == 0) then
    return false
  else
    return out
  end
end
local touchenings = {}
for x, line in ipairs(grid) do
  local touching_coords = {}
  local number = ""
  for y, cell in ipairs(line) do
    if is_number[cell] then
      local they_touching_3f = check_touching(grid, x, y)
      if they_touching_3f then
        for _, coords in ipairs(they_touching_3f) do
          touching_coords[coords] = true
        end
      else
      end
      number = (number .. cell)
    else
      if ((number ~= "") and (next(touching_coords) ~= nil)) then
        for key, value in pairs(touching_coords) do
          touchenings[key][number] = true
        end
      else
      end
      touching_coords = {}
      number = ""
    end
  end
end
print("should be: 467835")
local function _6_(...)
  local sum = 0
  local function _7_(...)
    local tbl_18_auto = {}
    local i_19_auto = 0
    for _, s in ipairs(numbers) do
      local val_20_auto = tonumber(s)
      if (nil ~= val_20_auto) then
        i_19_auto = (i_19_auto + 1)
        do end (tbl_18_auto)[i_19_auto] = val_20_auto
      else
      end
    end
    return tbl_18_auto
  end
  for _, n in ipairs(_7_(...)) do
    sum = (sum + n)
  end
  return sum
end
return print(("and is:    " .. _6_(...)))
