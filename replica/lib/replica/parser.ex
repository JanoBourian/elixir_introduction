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
        
        params = parse_params(params_string)
        
        %Conv{ 
            method: method, 
            path: path,
            params: params
        }
    end
    
    defp parse_params(params_string) do
        params_string
        |> String.trim
        |> URI.decode_query()
    end
end