# hexdocs

This is going to be a file to create documentation based on the Elixir official 
documentation. https://hexdocs.pm/elixir/1.16/introduction.html

## Installation

```bash
docker run -it -v /home/ec2-user/environment/elixir_introduction/hexdocs:/app/data --rm elixir bash
```

## Introduction

```elixir
"Hello " <> "world!"
IO.puts("Hello world!")
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