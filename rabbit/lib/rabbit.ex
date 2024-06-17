defmodule Rabbit do
  @moduledoc """
  Documentation for `Rabbit`.
  """

  def hello(name) do
    "Howdy, #{name}!"
  end
end

IO.puts Rabbit.hello("Elixir")
