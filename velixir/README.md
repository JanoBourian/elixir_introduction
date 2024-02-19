# Programming elixir >= 1.6

# Take the red pill

A fast way to access the files

```bash
docker run -it -v /home/ec2-user/environment/elixir_introduction/velixir:/app/data --rm elixir bash
docker run -it --rm elixir
docker run -it --rm elixir bash
```

First little program

```elixir
defmodule Parallel do
    def pmap(collection, func) do
        collection
        |> Enum.map(&(Task.async(fn -> func.(&1) end)))
        |> Enum.map(&Task.await/1)
    end
end

result = Parallel.pmap 1..1000, &(&1 * &1)

result
```

Running elixir

* iex - Interactive Elixir

```elixir
iex
IO.puts "Hello, world!"
String.reverse("Animal")
```

* IEx Helpers

```elixir
h
h(IEx.Helpers) # to get information
exports(IEx.Helpers) # to list all IEx helpers
exports(Kernel)
h(IO)
h(IO.puts)
IO.puts(:stderr, "\nBad Request")
i 123 # to introspect any value
i "cat"
i %{ name: "Dave", likes: "Elixir"}
i Map
h(Map)
Map.module_info() # to access metadata
```

* Customizing iex

```elixir
h(IEx.configure)
IEx.configure colors: [ eval_result: [ :cyan, :bright ]]
```

* Compile and run

```elixir
IO.puts("Hello, world!")
c "hello.exs"
```

# Pattern matching

```elixir
a = 1
1 = a
2 = a # raises an error
```
* More complex matches

```elixir
list = [1, 2, 3]
[a, b, c] = list
a
b
c
list = [1, 2, [3, 4, 5]]
[a, b, c] = list
a
b
c
```

The next matching pattern is going to fail

```elixir
[a, b] = [1, 2, 3]
[[a]] = [[1, 2, 3]]
```

* Ignore a value and variables bind once

```elixir
[1, _, _] = [1, 2, 3]
[1, _, _] = [1, "cat", "dog"]
[a, a] = [1, 1]
[b, b] = [1, 2]
a = 1
a = 2
^a = 1 # Error
a = 1
[^a, 2, 3] = [1, 2, 3]
a = 2
[^a, 2] = [1, 2]
```

# Immutability

```elixir
list1 = [3, 2, 1]
list2 = [ 4 | list1]
name = "elixir"
cap_name = String.capitalize(name)
name
cap_name
```

# Elixir Basics

* Value types
    - Integers
    - Floating-point numbers
    - Atoms
    - Ranges
    - Regular Expressions
    
```elixir
Regex.run(~r{[aeiou]}, "caterpillar")
Regex.scan(~r{[aeiou]}, "caterpillar")
Regex.split(~r{[aeiou]}, "caterpillar")
Regex.replace(~r{[aeiou]}, "caterpillar", "*")
```
* System types
    - PIDs and ports
    - References
* Collection types
    - Tuples
```elixir
tuple_1 = { 1, 2}
tuple_2 = { :ok, 42, "next"}
tuple_3 = { :error, :enoent}
{status, count, action} = tuple_2
status

# Another example
{status, _} = File.open("mix.exs")
IO.puts(status)

{status, _} = File.open("non-existent-file.exs")
IO.puts(status)
```
    * Lists
```elixir
[1, 2, 3] ++ [4, 5, 6] #concatenation
[1, 2, 3, 4, 5] -- [2, 3, 5] #difference
1 in [1, 2, 3]
"wombat" in [1, 2, 3]

# keywords lists
list1 = [ name: "Dave", city: "Dallas", likes: "Programming"]
list2 = [ {:name, "Dave"}, {:city, "Dallas"}, {:likes, "Programming"}]
list1 = list2

# leave off square brackets
DB.save(record,[{:use_transaction, true}, {:logging, "HIGH"}])
DB.save record, [{:use_transaction, true}, {:logging, "HIGH"}]
DB.save record, use_transaction: true, logging: "HIGH"

# leave off the brackets
[1, fred: 1, dave: 2]
{1, fred: 1, dave: 2}
```
    - Maps
```elixir
# Template for a Map
%{ key => value, key => value}

# Keys are strings
states = %{ "AL" => "Alabama", "WI" => "Wisconsin"}

# Keys are tuples
responses = %{ {:error,:enoent} => :fatal, {:error, :busy} => :fatal} 

# Keys are atoms
colors = %{ :red => 0xff0000, :green => 0x00ff00, :blue => 0x0000ff}

# Keys are mix
%{ "one" => 1, :two => 2, {1,1,1} => 3}

# Accessing a Map
states["AL"]
states["TX"]
colors[:red]
colors.red
```
    - Binaries
