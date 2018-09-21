defmodule HttpServer.Parser.Test do
  use ExUnit.Case

  test "parses the HTTP method" do
    request = """
    GET /hello-world.txt HTTP/1.1
    """

    conn = HttpServer.Parser.parse(request)

    assert conn.method == "GET"
  end

  test "parses the request path" do
    request = """
    GET /hello-world.txt HTTP/1.1
    """

    conn = HttpServer.Parser.parse(request)

    assert conn.path == "/hello-world.txt"
  end

  test "parses the request body" do
    request = """
    PATCH /hello-world.txt HTTP/1.1
    Content-Length: 11\r
    \r
    goodbye world
    """

    conn = HttpServer.Parser.parse(request)

    assert conn.req_body == "goodbye world\n"
  end
end
