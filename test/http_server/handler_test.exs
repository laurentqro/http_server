defmodule HttpServer.Handler.Test do
  use ExUnit.Case

  test "simple get request" do
    request = """
    GET /file1 HTTP/1.1

    """

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 14

    file1 contents
    """

    assert HttpServer.Handler.handle(request) == expected_response
  end
end
