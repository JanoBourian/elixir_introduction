## Data Types

defmodule DataTypes do
  def data_types do
    # Atoms
    {:ok, _} =
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
