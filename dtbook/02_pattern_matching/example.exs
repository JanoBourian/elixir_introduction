defmodule Example do
  def pm do
    list = [1, 2, 3]
    [a, b, c] = list
    IO.puts a
    IO.puts b
    IO.puts c
  end
end

Example.pm()
