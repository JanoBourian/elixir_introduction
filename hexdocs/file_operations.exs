defmodule FileOperations do
  def read_file(path) do
    case File.read(path) do
      {:ok, body} -> "#{inspect body}"
      {:error, reason} -> "Can not open the file #{inspect reason}"
    end
  end
end

IO.puts(FileOperations.read_file("Non"))
IO.puts(FileOperations.read_file("test_file.txt"))
