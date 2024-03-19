# MIX & OTP

## Index

- [Introduction to Mix](#section1)
- [Simple state management with agents](#section2)
- [Client-server communication with GenServer](#section3)
- [Supervision trees and applications](#section4)
- [Supervising dynamic children](#section5)
- [Speeding up with ETS](#section6)
- [Dependencies and umbrella projects](#section7)
- [Task and gen_tcp](#section8)
- [Doctests, patterns, and with](#section9)
- [Distributed tasks and tags](#section10)
- [Configuration and releases](#section11)


<div id="section1"></div>

## Introduction to Mix

Code for this project: https://github.com/josevalim/kv_umbrella

```bash
mix new kv --module KV
cd kv
mix compile
mix test
mix format
iex -S mix
set "MIX_ENV=prod" && mix compile
```

<div id="section2"></div>

## Simple state management with agents

* `Agents`: Simple wrappers around state.
* `GenServer`: Generic Server that encapsulate state, provide sync and async calls, support code reloading, and more.
* `Task`: Asynchronous units of computation that allow spawning a process and potentially retrieving its result at a later time.

Key functions `send/2`, `receive/1`, `spawn/1`, and `Process.link/1`. 

First approach to Agents:

```elixir
{:ok, agent} = Agent.start_link(fn -> [] end)
Agent.update(agent, fn list -> ["eggs" | list] end)
Agent.get(agent, fn list -> list end)
Agent.stop(agent)
```

Another approach:

```elixir 
{:ok, agent} = Agent.start_link(fn -> [] end)
Agent.update(agent, fn _list -> 123 end)
Agent.get(agent, fn list -> list end)
Agent.update(agent, fn _list -> "This replace all information" end)
Agent.get(agent, fn list -> list end)
Agent.update(agent, fn content -> [content] end)
Agent.get(agent, fn list -> list end)
Agent.update(agent, fn content -> ["123" | content] end)
Agent.get(agent, fn list -> list end)
```

Operations inside `KV.Bucket` module

```elixir
{:ok, bucket} = Agent.start_link(fn -> %{} end)
Agent.get(bucket, &Map.get(&1, "milk"))
Agent.update(bucket, &Map.put(&1, "milk", 3))
Agent.get_and_update(bucket, &Map.pop(&1, "milk"))
```

Remember: 

```elixir
Agent.get(bucket, &Map.get(&1, key)) 
# Agent.get(bucket, fn dict -> Map.get(dict, key))
```

First way of our test (without callbacks)

```elixir
defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  test "stores values by key" do
    {:ok, bucket} = KV.Bucket.start_link([])
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3

    KV.Bucket.delete(bucket, "milk")
    assert KV.Bucket.get(bucket, "milk") == nil
  end
end

```

<div id="section3"></div>

## Client-server communication with GenServer

We can name a process

```elixir
Agent.start_link(fn -> %{} end, name: :shopping)
KV.Bucket.put(:shopping, "milk", 1)
KV.Bucket.get(:shopping, "milk")
```

<div id="section4"></div>

```elixir
```

<div id="section5"></div>

```elixir
```

<div id="section6"></div>

```elixir
```

<div id="section7"></div>

```elixir
```

<div id="section8"></div>

```elixir
```

<div id="section9"></div>

```elixir
```

<div id="section10"></div>

```elixir
```

<div id="section11"></div>

```elixir
```

