defmodule Replica.Handler do
    @moduledoc "Handles HTTP requests."
    
    alias Replica.Conv
    
    @pages_path Path.expand("../../pages", __DIR__)
    
    import Replica.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
    import Replica.Parser, only: [parse: 1]
    
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
    
    def route(%Conv{ method: "GET", path: "/about"} = conv) do
        @pages_path
        |> Path.join("about.html")
        |> File.read()
        |> handle_file(conv)
    end
    
    def route(%Conv{ method: "GET", path: "/wildthings"} = conv) do
        %{ conv | status: 200, resp_body: "Bears, Lions, Tigers" }
    end
    
    def route(%Conv{ method: "POST", path: "/bears"} = conv) do
        %{ conv | status: 200, resp_body: "Created a #{conv.params["type"]} bear named #{conv.params["name"]}"}
    end
    
    def route(%Conv{ method: "GET", path: "/bears"} = conv) do
        %{ conv | status: 200, resp_body: "Teddy, Smokey, Paddington"}
    end
    
    def route(%Conv{ method: "GET", path: "/bears/" <> id} = conv) do
        %{ conv | status: 200, resp_body: "Bear: #{id}"}
    end
    
    def route(%Conv{ method: _method, path: path} = conv) do
        %{ conv | status: 404, resp_body: "No #{path} here!"  }
    end
    
    def format_response(%Conv{} = conv) do
        # TODO: Use values in the map to create an HTTP response string
        """
        HTTP/1.1 #{Conv.full_status(conv)}
        Content-Type: text/html
        Content-Length: #{String.length(conv.resp_body)}
        
        #{conv.resp_body}
        """
    end
    
    defp handle_file({:ok, content}, conv) do
        %{ conv | status: 200, resp_body: content }
    end
    
    defp handle_file({:error, :enoent}, conv) do
        %{ conv | status: 404, resp_body: "File not found!" }
    end
    
    defp handle_file({:error, reason}, conv) do
        %{ conv | status: 500, resp_body: "File error: #{reason}" }
    end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts Replica.Handler.handle(request)

request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts Replica.Handler.handle(request)

request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts Replica.Handler.handle(request)

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts Replica.Handler.handle(request)

request = """
GET /bears/teddy/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts Replica.Handler.handle(request)

request = """
GET /wildlife HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts Replica.Handler.handle(request)

request = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

IO.puts Replica.Handler.handle(request)

request = """
POST /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

name=Baloo&type=Brown
"""

IO.puts Replica.Handler.handle(request)