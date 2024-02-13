defmodule Servy.Response do
    def handle(request) do
        request
        # get method and path
        |> parse
        # renamed non existing path
        |> rewrite_path
        # log
        |> log
        # Body based on method
        |> get_method
        # final response
        |> format
    end
    
    def parse(request) do
        [method, path, _] =
            request
            |> String.split("\n")
            |> List.first
            |> String.split(" ")
        %{ method: method, 
        path: path, 
        response_body: "", 
        status_code: nil}
    end
    
    def rewrite_path(%{ path: "/dardo"} = conv) do
        conv
    end
    
    def rewrite_path(conv) do
        %{ conv | path: "/forbidden"}
    end
    
    def log(conv) do
        IO.inspect conv
    end
    
    def get_method(%{ method: "GET" } = conv) do
        %{conv | response_body: "GET Method", status_code: 200}
    end
    
    def get_method(%{ method: "POST" } = conv) do
        %{conv | response_body: "POST Method", status_code: 201}
    end
    
    def get_method(conv) do
        %{conv | response_body: "Forbidden", status_code: 403}
    end
    
    
    def format(conv) do
        """
        HTTP/1.1 #{conv.status_code} #{status_reason(conv.status_code)}
        Content-Type: text/html
        Content-Length: #{String.length(conv.response_body)}

        #{conv.response_body}
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
POST /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Response.handle(request)
IO.puts response

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Response.handle(request)
IO.puts response

request = """
PUT /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Response.handle(request)
IO.puts response