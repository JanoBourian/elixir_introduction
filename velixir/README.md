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