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

  def match_and_pipe(number) when is_number(number) do
    result = number
      |> Integer.to_string()
      |> String.graphemes()
      |> Enum.uniq()
      |> Enum.sort()
      IO.puts(result)
  end

  def match_and_pipe(_value), do: IO.puts("The argument should be a valid number")

end

Expressions.exp()

Expressions.match_and_pipe(54541838879408)
Expressions.match_and_pipe("random text")
