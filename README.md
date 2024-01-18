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