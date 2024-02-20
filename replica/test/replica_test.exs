defmodule ReplicaTest do
  use ExUnit.Case
  doctest Replica

  test "greets the world" do
    assert Replica.hello() == :world
  end
end
