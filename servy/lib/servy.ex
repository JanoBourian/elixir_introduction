defmodule Servy do
  def hello(name) do
    "Hi, #{name}! Good evening."
  end
end

IO.puts Servy.hello("Elixir")