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

  test "GET /bigfoot" do
    # Request for bigfoot
    request = """
    GET /bigfoot HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = handle(request)

    assert response == """
    HTTP/1.1 404 Not Found
    Content-Type: text/html
    Content-Length: 17

    No /bigfoot here!
    """
  end

  test "GET /bears/1" do
    # Request for bears with id
    request = """
    GET /bears/1 HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = handle(request)

    assert response == """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 86

    <h1> Show Teddy - Brown </h1>
    <p>
        Is Teddy hibernating? <strong>true</strong>
    </p>
    """

  end

  test "GET /wildlife" do
    # Request for /wildlife
    request = """
    GET /wildlife HTTP/1.1
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

  test "POST /bears" do
    # POST request for head and tails
    request = """
    POST /bears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*
    Content-Type: application/x-www-form-urlencoded
    Content-Length: 21

    name=Baloo&type=Brown
    """

    response = handle(request)

    assert response == """
    HTTP/1.1 201 Created
    Content-Type: text/html
    Content-Length: 32

    Create a Brown bear named Baloo!
    """

  end

  defp remove_whitespace(text) do
    String.replace(text, ~r{\s}, "")
  end
end
