defmodule HttpServer.Handler.Test do
  use ExUnit.Case

  test "simple get request" do
    request = """
    GET /snacks HTTP/1.1
    Host: pantry.com
    User-Agent: SnackBrowser/1.0
    Accept: */*

    """

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 22

    Twiglets, Crisps, Nuts
    """

    assert HttpServer.Handler.handle(request) == expected_response
  end
end
