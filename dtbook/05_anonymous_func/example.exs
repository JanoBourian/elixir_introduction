sum = fn (a,b) -> a + b end
IO.puts(inspect(sum.(2,1)))

greet = fn -> IO.puts("Hello, world!") end
greet.()

times = fn a, b -> a*b end
IO.puts(inspect(times.(2,-3)))

swap = fn {a, b} -> {b, a} end
IO.puts(inspect(swap.({8,3})))

handle_open = fn
  {:ok, file} -> "Read data: #{IO.read(file, :line)}"
  {_, error} -> "Error: #{:file.format_error(error)}"
end

IO.puts(inspect(handle_open.(File.open("data.txt"))))
IO.puts(inspect(handle_open.(File.open("nonexistent.txt"))))

fizz_buzz_function = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, a) -> a
end

rem_function = fn
  n -> fizz_buzz_function.(rem(n,3), rem(n, 5), n)
end

IO.puts(inspect(rem_function.(10)))
IO.puts(inspect(rem_function.(11)))
IO.puts(inspect(rem_function.(12)))
IO.puts(inspect(rem_function.(13)))
IO.puts(inspect(rem_function.(14)))
IO.puts(inspect(rem_function.(15)))
IO.puts(inspect(rem_function.(16)))

fun1 =
  fn ->
    fn ->
      "Hello world!"
    end
  end

IO.puts(fun1.().())

prefix =
  fn n ->
    fn other ->
      IO.puts(n <> " " <> other)
    end
  end

mrs = prefix.("Mrs")
mrs.("Smith")
prefix.("Elixir").("Rocks")

times_2 = fn n -> n*2 end
apply = fn(fun, value) -> fun.(value) end
IO.puts(apply.(times_2, 3))

list = [1, 3, 4, 5, 6, 7]
func = fn elem -> elem*elem end
IO.puts(inspect(Enum.map(list, func)))

defmodule Greeter do
  def for(name, greeting) do
    fn
      (^name) -> "#{greeting} #{name}"
      (_) -> "I don't know you"
    end
  end
end

mr_valim = Greeter.for("José", "Oi!")
IO.puts( mr_valim.("José"))
IO.puts( mr_valim.("Dave"))

# The & Notation

add_one = &(&1 + 1)
IO.puts(add_one.(44))

add_two = &(&1 + &2)
IO.puts(add_two.(13, 17))

div_rem = &{ div(&1, &2), rem(&1, &2)}
IO.puts(inspect(div_rem.(13, 5)))

IO.puts(inspect(Enum.map([1, 2, 3, 4, 5, 6, 7, 8, 9], &(&1*&1))))
