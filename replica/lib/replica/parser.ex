defmodule Replica.Parser do

    alias Replica.Conv, as: Conv
    
    def parse(request) do
        # TODO: Parse the request string into a map
        [top, params_string] = 
            request
            |> String.split("\n\n")
        
        [request_line | header_lines] =
            top 
            |> String.split("\n")
        
        [method, path, _] = 
            request_line
            |> String.split(" ")
        
        headers = parse_headers(header_lines, %{})
        params = parse_params(headers["Content-Type"], params_string)
        
        %Conv{ 
            method: method, 
            path: path,
            params: params,
            headers: headers
        }
    end
    
    defp parse_params("application/x-www-form-urlencoded", params_string) do
        params_string
        |> String.trim
        |> URI.decode_query()
    end
    
    defp parse_params(_, _), do: %{}
    
    defp parse_headers([head | tail], headers) do
        [key, value] = 
            head
            |> String.split(": ")
        headers = Map.put(headers, key, value)
        parse_headers(tail, headers)
    end
    
    defp parse_headers([], headers), do: headers
end