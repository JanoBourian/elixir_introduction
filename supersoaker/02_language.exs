defmodule Supersoaker.Language do
  def hello,  do: IO.puts "Hello, World!"

  def area(base, altura), do: base * altura

  def atoms do
    :ok
  end

  def integer_convertion(number) do
    IO.puts Integer.to_string(number)
    IO.puts Integer.to_charlist(number)
    IO.puts inspect Integer.digits(number)
    IO.puts Integer.gcd(number, 3)
  end
end

Supersoaker.Language.hello
IO.puts Supersoaker.Language.area(2, 3)
IO.puts Supersoaker.Language.atoms
Supersoaker.Language.integer_convertion(17)
