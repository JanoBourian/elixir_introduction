## Data Types

defmodule DataTypes do
  def data_types do
    # Atoms
    {:ok, value} =
      10
      |> check_information()

    # Boolean
    IO.inspect :true
    IO.inspect :false

    # Nule nil
    IO.inspect :nil

    # List
    IO.inspect List.duplicate(2048, 1000) |> Enum.reduce(&(&1*&2))
    head_tail([1, 2, 3, 4, 5, 6, 7])

    # Binaries
    <<head::binary-size(1), tail::binary>> = "Hello"
    IO.puts(head)
    IO.puts(tail)

    # Tuples
    user_data = {"home/user", "data.txt", 120, {{2011, 11, 20}, {0, 0, 0}}}
    IO.inspect(user_data)
    other_user = Kernel.put_elem(user_data, 1, "info.txt")
    IO.inspect(other_user)
    user = Tuple.append(other_user, "new_information")
    IO.inspect(user)
    IO.inspect(Kernel.elem(user, 2))
    final_user = Tuple.delete_at(user, 3)
    IO.inspect(final_user)

    # Maps
    map_value = %{:name => "John"}
    IO.inspect(map_value)
    map_value = %{ map_value | :name => "Max"}
    IO.inspect(map_value)
    map_value = Map.put_new(map_value, :age, 35)
    IO.inspect(map_value)
    map_value = Map.put(map_value, :name, "Maxima")
    IO.inspect(map_value)
    IO.puts(map_value[:name])
    IO.puts(map_value.age)
    IO.puts(Map.get(map_value, :name))
    IO.inspect(Map.keys(map_value))

    # Sets
    set = MapSet.new
    set = MapSet.put(set, "red")
    IO.inspect(set)
    set = MapSet.put(set, "blue")
    IO.inspect(set)

    value

  end

  def head_tail([head | tail]) do
    IO.puts "Value in head is #{head}"
    head_tail(tail)
  end

  def head_tail([]), do: "Done!"

  def check_information(information) when is_number(information), do: {:ok, information}

  def check_information(_), do: {:error, "Error message"}

end

IO.puts(DataTypes.data_types)
