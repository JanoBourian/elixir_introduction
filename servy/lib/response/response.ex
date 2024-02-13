defmodule Servy.Response do
    def handle(request) do
        request
        # get method and path
        |> parse
        # renamed non existing path
        |> rewrite_path
        # log
        |> log
        # get status code
        |> get_status
        # get response body
        |> get_body
        # final response
        |> format
    end
    
    def parse(request) do
        conv = %{ method: "GET", 
        path: "/path", 
        response_body: "", 
        status_code: nil}
    end
    
    def rewrite_path(conv) do
        conv = %{ method: "GET", 
        path: "/valid_path", 
        response_body: "", 
        status_code: nil}
    end
    
    def log(conv) do
        IO.inspect conv
    end
    
    def get_status(conv) do
        conv = %{conv | status_code: 200}
    end
    
    def get_body(conv) do
        conv = %{conv | response_body: "Hello"}
    end
    
    def format(conv) do
        """
        HTTP/1.1 200 OK
        Content-Type: text/html
        Content-Length: 25

        Here is the response body
        """
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