defmodule MyList do
  def len([]), do: 0
  def len([_|tail]), do: 1 + len(tail)
  def square([]), do: []
  def square([head|tail]), do: [head*head | square(tail)]
end

IO.puts MyList.len([1, 2, 3, 4])
IO.puts MyList.len([])
IO.inspect MyList.square([1, 2, 3, 4])
IO.inspect MyList.square([])
