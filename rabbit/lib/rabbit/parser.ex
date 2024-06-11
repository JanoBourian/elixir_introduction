defmodule Rabbit.Parser do
  @moduledoc """
    Parse HTTP request
  """

  alias Rabbit.Conv

  def parse(request) do
    [top, params_string] =
      request
      |> String.split("\r\n\r\n")

    [request_line | _] =
      top
      |> String.split("\n")

    [method, path, _] =
      request_line
      |> String.split(" ")

    params = parse_params(params_string)

    %Conv{
      method: method,
      path: path,
      params: params}
  end

  defp parse_params(params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

end
