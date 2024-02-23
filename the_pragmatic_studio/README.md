# 1.- Previous

```bash
docker run -it -v /home/ec2-user/environment/elixir_introduction:/app/data --rm elixir bash
docker run -it --rm elixir bash
sudo chown -R ec2-user ~/environment
```

```elixir
defmodule Servy do
    def handle(request) do
        request
        |> parse()
        |> rewrite_path()
        |> log()
        |> route()
        |> track()
        |> response()
    end
end
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

New function using pattern matching
```elixir
  @doc"""
  Documentation for parse
  """
  def parse(request) do
    # TODO: Parse the request string into a map
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: method, path: path, resp_body: ""}
  end
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

One line function

```elixir
def log(conv), do: IO.inspect conv
```

instead of

```elixir
def log(conv) do
    IO.inspect conv
end
```

if-else statement

```elixir
if conv.path == "/wildthings" do
    %{ conv | resp_body: "Bears, Lions, Tigers"}
else
    %{ conv | resp_body: "Teddy, Smokey, Paddington"}
end
```

Good way to avoid if-else (instead of use that stament you can redirect the flux)

```elixir
    def log(conv), do: IO.inspect conv
    
    def route(conv) do
        route(conv, conv.method, conv.path)
    end
    
    def route(conv, "GET", "/wildthings") do
        %{ conv | resp_body: "Bears, Lions, Tigers"}
    end
    
    def route(conv, "GET", "/bears") do
        %{ conv | resp_body: "Teddy, Smokey, Paddington"}
    end
```

## 7.- Advanced pattern matching

If you need a private function you need to name it as *defp* instead of *def*.

In the next code I have a complex function using parameter interpolation, private functions
and parameter matching:
```elixir
defmodule Servy.Handler do
    def handle(request) do
        request
        |> parse
        |> log
        |> route
        |> format_response
    end
    
    def parse(request) do
        [method, path, _] = 
            request 
            |> String.split("\n") 
            |> List.first 
            |> String.split(" ")
        %{ method: method, 
        path: path, 
        resp_body: "",
        status: nil
        }
    end
    
    def log(conv), do: IO.inspect conv
    
    def route(conv) do
        route(conv, conv.method, conv.path)
    end
    
    def route(conv, "GET", "/wildthings") do
        %{ conv | status: 200, resp_body: "Bears, Lions, Tigers"}
    end
    
    def route(conv, "GET", "/bears") do
        %{ conv | status: 200, resp_body: "Teddy, Smokey, Paddington"}
    end
    
    def route(conv, "GET", "/bears/" <> id) do
        %{ conv | status: 200, resp_body: "Bear #{id}"}
    end
    
    def route(conv, _method, path) do
        %{conv | status: 404, resp_body: "No #{path} here!"}
    end
    
    def format_response(conv) do
        """
        HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
        Content-Type: text/html
        Content-Length: #{String.length(conv.resp_body)}

        #{conv.resp_body}
        """
    end
    
    defp status_reason(code) do
        %{
            200 => "OK",
            201 => "Created",
            401 => "Unauthorized",
            403 => "Forbidden",
            404 => "Not Found",
            500 => "Internal Server Error"
        }[code]
    end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Servy.Handler.handle(request)
IO.puts response

request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response

request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response

request = """
GET /bears/1/long/path HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response
```

## 8.- Pattern matching maps

```elixir
conv = %{ method: "GET", path: "/wildlife"}
%{ path: "/wildlife"} = conv
%{ method: method, path: "/wildlife"} = conv
%{ method: method, path: path} = conv
```

But we can reasign a path with a given path
```elixir
def rewrite_path(%{ path: "/wildlife" } = conv) do
    %{ conv | path: "/wildthings"}
end
    
def rewrite_path(conv), do: conv
```

