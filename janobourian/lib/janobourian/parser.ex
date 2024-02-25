defmodule Janobourian.Parser do

  @doc"""
  Documentation for parse
  """

  alias Janobourian.Conv

  def parse(request) do

    [top, params_string] =
      request
      |> String.split("\r\n\r\n")

    [request_line | headers_lines] =
      top
      |> String.split("\r\n")

    headers = parse_headers(headers_lines, %{})
    params = parse_params(headers["Content-Type"], params_string)

    # TODO: Parse the request string into a map
    [method, path, _] =
      request_line
      |> String.split(" ")

    %Conv{
      method: method,
      path: path,
      resp_body: "",
      status: nil,
      headers: headers,
      params: params
    }
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
  Parses the given param string of the form `key1=value1&key2=value2`
  into a map with corresponding keys and values

  ## Examples
      iex> params_strings = "key1=value1&key2=value2"
      iex> Janobourian.Parser.parse_params("application/x-www-form-urlencoded", params_strings)
      %{"key1" => "value1", "key2" => "value2"}
      iex> Janobourian.Parser.parse_params("application/x-www-form-urlencoded", "")
      %{}
      iex> Janobourian.Parser.parse_params("", params_strings)
      %{}
  """
  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string
    |> String.trim
    |> URI.decode_query()
  end

  def parse_params(_, _), do: %{}

end
