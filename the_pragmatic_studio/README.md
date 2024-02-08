# 1.- Previous

```bash
docker run -it -v /home/ec2-user/environment/elixir_introduction:/app/data --rm elixir bash
docker run -it --rm elixir bash
sudo chown -R ec2-user ~/environment
```

# 2.- Create Mix Project

Basic steps to create, edit and run an elixir project.

```bash
mix new servy
mix help
cd servy
mix test
```

Information: 

* mix.exs is the configuration file for our dependencies and requirements
* .exs: such as scripts
* .ex: compiled files
* to execute a script 
```bash
elixir lib/servy.ex
```

If you want to have available your scripts in the interactive shell you can code:

```bash
iex -S mix
c "lib/servy.ex"
iex lib/servy.ex
String.reverse("keep")
Servy.hello("Francisco")
Testing.sum_operation(37, 73)
r Servy
h String.split/1
```

3.- High Level Transformation

The convention is to create a new modules inside of _/lib_ with the name of the
project (in this case _/servy_)

```elixir
defmodule Servy.Handler do
    def handle(request) do
        # conv = parse(request)
        # conv = route(conv)
        # format_response(conv)
        
        request 
        |> parse 
        |> route 
        |> format_response
    end
    
    def parse(request) do
        # TODO: Parse the request string into a map
        conv = %{method: "GET", path: "/wildthings", resp_body: ""}
    end
    
    def route(conv) do
        # TODO: Create a new map that also has the response body
        conv = %{method: "GET", path: "/wildthings", resp_body: "Bears, Lions, Tigers"}
    end
    
    def format_response(conv) do
        # TODO: Use values in the map to create an HTTP response string
        """
        HTTP/1.1 200 OK
        Content-Type: text/html
        Content-Length: 20
        
        Bears, Lions, Tigers
        """
    end
end

request = ""
response = Servy.Handler.handle(request)

IO.puts response
```
## 4.- Pattern Matching

```elixir
iex -S mix
h String.split/2
request = Servy.Handler.handle("")
lines = String.split(request, "\n")
h List.first
first_line = Lines.first(lines)
```

h String. + tab to show the functions in String module

```elixir
request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
String.split("1,2,3", ",")
String.split("1,2,3", parts: 2)
String.split("1 2 3", " ", trim:true)
lines = String.split(request, "\n")
first_line = List.first(lines)
first_line = request |> String.split("\n") |> List.first
parts = String.split(first_line, " ")
Enum.at(parts, 0)
```


## 5.- Immutable data

```elixir
conv = %{ method: "GET", path: "/wildthings", resp_body: "Bears, Lions, Tigers"}
conv[:method]
conv[:path]
conv[:resp_body]
conv[:mike]
conv[:resp_body] = "Bear"
h Map.put
new_conv = Map.put(conv, :resp_body, "Bears")
conv = % { conv | resp_body: "Bears, Lions, Tigers"}
String.length(conv.resp_body)
conv.resp_body
```

## 6.- Function clauses

```
```

## 7.- Advanced pattern matching

```
```

## 8.- Pattern matching maps

```
```

## 9.- Serving Files

```
```

## 10.- Module Attributes

```
```

```
```

```
```

```
```