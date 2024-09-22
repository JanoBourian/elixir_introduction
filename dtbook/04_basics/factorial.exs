defmodule Factorial do
  def factorial(1) do
    1
  end

  def factorial(n) when is_integer(n) and n > 0 do
    n*factorial(n-1)
  end

  def factorial(n) do
    IO.puts("Something was wrong with #{inspect(n)}.")
  end
end

defmodule ElixirTypes do
  def types() do
    # Tuple
    {status, count, action} = {:ok, 200, "next"}
    IO.puts("#{status}-#{count}-#{action}")
    {status, file} = File.open("data.txt")
    IO.puts("#{status}-#{inspect(file)}")

    # List
    list1 = [1, 2, 3]
    list2 = [4, 5, 6]
    IO.puts(inspect(list1 ++ list2))
    IO.puts(inspect(list1 -- list2))
    IO.puts(inspect(list1 in list2))

    # Keyword List
    IO.puts(inspect([name: "Dave", city: "Dallas", likes: "Programming", number: "35"]))

    # Maps
    states = %{"AL" => "Alabama", "WI" => "Wisconsin"}
    IO.puts(inspect(states))
    colors = %{ :red => 0xff0000, :green => 0x00ff00, :blue => 0x0000ff}
    IO.puts(inspect(colors))
    IO.puts(inspect(states["AL"]))
    IO.puts(inspect(states["TX"]))
    IO.puts(inspect(colors.red))

    # Dates and Times
    d1 = Date.new(2023, 09, 21)
    IO.puts(inspect(d1))
    d2 = Time.new(23, 09, 21)
    IO.puts(inspect(d2))

    # With
    with [a|_] <- [1,2,3], do: IO.puts(a)
    with [a|_] <- nil, do: IO.puts(a)
    mean = with(
      count <- 4,
      sum <- 18)
      do
        IO.puts(sum/count)
      end
  end
end

IO.puts(Factorial.factorial(1_000))
IO.puts(inspect(1..100))
ElixirTypes.types()
