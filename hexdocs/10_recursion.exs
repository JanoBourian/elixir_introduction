### Recursion
defmodule Recursion do
  def print_multiple_times(message, n) when n > 0 do
    IO.puts(message)
    print_multiple_times(message, n-1)
  end

  def print_multiple_times(_message, 0) do
    :ok
  end

  def print_multiple_times(_message, _n) do
    IO.puts("Invalid number")
  end
end

Recursion.print_multiple_times("Hello", 3)
Recursion.print_multiple_times("Hello", 0)
Recursion.print_multiple_times("Hello", -3)

### Factorial
defmodule Factorial do
  def factorial(0), do: 1
  def factorial(n) when is_integer(n) and n > 0, do: n*factorial(n-1)
  def factorial(arg),  do: "Invalid argument #{arg}"
end

IO.puts(Factorial.factorial(15))
IO.puts(Factorial.factorial(-15))

### sum_list
defmodule ListOperations do
  def sum_list([head | tail], accumulator), do: sum_list(tail, accumulator + head)
  def sum_list([], accumulator), do: accumulator
  def double_each([head | tail]), do: [head*2 | double_each(tail)]
  def double_each([]), do: []
end

IO.puts(ListOperations.sum_list([1, 2, 3, 4, 5, 6], 0))
ListOperations.double_each([1, 2, 3, 4, 5, 6])
