{:ok, file} = File.open("test_file.txt", [:write])
IO.binwrite(file, "world")
File.close(file)
{:ok, file} = File.read("test_file.txt")
IO.puts(file)

IO.puts Path.join("hello", "world")
IO.puts Path.expand("~/hello")
