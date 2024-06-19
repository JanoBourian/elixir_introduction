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
# join
# map
# reduce
# reject
# sort
Rabbit.Wildthings.list_bears()
Enum.map(bears, fn(bear) -> bear end)
```

## Anonymous functions
```elixir
phrases = ["lions", "tigers", "bears", "oh my"]
Enum.map(phrases, fn(x) -> String.upcase(x) end)
Enum.map(phrases, &String.upcase(&1))
```

An example before and after

Before
```elixir
def index(conv) do
    # bears = Wildthings.list_bears()
    items =
      Wildthings.list_bears()
      |> Enum.filter(fn(bear) -> Bear.is_grizzly(bear) end)
      |> Enum.sort(fn(bear1, bear2) -> Bear.order_asc_by_name(bear1, bear2) end)
      |> Enum.map(fn(bear) -> bear_item(bear) end)
      |> Enum.join()

    %{conv | status: 200, resp_body: "<ul>#{items}</ul>" }
  end
```

After
```elixir
def index(conv) do
    # bears = Wildthings.list_bears()
    items =
      Wildthings.list_bears()
      |> Enum.filter(&Bear.is_grizzly(&1))
      |> Enum.sort(&Bear.order_asc_by_name(&1, &2))
      |> Enum.map(&bear_item(&1))
      |> Enum.join()

    %{conv | status: 200, resp_body: "<ul>#{items}</ul>" }
  end
```

But, we have one option more
```elixir
def index(conv) do
    # bears = Wildthings.list_bears()
    items =
      Wildthings.list_bears()
      |> Enum.filter(&Bear.is_grizzly/1)
      |> Enum.sort(&Bear.order_asc_by_name/2)
      |> Enum.map(&bear_item/1)
      |> Enum.join()

    %{conv | status: 200, resp_body: "<ul>#{items}</ul>" }
  end
```

## Comprenhensions | embeded elixir | templates

The extension for embeded elixir templates is __.eex__ and the module to work with templates is __EEx__

```elixir
Enum.map([1, 2, 3], fn(x) -> x*3 end)
for x <- [1, 2, 3], do: x*3
```

## Phoenix Framework

```cmd
mix phx.new maxine
cd maxine
mix phx.gen.html Wildthings Bear bears name:string type:string hibernating:boolean
```

## Test automation

```elixir
# assert 1 + 1 == 2
# refute 2 + 1 == 2
defmodule ParserTest do
  use ExUnit.Case
  doctest Rabbit.Parser

  alias Rabbit.Parser

  test "parses a list of headers fields into a map" do
    headers_lines = ["A: 1", "B: 2"]
    headers = Parser.parse_headers(headers_lines, %{})
    assert headers == %{"A" => "1", "B" => "2"}
  end
end
```

```elixir
@doc """
  Parses the given para string of the form `key1=value1&key2=value2`
  into a map with corresponding keys and values

  ## Examples
      iex> params_string = "name=Baloo&type=Brown"
      iex> Rabbit.Parser.parse_params("application/x-www-form-urlencoded\r", params_string)
      %{"name" => "Baloo", "type" => "Brown"}
      iex> iex> Rabbit.Parser.parse_params("multipart/form-data\r", params_string)
      %{}
  """
  defp parse_params("application/x-www-form-urlencoded\r", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

  defp parse_params(_, _), do: %{}
```

To execute test:

```bash
mix test
```

## Rendering JSON

In mix.exs in dependencies function

```elixir
{:poison, "~> 6.0"}
```

and run

```bash
mix deps
mix deps.get
```

in elixir console

```elixir
bears = Rabbit.Wildthings.list_bears()
Poison.encode!(bears)
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