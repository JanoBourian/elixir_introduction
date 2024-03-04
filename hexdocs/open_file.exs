{_, content} =
  Path.expand("", __DIR__)
  |> Path.join("simple.exs")
  |> File.read()

  IO.puts(content)
