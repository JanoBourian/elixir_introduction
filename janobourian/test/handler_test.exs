defmodule HandlerTest do
  use ExUnit.Case
  import Janobourian.Handler, only: [handle: 1]

  test "GET /wildthings" do
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

  test "GET /api/bears" do
    request = """
    GET /api/bears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = handle(request)

    assert response == """
    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: 183

    [{"hibernating":true,"type":"Brown","name":"Teddy","id":1},{"hibernating":false,"type":"Black","name":"Smokey","id":2},{"hibernating":false,"type":"Brown","name":"Paddington","id":3}]
    """
  end

end
