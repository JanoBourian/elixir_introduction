defmodule Expressions do
  def exp do
    IO.puts(10/3)
    IO.puts(div(10,3))
    IO.puts(rem(10,3))

    # Logic expressions
    c1 = 2 > 1
    IO.puts(c1)
  end

  def text ~> sub do
    String.contains?(text, sub)
  end
end

Expressions.exp()
