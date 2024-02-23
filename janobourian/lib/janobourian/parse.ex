defmodule Janobourian.Parse do

  @doc"""
  Documentation for parse
  """

  alias Janobourian.Conv

  def parse(request) do
    # TODO: Parse the request string into a map
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %Conv{
      method: method,
      path: path,
      resp_body: "",
      status: nil
    }
  end

end
