defmodule Greets do
    def greet(greeting, name), do: (
        IO.puts greeting
        IO.puts "How are you doing, #{name}?"
    )
end