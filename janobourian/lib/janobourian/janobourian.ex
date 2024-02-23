defmodule Janobourian.Handler do
  @moduledoc """
  Documentation for Janobourian.Handler
  """

  @doc"""
  Documentation for handler function
  """
  def handle(request) do
    request
    |> parse()
    |> route()
    |> format()
  end

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

    %{
      method: method,
      path: path,
      resp_body: "",
      status: nil
    }
  end

  @doc"""
  Documentation for route
  """
  def route(conv) do
    # TODO: Create a new map that also has the response body
    %{ conv | resp_body: "Bears, Lions, Tigers"}
  end

  @doc"""
  Documentaion for format
  """
  def format(conv) do
    # TODO: Use values in the map to create an HTTP response string
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    Bears, Lions, Tigers
    """
  end

end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
IO.puts Janobourian.Handler.handle(request)
