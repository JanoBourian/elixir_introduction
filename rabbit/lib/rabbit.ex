defmodule Rabbit do
  @moduledoc """
  Documentation for `Rabbit`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Rabbit.hello()
      :world

  """
  def hello(name) do
    "Howdy, #{name}!"
  end
end

IO.puts Rabbit.hello("Elixir")
