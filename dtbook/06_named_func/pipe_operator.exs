defmodule Pipe do
  def op do
    (1..10)
    |> Enum.map(&(&1*&1))
    |> Enum.filter(&(&1 < 40))
    |> IO.inspect()
  end
end

defmodule Example do
  def func1 do
    List.flatten [1, [2, 3], 4]
  end

  def func2 do
    import List, only: [flatten: 1]
    flatten [1, [2, 3], 4]
  end
end

Pipe.op()
IO.inspect(Example.func1())
IO.inspect(Example.func2())
