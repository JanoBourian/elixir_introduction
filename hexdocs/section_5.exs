## case

case {1, 2, 3} do
  {4, 5, 6} ->
    "This clause won't match"
  {1, x, 3} ->
    "This clause will match and bind x to 2 in this clause"
  _ ->
    "This clause would math any value"
end

x = 1
case 10 do
  ^x -> "Won't match"
  _ -> "Will match"
end

case {1, 2, 3} do
  {1, x, 3} when x>0 and is_integer(x)->
    "Will match"
  _ ->
    "Would match, if guard condition were not satisfied"
end

case 1 do
  x when hd(x) ->
    "Won't match"
  x ->
    "Got #{x}"
end

## cond

cond do
  2 + 2 == 5 ->
    "This is never true"
  1 * 2 == 3 ->
    "Nor this"
  1 + 1 == 2 ->
    "But this will"
  true ->
    "This is always true (equivalent to else)"
end

## unless

unless false do
  IO.puts "This will be seen"
end

unless true do
  IO.puts "This will never be seen"
end

## if/else
if nil do
  "This won't be seen"
else
  "This will"
end

x = 1
x = if true do
  x + 1
else
  x
end
