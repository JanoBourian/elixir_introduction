defmodule Times do
    @moduledoc "Different ways to apply time operation"
    
    @doc "Times by two any argument"
    def double(n), do: n*2
    
    @doc "Times a argument by b argument"
    def double(a, b), do: a * b
    
    @doc "Times by three any argument"
    def triple(n), do: n*3
    
    @doc "Times by four any argument"
    def quadruple(n), do: double(2*n)
end