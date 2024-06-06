defmodule Rabbit.Handler do
  def handle(request) do
    # conv = parse(request)
    # conv = route(conv)
    # format_response(conv)

    request
    |> parse
    |> log
    |> route
    |> format_response
  end

  def log(conv), do: IO.inspect(conv)

  def parse(request) do
    # TODO: Parse the request string into a map:
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")
    %{ method: method, path: path, resp_body: ""}
  end

  def route(conv) do
    # TODO: Create a new map that also has the response body:
    route(conv, conv.method, conv.path)
  end

  def route(conv, "GET", "/wildthings") do
    %{ conv | resp_body: "Bears, Lions, Tigers"}
  end

  def route(conv, "GET", "/bears") do
    %{ conv | resp_body: "Teddy, Smokey, Paddington"}
  end

  def format_response(conv) do
    # TODO: Use values in the map to create an HTTP response string:
    """
    HTTP/1.1 200 OK
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
