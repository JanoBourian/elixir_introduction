defmodule Mapping do
  def reduce([], value, _function), do: value
  def reduce([head|tail], value, function) do
    reduce(tail, function.(value,head), function )
  end

  def mapsum([], _function), do: 0
  def mapsum([head|tail], function) do
    function.(head) + mapsum(tail, function)
  end

  def max([single_element]), do: single_element
  def max([head|tail]) do
    max_tail = max(tail)
    if head > max_tail do
      head
    else
      max_tail
    end
  end
end

IO.puts(Mapping.reduce([1,2,3], 0, fn (a,b) -> a + b end))
IO.puts(Mapping.mapsum([1,2,3], &(&1*&1)))
IO.puts(Mapping.max([17,19,3,2,5,7,13]))
