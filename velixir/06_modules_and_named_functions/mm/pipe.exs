defmodule Pipe do
    def operation(range) do
        range 
        |> Enum.map(&(&1*&1))
        |> Enum.filter(&(&1 < 40))
    end
end

IO.inspect Pipe.operation(1..10)