defmodule Rabbit.Parser do
  @moduledoc """
    Parse HTTP request
  """

  alias Rabbit.Conv

  def parse(request) do
    [top, params_string] =
      request
      |> String.split("\r\n\r\n")

    [request_line | header_lines] =
      top
      |> String.split("\n")

    [method, path, _] =
      request_line
      |> String.split(" ")

    headers = parse_headers(header_lines, %{})

    IO.puts(inspect(headers["Content-Type"]))

    params = parse_params(headers["Content-Type"], params_string)

    %Conv{
      method: method,
      path: path,
      params: params,
      headers: headers}
  end

  def parse_headers([head | tail], headers) do
    [key, value] =
      head
      |> String.split(": ")

    headers = Map.put(headers, key, value)
    parse_headers(tail, headers)
  end

  def parse_headers([], headers), do: headers

  @doc """
  Parses the given para string of the form `key1=value1&key2=value2`
  into a map with corresponding keys and values

  ## Examples
      iex> params_string = "name=Baloo&type=Brown"
      iex> Rabbit.Parser.parse_params("application/x-www-form-urlencoded\r", params_string)
      %{"name" => "Baloo", "type" => "Brown"}
      iex> Rabbit.Parser.parse_params("multipart/form-data\r", params_string)
      %{}
  """
  def parse_params("application/x-www-form-urlencoded\r", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

  def parse_params(_, _), do: %{}

end
