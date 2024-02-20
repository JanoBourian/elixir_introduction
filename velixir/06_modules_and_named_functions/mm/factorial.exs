defmodule Factorial do
    def of(0), do: 1
    
    def of(n) when is_integer(n) and n>0 do
        n*of(n-1)
    end
    
    def of(_) do
        raise "No operation performanced for that argument."
    end
end

IO.puts Factorial.of(10)
IO.puts Factorial.of(-10)