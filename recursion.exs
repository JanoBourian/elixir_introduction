defmodule Recursion do
  def loopy([head | tail]) do
    IO.puts("Head #{head} Tail: #{inspect(tail)}")
    loopy(tail)
  end

  def loopy([]), do: IO.puts("Done")
end

Recursion.loopy([1, 2, 3, 4, 5])

defmodule Factorial do

  def factorial(0), do: 1

  def factorial(n) when is_integer(n) and n > 0, do: n*factorial(n - 1)

  def factorial(arg), do: IO.puts("Invalid arg #{inspect(arg)}")

end

IO.puts(Factorial.factorial(64))
