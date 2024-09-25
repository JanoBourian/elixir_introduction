defmodule Times do
  def double(n) when is_integer(n), do: IO.puts("#{n*2}")
  def double(_), do: IO.puts("Not an integer")
end

defmodule Factorial do
  def factorial(0), do: 1
  def factorial(n) when is_integer(n) and n > 0, do: n*factorial(n-1)
end

Times.double(5)
IO.puts Factorial.factorial(1990)
