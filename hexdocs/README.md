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
- [Modules and functions](#section8)
- [Recursion](#section9)
- [Enumerables and Streams](#section10)
- [Processes](#section11)
- [IO and the file system](#section12)
- [alias, require, and import](#section13)
- [Modules attributes](#section14)
- [Structs](#section15)
- [Protocols](#section16)
- [Comprehensions](#section17)
- [Sigils](#section18)
- [try, catch, and rescue](#section19)
- [Writing documentation](#section20)
- [Optional syntax sheet](#section21)
- [Erlang libraries](#section22)
- [Debugging](#section23)

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

```
```

<div id="section8"></div>

```
```

<div id="section9"></div>

```
```

<div id="section10"></div>

```
```

<div id="section11"></div>

```
```

<div id="section12"></div>

```
```

<div id="section13"></div>

```
```

<div id="section14"></div>

```
```

<div id="section15"></div>

```
```

<div id="section16"></div>

```
```

<div id="section17"></div>

```
```

<div id="section18"></div>

```
```

<div id="section19"></div>

```
```

<div id="section20"></div>

```
```

<div id="section21"></div>

```
```

<div id="section22"></div>

```
```

<div id="section23"></div>

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
