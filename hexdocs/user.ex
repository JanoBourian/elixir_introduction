defmodule User do
  @enforce_keys [:make]
  defstruct [:email, :make, name: "John", age: 27]
end
