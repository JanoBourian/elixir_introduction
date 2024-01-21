# Programming elixir >= 1.6

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
* IEx Helpers
* Customizing iex
* Compile and run
```bash
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