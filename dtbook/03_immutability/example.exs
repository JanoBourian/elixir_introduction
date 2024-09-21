defmodule Example do
  def function do
    list1 = [3, 2, 1]
    IO.puts(inspect(list1))
    list2 = [4 | list1]
    IO.puts(inspect(list2))
    list1 = [2, 1]
    IO.puts(inspect(list1))
    IO.puts(inspect(list2))
  end

  def cap(text) do
    text
    |> String.capitalize()
    |> IO.puts()
  end
end

Example.function()
Example.cap("elixir and phoenix")
