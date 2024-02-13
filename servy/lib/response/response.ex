defmodule Servy.Response do
    def handle(request) do
        request
        # get method and path
        # renamed non existing path
        # log
        # get status code
        # get response body
        # final response
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