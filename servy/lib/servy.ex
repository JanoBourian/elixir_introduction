defmodule Servy do
  def hello(name) do
    "Hi, #{name}! Good morning."
  end
end

IO.puts Servy.hello("Elixir")