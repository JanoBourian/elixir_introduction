defmodule Supersoaker.Language do
  def hello,  do: IO.puts "Hello, World!"

  def area(base, altura), do: base * altura

  def atoms do
    :ok
  end
end

Supersoaker.Language.hello
IO.puts Supersoaker.Language.area(2, 3)
IO.puts Supersoaker.Language.atoms
