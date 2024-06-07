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


```elixir
```


```elixir
```


```elixir
```


```elixir
```