Now our function is:
```elixir
defmodule Servy.Handler do
    def handle(request) do
        request
        |> parse
        |> rewrite_path
        |> log
        |> route
        |> track
        |> format_response
    end
    
    def parse(request) do
        [method, path, _] = 
            request 
            |> String.split("\n") 
            |> List.first 
            |> String.split(" ")
        %{ method: method, 
        path: path, 
        resp_body: "",
        status: nil
        }
    end
    
    def rewrite_path(%{ path: "/wildlife" } = conv) do
        %{ conv | path: "/wildthings"}
    end
    
    def rewrite_path(conv), do: conv
    
    def log(conv), do: IO.inspect conv
    
    def route(%{ method: "GET", path: "/wildthings"} = conv) do
        %{ conv | status: 200, resp_body: "Bears, Lions, Tigers"}
    end
    
    def route(%{ method: "GET", path: "/bears"} = conv) do
        %{ conv | status: 200, resp_body: "Teddy, Smokey, Paddington"}
    end
    
    def route(%{ method: "GET", path: "/bears/" <> id} = conv) do
        %{ conv | status: 200, resp_body: "Bear #{id}"}
    end
    
    def route(%{ path: path} = conv) do
        %{conv | status: 404, resp_body: "No #{path} here!"}
    end
    
    def track(%{ status: 404, path: path} = conv) do
        IO.puts "Warning: #{path} is on the loose!"
        conv
    end
    
    def track(conv), do: conv
    
    def format_response(conv) do
        """
        HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
        Content-Type: text/html
        Content-Length: #{String.length(conv.resp_body)}

        #{conv.resp_body}
        """
    end
    
    defp status_reason(code) do
        %{
            200 => "OK",
            201 => "Created",
            401 => "Unauthorized",
            403 => "Forbidden",
            404 => "Not Found",
            500 => "Internal Server Error"
        }[code]
    end
end
```

## 9.- Serving Files

```elixir
h File.read/1
{:ok, contents } = File.read("pages/about.html")
contents
{:error, reason} = File.read("pages/about_us.html")
reason
```

Case example
```elixir
case <evaluation> do
    <case_1> -> <do_that>
    <case_2> -> <do_that>
    <case_3> -> <do_that>
end
```

Correct way to read the file using one dot

```elixir
    def route(%{ method: "GET", path: "/about"} = conv) do
        case File.read("././pages/about.html") do
            {:ok, content} -> 
                %{ conv | status: 200, resp_body: content}
            {:error, :enoent} -> 
                %{ conv | status: 404, resp_body: "File not found!"}
            {:error, reason} -> 
                %{ conv | status: 500, resp_body: "File error: #{reason}"}
        end
    end
```

Other correct way to read files using absolut path

```elixir
    def route(%{ method: "GET", path: "/about"} = conv) do
        file =
            Path.expand("../../pages", __DIR__)
            |> Path.join("about.html")
        case File.read(file) do
            {:ok, content} -> 
                %{ conv | status: 200, resp_body: content}
            {:error, :enoent} -> 
                %{ conv | status: 404, resp_body: "File not found!"}
            {:error, reason} -> 
                %{ conv | status: 500, resp_body: "File error: #{reason}"}
        end
    end
```

Multiclass functions

```elixir
    def route(%{ method: "GET", path: "/about"} = conv) do
        Path.expand("../../pages", __DIR__)
        |> Path.join("about.html")
        |> File.read
        |> handle_file(conv)
        
    end
    
    def handle_file({:ok, content}, conv) do
        %{ conv | status: 200, resp_body: content}
    end
    
    def handle_file({:error, :enoent}, conv) do
        %{ conv | status: 404, resp_body: "File not found!"}
    end
    
    def handle_file({:error, reason}, conv) do
        %{ conv | status: 500, resp_body: "File error: #{reason}"}
    end
```

## 10.- Module Attributes

Modules attributes for documents and constants

```elixir
@moduledoc "Handles HTTP request."

@pages_path Path.expand("../../pages", __DIR__)

@doc "Transform the request into a response."
```

## 11.- Organizing Code

Using only module separation

```elixir
defmodule Replica.Plugins do

    def rewrite_path(%{ path: "/wildlife"} = conv) do
        %{ conv | path: "/wildthings" }
    end
    
    def rewrite_path(conv), do: conv
    
    def log(conv), do: IO.inspect conv
    
    def track(%{ status: 404 } = conv) do
        IO.puts "Warning: #{conv.path} is on the loose!"
        conv
    end
    
    def track(conv), do: conv
    
end 

defmodule Replica.Handler do
    @moduledoc "Handles HTTP requests."
    
    @pages_path Path.expand("../../pages", __DIR__)
    
    @doc "Transform the request into a response."
    def handle(request) do
        request
        |> parse()
        |> Replica.Plugins.rewrite_path()
        |> Replica.Plugins.log()
        |> route()
        |> Replica.Plugins.track()
        |> format_response()
    end
end
```

