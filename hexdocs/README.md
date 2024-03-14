# hexdocs

This is going to be a file to create documentation based on the Elixir official 
documentation. https://hexdocs.pm/elixir/1.16/introduction.html

## Index
- [Introduction](#section1)
- [Basic Types](#section2)
- [Lists and tuples](#section3)
- [Pattern matching](#section4)
- [case, cond, and if](#section5)
- [Anonymous functions](#section6)
- [Binaries, strings, and charlists](#section7)
- [Keyword lists and maps](#section8)
- [Modules and functions](#section9)
- [Recursion](#section10)
- [Enumerables and Streams](#section11)
- [Processes](#section12)
- [IO and the file system](#section13)
- [alias, require, and import](#section14)
- [Modules attributes](#section15)
- [Structs](#section16)
- [Protocols](#section17)
- [Comprehensions](#section18)
- [Sigils](#section19)
- [try, catch, and rescue](#section20)
- [Writing documentation](#section21)
- [Optional syntax sheet](#section22)
- [Erlang libraries](#section23)
- [Debugging](#section24)

## API References

Modules https://hexdocs.pm/elixir/1.16.1/api-reference.html#modules

## Installation

```bash
docker run -it -v /home/ec2-user/environment/elixir_introduction/hexdocs:/app/data --rm elixir bash
docker run -it --rm elixir bash
```
<div id="section1"></div>

## Introduction

```elixir
"Hello " <> "world!"
IO.puts("Hello world!")
```

Running a script:
```bash
elixir simple.exs
```

<div id="section2"></div>

## Basic types

```elixir
:atom # atom / symbol
[1, 2, 3] # list
{1, 2, 3} # tuple
0b1010 # binary
0o777 # octal
0x1F # hexadecimal
1.0e-10 # scientific notation
```

```elixir
IO.puts("With a bunch of flow")

# Atom is a couriose type
IO.puts(Atom.to_string(:foo))

# Some operations
IO.puts(5/2)
IO.puts(div(10,2))
IO.puts(div 10, 2 )
IO.puts(rem 10, 2 )
IO.puts(round(4.58))
IO.puts(trunc(4.58))
IO.puts(is_integer(1))
IO.puts(is_integer(true))
```

To get function documentation using the iex console. The structure is "h" to indicate
that we need help, "trunc" is the function or module name and, finally, "/1" is
the number of arguments that the function recieves.

```elixir
h trunc/1
h Kernel.trunc/1
```

Booleans
```elixir
true
true == false
# and/2
true and true
# or/2
false or is_boolean(true)
# not/1
not false
# The first argument should be evaluated as boolean
1 and true # error

# to evaluate nil we have ||/2, &&/2 and !/1
1 || true
nil && 13
!true
```

Atoms

An atom is a constante whose value is its own name. 
```elixir
:apple
:orange
:apple == :apple
:apple == :orange
# true and false are atoms
true == :true
is_atom(false)
is_boolean(:true)
```

Strings
```elixir
string = "world!"
"Hello " <> string
"Hello #{string}"
long_message = "hello\nworld"
IO.puts long_message
byte_size(long_message)
String.length(long_message)
String.upcase(long_message)
```

Structural comparison
```elixir
1 == 1
1 != 2
1 < 2
"foo" == "foo"
"foo" == "bar"
"foo" != "bar"
1 == 1.0
2 == 2.0
1 === 1.0 # strict comparison operator
2 !== 2.0
```

<div id="section3"></div>

## List and tuples

### List
```elixir
[1, 2, 3, 4, true]
length([1, 2, 3, 4, true])
# add and subtract
[1, 2, 3] ++ [4, 5, 6]
[1, 2, 3, true, 5, true, 7, false] -- [true, false]
list = [1, 2, 3, 4]
hd(list)
tl(list)
[head | tail] = list
[11, 12, 13]
# ~c"\v\f\r"
[104, 101, 108, 108, 111]
# ~c"hello"
i ~c"hello"
```

### Tuples
```elixir
{:ok, "hello"}
tuple_size({:ok, "hello"})
tuple = {:ok, "hello"}
elem(tuple, 1)
tuple_size(tuple)
tuple_2 = put_elem(tuple, 1, "world")
```

Lists are returned when the number of elements returned may vary, on the other hand, tuples have a fixed size.

```elixir
String.split("Hello world")
String.split("hello beautiful world")
String.split_at("hello beautiful world", 3)
String.split_at("hello beautiful world", -4)
```

To retrieve a file
```elixir
Path.expand("", __DIR__)
|> Path.join("simple.exs")
|> File.read()
```

<div id="section4"></div>

## Pattern matching

```elixir
x = 1
1 = x
# MatchError
2 = x
{a, b , c} = {:hello, "world", 42}
a
b
c
# MatchError
{a, b, c} = [1, 2, 3]
{:ok, result} = {:ok, 42}
result
```

pin operator (^)
```elixir
x = 1
^x = 2
```

<div id="section5"></div>

## case, cond, and if

```elixir
## Case

case {1, 2, 3} do
  {4, 5, 6} ->
    "This clause won't match"
  {1, x, 3} ->
    "This clause will match and bind x to 2 in this clause"
  _ ->
    "This clause would math any value"
end

x = 1
case 10 do
  ^x -> "Won't match"
  _ -> "Will match"
end

case {1, 2, 3} do
  {1, x, 3} when x>0 and is_integer(x)->
    "Will match"
  _ ->
    "Would match, if guard condition were not satisfied"
end

case 1 do
  x when hd(x) ->
    "Won't match"
  x ->
    "Got #{x}"
end

```

```elixir
# cond
cond do
  2 + 2 == 5 ->
    "This is never true"
  1 * 2 == 3 ->
    "Nor this"
  1 + 1 == 2 ->
    "But this will"
  true ->
    "This is always true (equivalent to else)"
end
```

```elixir
## unless

unless false do
  IO.puts "This will be seen"
end

unless true do
  IO.puts "This will never be seen"
end
```

```if/else
## if/else
if nil do
  "This won't be seen"
else
  "This will"
end

x = 1
x = if true do
  x + 1
else
  x
end
```

<div id="section6"></div>

## Anonymous functions

```elixir
add = fn(a, b) -> a + b end
add.(1, 2)
is_function(add)
is_function(add, 2)
is_function(add, 1)
```

### Closures

```elixir
double = fn a -> add.(a, a) end
double.(2)
```

### Clauses and guards

```elixir
f = fn
  x, y when x > 0 -> x + y
  x, y -> x * y
end
f.(1, 2)
```

### The capture operator

```elixir
fun = &is_atom/1
fun.(:hello)
fun.(123)
fun = &String.length/1
fun.("hello")
add = &+/2
add.(1, 2)
fun = fn (a, b, c) -> a + b + c end
fun.(1, 2, 3)
fun = &(&1 + &2 + &3)
fun.(1, 2, 3)
```

<div id="section7"></div>

## Binaries, strings, and charlists

```elixir
String.codepoints("👩‍🚒")
String.graphemes("👩‍🚒")
String.length("👩‍🚒")
<<0::1, 0::1, 1::1, 1::1>> == <<3::4>>
<<head, rest::binary>> = "banana"
<<x::utf8, rest::binary>> = "über"
heartbeats_per_minute = [99, 97, 116]
inspect(heartbeats_per_minute, charlists: :as_list)
```

<div id="section8"></div>

## Keyword lists and maps

Keyword lists are not good for pattern matching.
Keyword is the module of this kind of structure

### Keyword lists

```elixir
String.split("1 2 3", " ")
String.split("1  2  3", " ")
String.split("1  2  3", " ", [trim: true])
[{:trim, true}] == [trim: true]
list = [a: 1, b: 2]
list ++ [c: 3]
[a: 0] ++ list
list[:a]
list[:c]
```

Ecto example
```elixir
query = 
  from w in Weather,
  where: w.prcp > 0,
  where: w.temp < 20,
  select: w
```

### do-blocks and keywords

```elixir
if true do
  "This will be seen"
else
  "This won't"
end

if true, do: "This will be seen", else: "This won't"
```

### Maps

* Maps are the "go to" data structure in Elixir
* An empty map matches all maps
* Maps allow any value as a key
* Maps' keys do not follow any ordering
* Map is its module

```elixir
map = %{:a => 1, :b => 2}
map[:a]
map[:b]
map[:c]
Map.get(map, :a)
Map.put(map, :c, 3)
Map.to_list(map)
```

Some operations

```elixir
map = %{:name => "John", :age => 23}
map = %{name: "John", age: 23}
map.name
map.age
# Update keys
%{ map | name: "Mary"}
```

Nested operations

```elixir
users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]
users[:john].age
users = put_in users[:john].age, 31
users = update_in users[:mary].languages, fn languages -> List.delete(languages, "Clojure") end
```

Modules to review:
* put_in/2
* update_in/2
* get_and_update_in/2
* put_in/3
* update_in/3
* get_and_update_in/3

<div id="section9"></div>

## Modules and functions

Create file `math.ex` and compile it using `elixirc math.ex` and it generates `Elixir.Math.beam`, it file contains the bytecode for the defined module.

```elixir
defmodule Math do
  def sum(a, b) do
    a + b
  end
end

```

### Scripting mode

`defp` prefix is used for private functions

```elixir
defmodule Math do
  def sum(a, b) do
    do_sum(a, b)
  end

  defp do_sum(a, b) do
    a + b
  end

  def zero?(0), do: true

  def zero?(x) when is_integer(x), do: false

end

IO.puts Math.sum(1, 2)
IO.puts Math.zero?(0)
IO.puts Math.zero?(1)
# IO.puts Math.zero?(1.0) #=> Error
# IO.puts Math.zero?(1.5) #=> Error

```

### Default arguments

```elixir
defmodule Concat do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world")
IO.puts Concat.join("Hello", "world", "-")

```

Head functions declarating default parameters

```elixir
defmodule Concat do
  def join(a, b \\ nil, sep \\ " ")

  def join(a, b, _sep) when is_nil(b) do
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world")
IO.puts Concat.join("Hello", "world", "-")
IO.puts Concat.join("Hello")

```

<div id="section10"></div>

```elixir
```

<div id="section11"></div>

```elixir
```

<div id="section12"></div>

```elixir
```

<div id="section13"></div>

```elixir
```

<div id="section14"></div>

```elixir
```

<div id="section15"></div>

```elixir
```

<div id="section16"></div>

```elixir
```

<div id="section17"></div>

```elixir
```

<div id="section18"></div>

```elixir
```

<div id="section19"></div>

```elixir
```

<div id="section20"></div>

```elixir
```

<div id="section21"></div>

```elixir
```

<div id="section22"></div>

```elixir
```

<div id="section23"></div>

```elixir
```


```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```

```elixir
```
