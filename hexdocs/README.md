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

## Recursion

```elixir
defmodule Recursion do
  def print_multiple_times(message, n) when n > 0 do
    IO.puts(message)
    print_multiple_times(message, n-1)
  end

  def print_multiple_times(_message, 0) do
    :ok
  end

  def print_multiple_times(_message, _n) do
    IO.puts("Invalid number")
  end
end

Recursion.print_multiple_times("Hello", 3)
Recursion.print_multiple_times("Hello", 0)
Recursion.print_multiple_times("Hello", -3)

defmodule Factorial do
  def factorial(0), do: 1
  def factorial(n) when is_integer(n) and n > 0, do: n*factorial(n-1)
  def factorial(arg),  do: "Invalid argument #{arg}"
end

IO.puts(Factorial.factorial(15))
IO.puts(Factorial.factorial(-15))

```

### Reduce and map algorithms

```elixir
### Recursion
defmodule Recursion do
  def print_multiple_times(message, n) when n > 0 do
    IO.puts(message)
    print_multiple_times(message, n-1)
  end

  def print_multiple_times(_message, 0) do
    :ok
  end

  def print_multiple_times(_message, _n) do
    IO.puts("Invalid number")
  end
end

Recursion.print_multiple_times("Hello", 3)
Recursion.print_multiple_times("Hello", 0)
Recursion.print_multiple_times("Hello", -3)

### Factorial
defmodule Factorial do
  def factorial(0), do: 1
  def factorial(n) when is_integer(n) and n > 0, do: n*factorial(n-1)
  def factorial(arg),  do: "Invalid argument #{arg}"
end

IO.puts(Factorial.factorial(15))
IO.puts(Factorial.factorial(-15))

### sum_list
defmodule ListOperations do
  def sum_list([head | tail], accumulator), do: sum_list(tail, accumulator + head)
  def sum_list([], accumulator), do: accumulator
  def double_each([head | tail]), do: [head*2 | double_each(tail)]
  def double_each([]), do: []
end

IO.puts(ListOperations.sum_list([1, 2, 3, 4, 5, 6], 0))
ListOperations.double_each([1, 2, 3, 4, 5, 6])

```

<div id="section11"></div>

## Enumerables and Streams

### Enumerables
```elixir
IO.puts Enum.map([1, 2, 3], fn x -> x* 2 end)
IO.puts Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k*v end)
IO.puts Enum.map(1..3, fn x -> x*2 end)
IO.puts Enum.reduce(1..3, 0, &+/2)

```

### Eager vs Lazy and the pipe operator
```elixir
odd? = fn x -> rem(x, 2) != 0 end
1..13 |> Enum.filter(odd?) |> Enum.sum()
```

### Streams
```elixir
stream = Stream.cycle([1, 2, 3])
Enum.take(stream, 10)

```

<div id="section12"></div>

## Processes

Important functions `spawn()`, `Process.alive?()`, `self()`, `flush()`

```elixir
pid = spawn(fn -> 1+ 2 end)
IO.puts Process.alive?(pid)
self()
IO.puts Process.alive?(self())

### Sending and receiving messages
send(self(), {:hello, "world"})
receive do
  {:hello, msg} -> msg
  {_, _msg} -> "won't mathc"
end

receive do
  {:hello, msg} -> msg
after
  3_000 -> "nothing after 1 second"
end

parent = self()
spawn(fn -> send(parent, {:hello, self()}) end)
receive do
  {:hello, pid} -> "Got hello from #{inspect pid}"
end
```

### State

```elixir
defmodule KV do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end
  def loop(map) do
    receive do
      {:get, key, caller} ->
        send(caller, Map.get(map, key))
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end

```

### Agents

Agents are a abstraction around state

```elixir
{:ok, pid} = Agent.start_link(fn -> %{} end)
Agent.update(pid, fn map -> Map.put(map, :hello, :world) end)
Agent.get(pid, fn map -> Map.get(map, :hello) end)
```

<div id="section13"></div>

## IO and the file system

### IO
```elixir
IO.puts("Hello")
IO.gets("ready or not? ")
```

### File system
```elixir
{:ok, file} = File.open("test_file.txt", [:write])
IO.binwrite(file, "world")
File.close(file)
{:ok, file} = File.read("test_file.txt")
IO.puts(file)

```

### Path
```elixir
IO.puts Path.join("hello", "world")
IO.puts Path.expand("~/hello")

```

<div id="section14"></div>

## alias, require, and import

```elixir
# Alias the module so it can be called as Bar instead of Foo.Bar
alias Foo.Bar, as: Bar

# Require the module in order to use its macros
require Foo

# Import functions from Foo so they can be called without the `Foo.` prefix
import Foo

# Invokes the custom code defined in Foo as an extension point
use Foo
```

```elixir
defmodule Stats do
  alias Math.List
  # alias Math.List, as: List
  import List, only: [duplicate: 2]

end

```

<div id="section15"></div>

## Module attributes

Common modules `@moduledoc`, `@doc`, `@spec`, and `@behaviour`

```elixir
defmodule Math do
  @moduledoc """
  Provides math-realted functions.

  ## Examples
    iex> Math.sum(1, 2)
    3

  """

  @doc """
  Calculates the sum of two numbers
  """
  def sum(a, b), do: a + b

end

```

