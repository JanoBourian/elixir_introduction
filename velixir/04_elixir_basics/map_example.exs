defmodule Mapexample do
    def response(numeric_code) do
        %{ numeric_code => status_code(numeric_code)}
    end
    
    def status_code(numeric_code) do
        %{
            "200" => "OK",
            "201" => "Created",
            "400" => "Bad Request",
            "401" => "Unauthorized",
            "403" => "Forbidden",
            "404" => "Not Found",
            "405" => "Method Not Allowed",
            "500" => "Internal Server Error",
            "501" => "Not implemented",
            "502" => "Bad Gateway",
            "503" => "Service Unavailable",
            "504" => "Gateway Timeout"
        }[numeric_code]
    end
end

IO.inspect Mapexample.response("200")
IO.inspect Mapexample.response("504")
IO.inspect Mapexample.response("203")