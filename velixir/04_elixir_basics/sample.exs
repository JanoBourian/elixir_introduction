{status, _} = File.open("mix.exs")
IO.puts(status)

{status, _} = File.open("non-existent-file.exs")
IO.puts(status)