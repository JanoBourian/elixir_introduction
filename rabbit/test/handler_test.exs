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

  test "GET /about" do
    # Request for /about
    request = """
    GET /about HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = handle(request)

    assert response == """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 341

    <h1> Clark's Wildthings Refuge </h1>

    <blockquote>
        When we contemplate the whole globe as one great dewdrop,
        striped and dotted with continents and islands, flying through
        space with other stars all singing and shining together as one,
        the whole universe appears as an infinite storm of beauty.
        -- John Muir
    </blockquote>
    """
  end

  test "GET /bears" do
    # Request with bears
    request = """
    GET /bears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    result = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 434
    <h1> The Bears </h1>
    <ul>
            <li> Brutus Grizzly </li>
            <li> Iceman Polar </li>
            <li> Kenai Grizzly </li>
            <li> Paddington Brown </li>
            <li> Roscoe Panda </li>
            <li> Rosie Black </li>
            <li> Scarface Grizzly </li>
            <li> Smokey Black </li>
            <li> Snow Polar </li>
            <li> Teddy Brown </li>
    </ul>
    """

    response =
      handle(request)
      |> remove_whitespace()

    assert response == remove_whitespace(result)

  end

  defp remove_whitespace(text) do
    String.replace(text, ~r{\s}, "")
  end
end
