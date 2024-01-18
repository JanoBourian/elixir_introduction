defmodule Servy do
  def hello(name) do
    "Howdy, #{name}"
  end
end

IO.puts Servy.hello("Elixir")

defmodule Testing do
  def sum_operation(number_one, number_two) do
    "Result: #{number_one + number_two}"
  end
end

IO.puts Testing.sum_operation(17, 71)