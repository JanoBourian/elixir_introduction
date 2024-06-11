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

  defp parse_headers([head | tail], headers) do
    [key, value] =
      head
      |> String.split(": ")

    headers = Map.put(headers, key, value)
    parse_headers(tail, headers)
  end

  defp parse_headers([], headers), do: headers

  defp parse_params("application/x-www-form-urlencoded\r", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

  defp parse_params(_, _), do: %{}

end
