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
        first_line = request |> String.split("\n") |> List.first
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