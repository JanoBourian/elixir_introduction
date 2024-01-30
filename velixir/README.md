# Programming elixir >= 1.6

## Take the red pill

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
h(IEx.Helpers)
exports(IEx.Helpers)
exports(Kernel)
h(IO)
h(IO.puts)
IO.puts(:stderr, "\nBad Request")
i 123
i "cat"
i %{ name: "Dave", likes: "Elixir"}
i Map
h(Map)
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

## Pattern matching

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

The next matching patterns is going to fail

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
```
```
    - Variable Scope
```
```
    - End of the basics
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