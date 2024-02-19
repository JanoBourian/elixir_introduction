defmodule Sample.Opener do
    def handler(file) do
        File.open(file)
        |> handle_file
    end
    
    def handle_file({:ok, content}) do
        "File could be opened"
    end
    
    def handle_file({:error, reason }) do
        "File could not be opened"
    end
    
end

{status, _} = File.open("mix.exs")
IO.puts(status)

{status, _} = File.open("non-existent-file.exs")
IO.puts(status)

IO.puts Sample.Opener.handler("mix.exs")

IO.puts Sample.Opener.handler("non-existent-file.exs")