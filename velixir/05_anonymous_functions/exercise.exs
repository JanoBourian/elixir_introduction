function_2 = fn
    0, 0, _ -> "FizzBuzz"
    0, _, _ -> "Fizz"
    _, 0, _ -> "Buzz"
    _, _, c -> c
end

IO.puts function_2.(0, 0, 3)
IO.puts function_2.(0, 1, 3)
IO.puts function_2.(1, 0, 3)
IO.puts function_2.(1, 2, 3)

remainder = fn
    n -> function_2.(rem(n,3), rem(n, 5), n)
end
    
IO.puts remainder.(10)
IO.puts remainder.(11)
IO.puts remainder.(12)
IO.puts remainder.(13)
IO.puts remainder.(14)
IO.puts remainder.(15)
IO.puts remainder.(16)

greeter = fn name -> (fn -> "Hello #{name}" end) end
dave_greeter = greeter.("Dave")
IO.puts dave_greeter.()

add_n = fn n -> (fn other -> n + other end) end
add_two = add_n.(2)
add_five = add_n.(5)
IO.puts add_two.(3)
IO.puts add_five.(7)

prefix = fn str_1 -> (fn str_2 -> IO.puts str_1 <> " " <> str_2 end) end
mrs = prefix.("Mrs")
mrs.("Smith")
prefix.("Elixir").("Rocks")

times_2 = fn n -> n*2 end
apply = fn (fun, value) -> fun.(value) end
IO.puts apply.(times_2, 6)
list = [1, 2, 3, 4, 5]
Enum.map list, fn elem -> elem*2 end
Enum.map list, fn elem -> elem*elem end
Enum.map list, fn elem -> elem > 6 end

defmodule Greeter do
    def for(name, greeting) do
        fn
            (^name) -> "#{greeting}, #{name}"
            (_) -> "I don't know you"
        end
    end
end

mr_valim = Greeter.for("José", "Oi!")
IO.puts mr_valim.("José")
IO.puts mr_valim.("David")

add_one = &(&1 + 1)
IO.puts add_one.(7)
square = &(&1 * &1)
IO.puts square.(73)
speak = &(IO.puts &1)
speak.("Hello")

divrem = &{div(&1, &2), rem(&1, &2)}
IO.inspect divrem.(13, 5)