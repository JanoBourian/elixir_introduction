# elixir_introduction
A repository to work with elixir in a high level

# Install using docker

Link to know more about how we can work using docker + elixir

https://elixir-lang.org/install.html#docker

```bash
docker run -it --rm elixir
docker run -it --rm elixir bash
```

# Documentation

Official documentation: https://hexdocs.pm/elixir/1.16/introduction.html

# First steps

When you are in console mode and you want into elixir console:

```bash
iex
```

```bash
docker run -it -v /home/ec2-user/environment/elixir_introduction:/app/data --rm elixir bash
sudo chown -R ec2-user ~/environment/elixir_introduction
```
When you are using a volume the volume information is in _app/data_

## First codes

```elixir
40 + 20
"hello" <> " world"
```

## Project

```bash
mix new servy
mix help
```

## Magic

To compile all the project and use its functionalities inside the elixir's cls

```bash
iex -S mix
```

To recompile certain files (r + module name)

```bash
r Servy
```

# Key concepts

## Module and function structure

```elixir
defmodule Rabbit do

    def say_hello(name) do
        IO.puts("Hello #{name}")
    end

    def say_name(name), do: IO.inspect(name)

    defp private_information do
        IO.puts("Private information")
    end
end
```

## Pattern Matching

```elixir
defmodule Rabbit do

    def decode_information(information) do
        [name, age, _]  =
            information
            |> String.split("\n")
            |> List.first
            |> String.split(" ")
    end
end
```

## Function Clauses

```elixir
defmodule Rabbit do

    def start(request) do
        request
        |> parse
    end

    def parse(request), do: parse(request, request.method, request.path)

    def parse(request, "GET", "/"), do: IO.inspect(request)

    def parse(request, "POST", "/"), do: IO.inspect(request)

    def parse(request, method, "/" <> path), do: IO.puts("Method #{method} not available in #{path} path!")

end
```

## Pattern matching maps

```elixir
defmodule Rabbit do

    def start(request) do
        request
        |> parse
    end

    def parse(request), do: parse(request, request.method, request.path)

    def parse(%{method: "GET", path: "/"} = request), do: IO.inspect(request)

    def parse(%{method: "POST", path: "/"} = request), do: IO.inspect(request)

    def parse(%{method: method, path: "/" <> path} = request), do: IO.puts("Method #{method} not available in #{path} path!")

end

```

## Serving files

```elixir
# Tuples
{:ok, binary}
{:error, reason}
```

```elixir
iex
h File.read
h Path.expand
h Path.join
```

## Module attributes

Module docs, functions docs and constants

```elixir
defmodule Rabbit do
    @moduledoc "Handles HTTP requests."

    @pages_path Path.expand("../../pages", __DIR__)

    @doc "Transform the request into a response."
    def function(information) do
        IO.puts(information)
    end

    @doc "IO puts a constant"
    def print_constant do
        IO.puts(@pages_path)
    end
end
```
## Modeling with structs

How to define a struct

```elixir
defmodule Rabbit.Conv do
  defstruct method: "", path: "", resp_body: "", status: nil
end
```

How to use and update a struct
```elixir
conv = %Rabbit.Conv{}
conv = %Rabbit.Conv{method: "GET", path: "/bears"}
conv = %{ conv | status: 200}
```

Alias
```elixir
alias Rabbit.Conv, as: Conv
# But you can use the last part of the module
alias Rabbit.Conv # Conv
```

## Matching Heads and Tails

```elixir
[head | tail] = [1, 2, 3, 4, 5]
head
tail
```

## Recursion

Recursion example

```elixir
defmodule Recursion do
  def loopy([head | tail]) do
    IO.puts("Head #{head} Tail: #{inspect(tail)}")
    loopy(tail)
  end

  def loopy([]), do: IO.puts("Done")
end

Recursion.loopy([1, 2, 3, 4, 5])

```

## Slicing and dicing, Enum module

Enum module

```elixir
h Enum
# each
# filter
# find
# map
# reduce
# reject
Rabbit.Wildthings.list_bears()
Enum.map(bears, fn(bear) -> bear end)
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