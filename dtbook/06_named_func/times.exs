defmodule Times do
  def double(n) when is_integer(n), do: IO.puts("#{n*2}")
  def double(_), do: IO.puts("Not an integer")
end

Times.double(5)
