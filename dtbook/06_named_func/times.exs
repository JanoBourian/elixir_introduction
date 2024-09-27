defmodule Times do
  def double(n) when is_integer(n), do: IO.puts("#{n*2}")
  def double(_), do: IO.puts("Not an integer")
end

defmodule Factorial do
  def factorial(0), do: 1
  def factorial(n) when is_integer(n) and n > 0, do: n*factorial(n-1)
  def factorial(_), do: "Something was wrong!"
end

Times.double(5)
IO.puts Factorial.factorial(1990)

defmodule Example do
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.puts(inspect([p1, p2, p3, p4]))
  end
end

Example.func("a", "b")
Example.func("a", "b", "c")
Example.func("a", "b", "c", "d")

defmodule Chop do
  def guess(number, a..b) when div(a + b, 2) == number do
    IO.puts("#{number}")
  end
  
  def guess(number, a..b) when div(a + b, 2) > number do
    IO.puts("It is #{div(a + b, 2)}")
    guess(number, a..div(a + b,2))
  end
  
  def guess(number, a..b) when div(a + b, 2) < number do
    IO.puts("It is #{div(a + b, 2)}")
    guess(number, div(a + b,2)..b)
  end
end