Importing modules

```elixir
    import Replica.Plugins, only: [rewrite_path:1, log:1, track:1]
    
    @doc "Transform the request into a response."
    def handle(request) do
        request
        |> parse()
        |> rewrite_path()
        |> log()
        |> route()
        |> track()
        |> format_response()
    end
```

```elixir
defmodule Replica.Parser do
    def parse(request) do
        # TODO: Parse the request string into a map
        [method, path, _] = 
            request
            |> String.split("\n")
            |> List.first()
            |> String.split(" ")
        
        %{ method: method, 
            path: path, 
            resp_body: "",
            status: nil
        }
    end
end
```

```elixir
iex -S mix
r Replica.Handler
recompile
```

## 12.- Modeling with structs

We can define a struct and we can use it to generate a structure like a map
```elixir
defmodule Replica.Conv do
    defstruct [ method: "", path: "", resp_body: "", status: nil ]
end
```

Structs are a Map, but Map is not a struct

```elixir
iex -S mix
map = %{}
conv = %Replica.Conv{}
conv = %Replica.Conv{ method: "GET", path: "/bears" }
conv.method
conv.path
conv[:age] # error
conv = %{ conv | status: 200 }
%Replica.Conv{ method: method } = conv
method
is_map(conv) # true
```

Working directly
```elixir
defmodule Replica.Parser do
    def parse(request) do
        # TODO: Parse the request string into a map
        [method, path, _] = 
            request
            |> String.split("\n")
            |> List.first()
            |> String.split(" ")
        
        %Replica.Conv{ 
            method: method, 
            path: path
        }
    end
end
```

Working with alias
```elixir
defmodule Replica.Parser do

    alias Replica.Conv, as: Conv
    
    def parse(request) do
        # TODO: Parse the request string into a map
        [method, path, _] = 
            request
            |> String.split("\n")
            |> List.first()
            |> String.split(" ")
        
        %{ 
            method: method, 
            path: path
        }
    end
end
```

We can ensure that you get a struct with the Conv struct

```elixir
defmodule Replica.Plugins do

    alias Replica.Conv

    def rewrite_path(%Conv{ path: "/wildlife"} = conv) do
        %{ conv | path: "/wildthings" }
    end
    
    def rewrite_path(%Conv{} = conv), do: conv
    
    def log(conv), do: IO.inspect conv
    
    def track(%Conv{ status: 404, path: path } = conv) do
        IO.puts "Warning: #{path} is on the loose!"
        conv
    end
    
    def track(%Conv{} = conv), do: conv
    
end 
```

## 13.- Matching Heads and Tails

Remember this useful operation
```elixir
URI.decode_query("name=Baloo&type=Brown")
```

and we will use the [heads | tails] pattern:
```elixir
[heads | tails] = [1, 2, 3, 4, 5, 6]
```

## 14.- Recursion

Example of recursion
```elixir
defmodule Recurse do
    def loopy([head | tail]) do
        IO.puts "Head #{head} and Tail #{inspect(tail)}"
        loopy(tail)
    end
    
    def loopy([]), do: IO.puts "Done!"
end

Recurse.loopy([1, 2, 3, 4, 5])
Recurse.loopy([])

defmodule Factorial do
    def fun(0), do: 1
    def fun(n) when is_integer(n) and n > 0 do
        n*fun(n-1)
    end
    def fun(arg), do: "Invalid argument: #{inspect(arg)}"
end

IO.puts Factorial.fun(500)
IO.puts Factorial.fun("500")
IO.puts Factorial.fun(%{ method: "POST"})
```

## 15.- Slicing and dicing with Enum - Part 1
```elixir
```

## 15.- Slicing and dicing with Enum - Part 2
```elixir
```

## 16.- Comprehensions
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