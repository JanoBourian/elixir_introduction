defmodule Rabbit.Handler do
  @moduledoc "Handles HTTP requests."

  alias Rabbit.Conv
  alias Rabbit.BearController

  @pages_path Path.expand("../../pages", __DIR__)

  import Rabbit.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Rabbit.Parser, only: [parse: 1]

  @doc "Transform the request into a response."
  def handle(request) do
     request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
    |> format_response
  end

  def handle_file({:ok, content}, %Conv{} = conv) do
    %{conv | status: 200, resp_body: content}
  end

  def handle_file({:error, :enoent}, %Conv{} = conv) do
    %{conv | status: 400, resp_body: "File not found"}
  end

  def handle_file({:error, reason}, %Conv{} = conv) do
    %{conv | status: 500, resp_body: "File error #{reason}"}
  end

  def route(%Conv{method: "GET", path: "/about"} = conv) do
    @pages_path
    |> Path.join("about.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{method: "GET", path: "/wildthings"} = conv) do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%Conv{method: "GET", path: "/bears"} = conv) do
    BearController.index(conv)
  end

  def route(%Conv{method: "GET", path: "/bears/" <> id} = conv) do
    params = Map.put(conv.params, "id", id)
    BearController.show(conv, params)
  end

  # name=Baloo&type=Brown
  def route(%Conv{method: "POST", path: "/bears"} = conv) do
    BearController.create(conv, conv.params)
  end

  def route(%Conv{path: path} = conv) do
    %{conv | status: 404, resp_body: "No #{path} here!"}
  end

  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end

end

# First request
request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Rabbit.Handler.handle(request)

IO.puts(response)

# Request with bears
request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Rabbit.Handler.handle(request)

IO.puts(response)

# Request for bigfoot
request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Rabbit.Handler.handle(request)

IO.puts(response)

# Request for bears with id
request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Rabbit.Handler.handle(request)

IO.puts(response)

# Request for bears with long path after bears
request = """
GET /bears/long-path HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Rabbit.Handler.handle(request)

IO.puts(response)

# Request for /wildlife
request = """
GET /wildlife HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Rabbit.Handler.handle(request)

IO.puts(response)


# Request for /about
request = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Rabbit.Handler.handle(request)

IO.puts(response)

# POST request for head and tails
request = """
POST /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

name=Baloo&type=Brown
"""


response = Rabbit.Handler.handle(request)

IO.puts(response)
