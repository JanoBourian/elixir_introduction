# hexdocs

This is going to be a file to create documentation based on the Elixir official 
documentation. https://hexdocs.pm/elixir/1.16/introduction.html

## API References

Modules https://hexdocs.pm/elixir/1.16.1/api-reference.html#modules

## Installation

```bash
docker run -it -v /home/ec2-user/environment/elixir_introduction/hexdocs:/app/data --rm elixir bash
```

## Introduction

```elixir
"Hello " <> "world!"
IO.puts("Hello world!")
```

Running a script:
```bash
elixir simple.exs
```

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
