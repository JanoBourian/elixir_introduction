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
  def parse(_request) do
    # TODO: Parse the request string into a map
    conv = %{method: "GET", path: "/wildthings", resp_body: ""}
  end

  @doc"""
  Documentation for route
  """
  def route(_conv) do
    # TODO: Create a new map that also has the response body
    conv = %{method: "GET", path: "/wildthings", resp_body: "Bears, Lions, Tigers"}
  end

  @doc"""
  Documentaion for format
  """
  def format(_conv) do
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
IO.puts Janobourian.Handler.handle(request)
