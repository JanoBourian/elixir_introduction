defmodule ParserTest do
  use ExUnit.Case
  doctest Rabbit.Parser

  alias Rabbit.Parser

  test "parses a list of headers fields into a map" do
    headers_lines = ["A: 1", "B: 2"]
    headers = Parser.parse_headers(headers_lines, %{})
    assert headers == %{"A" => "1", "B" => "2"}
  end
end
