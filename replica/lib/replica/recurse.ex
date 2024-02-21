defmodule Recurse do
    def loopy([head | tail]) do
        IO.puts "Head #{head} and Tail #{inspect(tail)}"
        loopy(tail)
    end
    
    def loopy([]), do: IO.puts "Done!"
end

Recurse.loopy([1, 2, 3, 4, 5])
Recurse.loopy([])

defmodule Factorial do
    def fun(0), do: 1
    def fun(n) when is_integer(n) and n > 0 do
        n*fun(n-1)
    end
    def fun(arg), do: "Invalid argument: #{inspect(arg)}"
end

IO.puts Factorial.fun(500)
IO.puts Factorial.fun("500")
IO.puts Factorial.fun(%{ method: "POST"})