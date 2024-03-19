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

```elixir
{:ok, agent} = Agent.start_link(fn -> [] end)
Agent.update(agent, fn list -> ["eggs" | list] end)
Agent.get(agent, fn list -> list end)
Agent.stop(agent)
```

```elixir
Agent.get(bucket, &Map.get(&1, key)) 
# Agent.get(bucket, fn dict -> Map.get(dict, key))
```

<div id="section3"></div>

## Client-server communication with GenServer

```elixir
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

