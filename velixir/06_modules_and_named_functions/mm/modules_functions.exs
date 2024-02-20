defmodule MathOperation do
    def sum(1), do: 1
    
    def sum(n) when is_integer(n) and n>0 do 
        n+sum(n-1)
    end
    
    def sum(_), do: "Invalid value for this operation"
end

IO.puts MathOperation.sum(0)