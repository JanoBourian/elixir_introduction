defmodule Example do
  def pm do
    a = 1
    list = [1, 2, 3, 4]
    [^a, b, c, _] = list
    IO.puts a
    IO.puts b
    IO.puts c
  end
end

Example.pm()
