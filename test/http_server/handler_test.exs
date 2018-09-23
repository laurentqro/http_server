defmodule HttpServer.Handler.Test do
  use ExUnit.Case

  test "HEAD request" do
    request = """
    HEAD / HTTP/1.1
    """

    expected_response = """
    HTTP/1.1 200 OK
    """

    assert HttpServer.Handler.handle(request) == expected_response
  end
end
