defmodule Rabbit.Parser do

  alias Rabbit.Conv

  def parse(request) do
    # TODO: Parse the request string into a map:
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")
    %Conv{
      method: method,
      path: path}
  end
end
