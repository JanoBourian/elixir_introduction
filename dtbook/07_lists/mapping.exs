defmodule Mapping do
  def reduce([], value, _function), do: value
  def reduce([head|tail], value, function) do
    reduce(tail, function.(value,head), function )
  end
end

IO.puts(Mapping.reduce([1,2,3], 0, fn (a,b) -> a + b end))