```elixir
bin = <<1, 2>>
byte_size bin
bin = <<3 :: size(2), 5 :: size(4), 1 :: size(2)>>
:io.format("~-8.2b~n", :binary.bin_to_list(bin))
byte_size bin
```
    - Dates and times: Calendar.ISO, 
      the ISO-8601 representation of the Gregorian calendar
```elixir
d1 = Date.new(2018, 12, 25)
{:ok, ~D[2018-12-25]} = Date.new(2018, 12, 25)
d2 = ~D[2018-12-25]
Date.day_of_week(d2)
Date.add(d2, 7)
inspect d1, structs: false

# range of dates
d1 = ~D[2018-01-01]
d2 = ~D[2018-06-30]
first_half = Date.range(d1, d2)
Enum.count(first_half)
~D[2018-03-15] in first_half

# Time type
{:ok, t1} = Time.new(12, 34, 56)
t2 = ~T[12:34:56.78]
t1 == t2
Time.add(t1, 3600)
Time.add(t1, 3600, :millisecond)
Time.add(t1, 3, :hour)
```
    - Names, Source Files, Conventions, Operators and So On
```elixir
# strict equality
1 === 1.0 # false

# strict inequality
1 !== 1.0 #true

# value equality
1 == 1.0 # true

# value inequality
1 != 1.0 # false

# normal comparison
a > b
a >= b
a < b
a <= b

# Rule for comparison
# number < atom < reference < function < port < pid < tuple < map < list < binary

# Boolean operators (these expect true or false as their first argument)
a or b # true if a is true; otherwise b
a and b # false if a is false; otherwise b
not a # false if a is true; true otherwise

# Relaxed Boolean operators (These operators take arguments of any type)
a || b # a if a is truthy; otherwise b
a && b # b if a is truthy; otherwise a
!a # false if a is truthy

# Arithmetic operators
+-*/ div rem

# join operators
binary <> binary
list1 ++ list2
list1 -- list2

# the in operator
a in enum

```
    - Variable Scope
```elixir
# If you use <- instead of = in a with expression, it permforms a match, but if
# it fails it returns the value that could not be matched
```

# Anonymous Functions

```elixir
sum = fn (a,b) -> a + b end
sum.(1,2)
greet = fn -> IO.puts "hello" end
greet.()
f1 = fn a, b -> a*b end
f1.(2,3)
swap = fn {a, b} -> {b, a} end
swap.({"Hello", "Goodbye"})
```

```elixir
# Exercise: Functions-1
list_concat = fn ([a, b], [c, d]) -> [a, b, c, d] end
list_concat.([2, 3], [5, 7])
sum = fn a, b, c -> a + b + c end
sum.(1, 2, 3)
pair_tuple_to_list = fn {a, b} -> [a, b] end
pair_tuple_to_list.({1234, 5678})
```

## One function, multiple bodies

```elixir
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
```

## Functions can return functions

```elixir
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
```

## Passing Functions as arguments
```elixir
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
```

### Shorcuts
```elixir
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
```

# Modules and named functions

```elixir
defmodule Times do
    def double(n) do
        n*2
    end
    
    def double(a, b) do
        a * b
    end
end
```

```bash
iex mm/times.exs
c "mm/times.exs"
```

One line function
```elixir
def double(n), do: n*2
```

Functions calls and pattern matching
```elixir
defmodule Factorial do
    def of(0), do: 1
    def of(n), do: n*of(n-1)
end
```

## Guard clauses
```elixir
defmodule Guard do
    def what_is(x) when is_number(x) do
        IO.puts "#{x} is a number."
    end
    
    def what_is(x) when is_list(x) do
        IO.puts "#{inspect(x)} is a list."
    end
    
    def what_is(x) when is_atom(x) do
        IO.puts "#{x} is an atom."
    end
end
```

For the *when* clause you can use the next Type-check functions:
- is_atom
- is_binary
- is_bitstring
- is_boolean
- is_exception
- is_float
- is_function
- is_integer
- is_list
- is_map
- is_number
- is_pid
- is_port
- is_record
- is_reference
- is_tuple
- 

and another kind of functions:
- abs(number)
- bit_size(bitstring)
- byte_size(bitstring)
- div(number, number)
- elem(tuple, n)
- float(term)
- hd(list)
- length(list)
- node()
- node(pid|reflport)
- rem(number, number)
- round(number)
- self()
- tl(list)
- trunc(number)
- tuple_size(tuple)

## Default parameters

```elixir
defmodule Example do
    def fun(p1, p2 \\ 2, p3 \\ 3, p4) do
        IO.inspect [p1, p2, p3, p4]
    end
end

## some use cases
Example.fun(1, 4) # [1, 2, 3, 4]
Example.fun("a", "b") # ["a", 2, 3, "b"]
Example.fun("a", "b", "c") # ["a", "b", 3, "c"]
```

```
```

```
```

```
```

```
```

```
```

```
```

```
```

```
```

```
```

```
```

```
```

```
```