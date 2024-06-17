defmodule HandlerTest do
  use ExUnit.Case
  doctest Rabbit.Handler

  import Rabbit.Handler, only: [handle: 1]

  test "GET /wildthings" do
    # First request
    request = """
    GET /wildthings HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = handle(request)

    assert response == """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    Bears, Lions, Tigers
    """
  end

  defp remove_whitespace(text) do
    String.replace(text, ~r{\s}, "")
  end
end