```elixir
defmodule MyApp.Status do
  @service URI.parse("https://example.com")
  def status(email) do
    SomeHttpClient.get(@service)
  end
end

defmodule MyApp.Status do
  @service URI.parse("https://example.com")
  def status(email) do
    SomeHttpClient.get(%URI{
      authority: "example.com",
      host: "example.com",
      port: 433,
      scheme: "https"
    })
  end
end

## Instead of this
def some_function, do: do_something_with(@example)
def another_function, do: do_something_else_with(@example)

## Use this
def some_function, do: do_something_with(example())
def another_function, do: do_something_else_with(example())
defp example, do: @example

```

<div id="section16"></div>

## Structs

```elixir
defmodule User do
  @enforce_keys [:make]
  defstruct [:email, :make, name: "John", age: 27]
end

```

```elixir
john = %User{make: "make"}
john.name
john.age
jane = %User{make: "make", name: "Jane"}
jane.name
jane.age
anonymous = %User{john | name: "Anonymous"}
anonymous.name
anonymous.age

%User{} = anonymous

```

<div id="section17"></div>

## Protocols

Protocols are a mechanism to achieve polymorphism

```elixir
defprotocol Size do
  @doc "Calculates the size (and not the length!) of a data structure"
  def size(data)
end

defimpl Size, for: BitString do
  def size(string), do: byte_size(string)
end

defimpl Size, for: Map do
  def size(map), do: map_size(map)
end

defimpl Size, for: Tuple do
  def size(tuple), do: tuple_size(tuple)
end

## This implementation is for Structs
defimpl Size, for: MapSet do
  def size(set), do: MapSet.size(set)
end

```

<div id="section18"></div>

## Comprehensions

```elixir
for n <- [1, 2, 3, 4], do: n*n
```

### Generators

```elixir
for n <- 1..10, do: n*n
for i <- [:a, :b, :c], j <- [1, 2], do: {i, j}
```

#### Bitstring generator

```elixir
pixels = <<213, 45, 132, 64, 76, 32, 76, 0, 0, 234, 32, 15>>
for <<r::8, g::8, b::8 <- pixels>>, do: {r, g, b}
[{213, 45, 132}, {64, 76, 32}, {76, 0, 0}, {234, 32, 15}]
```

### Filters

```elixir
values = [good: 1, good: 2, bad: 3, good: 4]
for {:good, n} <- values, do: n*n
for n <- 0..10, rem(n, 3) == 0, do: n*n
```

<div id="section19"></div>

## Sigils 

Sigils provide the foundation for extending the language with custom textual representations.

### Calendar Sigils

```elixir
# %Date{}
d = ~D[2019-10-31]
d.day
# %Time{}
t = ~T[23:00:07.0]
t.second
# %NaiveDateTime{}
ndt = ~N[2019-10-31 23:00:07]
# %DateTime{}
dt = ~U[2019-10-31 19:59:03Z]
```

<div id="section20"></div>

## try, catch, and rescue

### Errors (exceptions)
```elixir
raise "oops"
raise ArgumentError, message: "invalid argument foo"
```

```elixir
defmodule MyError do
  defexception message: "default message"
end
# raise MyError
# raise MyError, message: "custom message"
```

```elixir
try do
  raise "oops"
rescue
  e in RuntimeError -> e
end
# %RuntimeError{message: "oops"}
```

```elixir
try do
  raise "oops"
rescue
  RuntimeError -> "Error!"
end
# "Error!"
```

### Throws
```elixir
try do
  Enum.each(-50..50, fn x ->
    if rem(x, 13) == 0, do: throw(x)
  end)
  "Got nothing"
catch
  x -> "Got #{x}"
end
```

### Exits
```elixir
try do
  exit("I am exiting")
catch
  :exit, _ -> "not really"
end
```

### After
```elixir
{:ok, file} = File.open("sample", [:utf8, :write])
try do
  IO.write(file, "olá")
  raise "oops, something went wrong"
after
  File.close(file)
end
```

```elixir
defmodule RunAfter do
  def without_even_trying do
    raise "oops"
  after
    IO.puts "cleaning up!"
  end
end
RunAfter.without_even_trying
```

### Else
```elixir
x = 2
# 2
try do
  1 / x
rescue
  ArithmeticError ->
    :infinity
else
  y when y < 1 and y > -1 ->
    :small
  _ ->
    :large
end
# :small
```

<div id="section21"></div>

## Writing documentation

Important statements `@moduledoc`, `@doc`, `@deprecated`

```elixir
defmodule MyApp.Hello do
  @moduledoc """
  This is the Hello module.
  """
  @moduledoc since: "1.0.0"

  @doc """
  Says hello to the given `name`

  Returns `:ok`.

  ## Examples

    iex> MyApp.Hello.world(:john)
    :ok
  """
  @doc since: "1.3.0"
  def world(name) do
    IO.puts("hello #{name}")
  end
end

```

<div id="section22"></div>

## Optional syntax sheet

```elixir
if true, do: :this, else: :that
```

<div id="section23"></div>

## Erlang libraries

```elixir
String.first("Hello")
:math
:binary
:crypto
:digraph
:ets
:queue
:rand
:zip
```

<div id="section24"></div>

## Debugging 

`IO.inspect()`

```elixir
(1..10)
|> IO.inspect()
|> Enum.map(fn x -> x * 2 end)
|> IO.inspect()
|> Enum.sum()
|> IO.inspect()
```

```elixir
[1, 2, 3]
|> IO.inspect(label: "before")
|> Enum.map(&(&1 * 2))
|> IO.inspect(label: "after")
|> Enum.sum
```
