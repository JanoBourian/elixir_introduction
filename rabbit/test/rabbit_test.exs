defmodule RabbitTest do
  use ExUnit.Case
  doctest Rabbit

  test "greets the world" do
    assert 1 + 1 == 2
    refute 2 + 1 == 2
  end
end
