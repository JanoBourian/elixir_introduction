defmodule Janobourian.Handler do
  @moduledoc """
  Documentation for Janobourian.Handler
  """
  @pages_path Path.expand("../../pages", __DIR__)
  @about_html "about.html"

  import Janobourian.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Janobourian.Parser, only: [parse: 1]

  alias Janobourian.BearController
  alias Janobourian.Conv

  @doc"""
  Documentation for handler function
  """
  def handle(request) do
    request
    |> parse()
    |> rewrite_path()
    |> log()
    |> route()
    |> track()
    |> format()
  end

  def route(%Conv{ method: "GET", path: "/kaboom" } = conv) do
    raise "Kaboom!"
  end

  def route(%Conv{ method: "GET", path: "/hibernate/" <> time} = conv) do
    time
      |> String.to_integer()
      |> :timer.sleep()

    %{ conv | status: 200, resp_body: "Awake!" }
  end

  def route(%Conv{ method: "GET", path: "/about"} = conv) do
    @pages_path
    |> Path.join(@about_html)
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{ method: "GET", path: "/wildthings"} = conv) do
    %{ conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%Conv{ method: "POST", path: "/bears"} = conv) do
    BearController.create(conv, conv.params)
  end

  def route(%Conv{ method: "GET", path: "/api/bears"} = conv) do
    Janobourian.Api.BearController.index(conv)
  end

  def route(%Conv{ method: "GET", path: "/bears"} = conv) do
    IO.inspect conv
    BearController.index(conv)
  end

  def route(%Conv{ method: "GET", path: "/bears/" <> id} = conv) do
    params = Map.put(conv.params, "id", id)
    BearController.show(conv, params)
  end

  def route(%Conv{ path: path} = conv) do
    %{ conv | status: 404, resp_body: "No #{path} here!"}
  end

  @doc"""
  Documentaion for format
  """
  def format(%Conv{} = conv) do
    # TODO: Use values in the map to create an HTTP response string
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: #{conv.response_content_type}
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

  defp handle_file({ :ok, content}, conv) do
    %{ conv | status: 200, resp_body: content}
  end

  defp handle_file({ :error, :enoent}, conv) do
    %{ conv | status: 404, resp_body: "File not found"}
  end

  defp handle_file({ :error, reason}, conv) do
    %{ conv | status: 500, resp_body: "File error: #{reason}"}
  end

end

request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
IO.puts Janobourian.Handler.handle(request)

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
IO.puts Janobourian.Handler.handle(request)

request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
IO.puts Janobourian.Handler.handle(request)

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
IO.puts Janobourian.Handler.handle(request)

request = """
GET /wildlife HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
IO.puts Janobourian.Handler.handle(request)

request = """
GET /unprocessable HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
IO.puts Janobourian.Handler.handle(request)

request = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
IO.puts Janobourian.Handler.handle(request)

request= """
POST /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded

name=Teddy&type=Brown
"""
IO.puts Janobourian.Handler.handle(request)

request = """
POST /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

name=Baloo&type=Brown
"""
IO.puts Janobourian.Handler.handle(request)

request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
IO.puts Janobourian.Handler.handle(request)

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
IO.puts Janobourian.Handler.handle(request)
