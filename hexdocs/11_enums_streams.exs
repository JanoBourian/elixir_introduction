IO.puts Enum.map([1, 2, 3], fn x -> x* 2 end)
IO.puts Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k*v end)
IO.puts Enum.map(1..3, fn x -> x*2 end)
IO.puts Enum.reduce(1..3, 0, &+/2)

odd? = fn x -> rem(x, 2) != 0 end
1..13 |> Enum.filter(odd?) |> Enum.sum()

stream = Stream.cycle([1, 2, 3])
Enum.take(stream, 10)
